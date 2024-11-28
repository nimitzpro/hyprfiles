import BezierEasing from 'bezier-easing'
import { Hct } from '@material/material-color-utilities'

// Computes a value (based on percentage) using a cubic-bezier easing function.
// The result is scaled.
//
// Build your bezier at https://cubic-bezier.com.
function cubicBezier(
  coordinates: [number, number, number, number],
  tone: number,
  scale = [0, 1]
) {
  const easingFn = BezierEasing(...coordinates)
  const percent = easingFn(tone / 100)
  const factor = scale[1] - scale[0]
  let f = scale[0] + percent * factor
  return Number(f.toFixed(2))
}

// Computes the alpha (opacity) for apps like foot, alacritty
export function computeAlpha(hct: Hct, isDark: boolean): number {
  return cubicBezier(
    [.6, .17, .44, .91], // to view, https://cubic-bezier.com/#.6,.17,.44,.91
    hct.tone,
    isDark ? [0.4, 0.65] : [0.6, 0.8]
  )
}
