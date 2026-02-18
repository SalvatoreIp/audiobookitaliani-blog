#!/usr/bin/env python3
import requests
import sys
import time
import os

API_KEY = "deff90bf-09a0-4dd2-87c4-eadac5ba5024"
BASE_URL = "https://cloud.leonardo.ai/api/rest/v1"

def generate_image(prompt, output_file):
    print(f"🎨 Generating: {prompt}")
    
    response = requests.post(
        f"{BASE_URL}/generations",
        headers={
            "Authorization": f"Bearer {API_KEY}",
            "Content-Type": "application/json"
        },
        json={
            "prompt": prompt,
            "width": 1024,
            "height": 1024,
            "num_images": 1,
            "modelId": "6bef9f1b-29cb-40c7-b9df-32b51c1f67d3"
        }
    )
    
    if response.status_code != 200:
        print(f"❌ Error {response.status_code}")
        print(response.text)
        sys.exit(1)
    
    generation_id = response.json()['sdGenerationJob']['generationId']
    print(f"⏳ Generation ID: {generation_id}")
    
    for i in range(60):
        time.sleep(1)
        status_response = requests.get(
            f"{BASE_URL}/generations/{generation_id}",
            headers={"Authorization": f"Bearer {API_KEY}"}
        )
        
        if status_response.status_code == 200:
            data = status_response.json()
            if data['generations_by_pk']['status'] == 'COMPLETE':
                image_url = data['generations_by_pk']['generated_images'][0]['url']
                print(f"✅ Image ready!")
                
                img_data = requests.get(image_url).content
                os.makedirs(os.path.dirname(output_file), exist_ok=True)
                
                with open(output_file, 'wb') as f:
                    f.write(img_data)
                
                print(f"💾 Saved: {output_file} ({len(img_data)} bytes)")
                return True
        
        if i % 10 == 0 and i > 0:
            print(f"⏳ Still working... ({i}s)")
    
    print("❌ Timeout")
    return False

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: leonardo-generate.py 'prompt' output.png")
        sys.exit(1)
    
    generate_image(sys.argv[1], sys.argv[2])
