---
title: React 更新 state 中的数组
date: 2025-03-23 08:19:53
tags: [state, react, Array]
categories: React
description:
cover:
permalink:
---

## 添加和删除

```tsx
import { useState } from "react";

interface ArtistsProps {
  id: number;
  name: string;
}

function StateArray() {
  const [name, setName] = useState("");
  const [artists, setArtists] = useState<ArtistsProps[]>([]);
  return (
    <>
      <h1>振奋人心的雕塑家们：</h1>
      <input value={name} onChange={(e) => setName(e.target.value)} />
      <button
        onClick={() => {
          setArtists([...artists, { id: artists.length + 1, name: name }]); // 添加元素
        }}
      >
        添加
      </button>
      <ul>
        {artists.map((artist)=>(
            <li key={artist.id}>
                {artist.name}{' '}
                <button onClick={()=>{
                    setArtists(
                        artists.filter(a=> a.id !== artist.id)
                    );
                }}>
                    删除
                </button>
            </li>
        ))}
      </ul>
    </>
  );
}

export default StateArray;

```

## 更新数组

```tsx
import { useState } from 'react';

let initialShapes = [
  { id: 0, type: 'circle', x: 50, y: 100 },
  { id: 1, type: 'square', x: 150, y: 100 },
  { id: 2, type: 'circle', x: 250, y: 100 },
];

export default function ShapeEditor() {
  const [shapes, setShapes] = useState(
    initialShapes
  );

  function handleClick() {
    const nextShapes = shapes.map(shape => {
      if (shape.type === 'square') {
        // 不作改变
        return shape;
      } else {
        // 返回一个新的圆形，位置在下方 50px 处
        return {
          ...shape,
          y: shape.y + 50,
        };
      }
    });
    // 使用新的数组进行重渲染
    setShapes(nextShapes);
  }

  return (
    <>
      <button onClick={handleClick}>
        所有圆形向下移动！
      </button>
      {shapes.map(shape => (
        <div
          key={shape.id}
          style={{
          background: 'purple',
          position: 'absolute',
          left: shape.x,
          top: shape.y,
          borderRadius:
            shape.type === 'circle'
              ? '50%' : '',
          width: 20,
          height: 20,
        }} />
      ))}
    </>
  );
}

```
