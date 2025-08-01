const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#1b1b13", /* black   */
  [1] = "#7EA130", /* red     */
  [2] = "#76884B", /* green   */
  [3] = "#8FA44A", /* yellow  */
  [4] = "#61718F", /* blue    */
  [5] = "#8C839E", /* magenta */
  [6] = "#9F9D9D", /* cyan    */
  [7] = "#d6d4d9", /* white   */

  /* 8 bright colors */
  [8]  = "#959497",  /* black   */
  [9]  = "#7EA130",  /* red     */
  [10] = "#76884B", /* green   */
  [11] = "#8FA44A", /* yellow  */
  [12] = "#61718F", /* blue    */
  [13] = "#8C839E", /* magenta */
  [14] = "#9F9D9D", /* cyan    */
  [15] = "#d6d4d9", /* white   */

  /* special colors */
  [256] = "#1b1b13", /* background */
  [257] = "#d6d4d9", /* foreground */
  [258] = "#d6d4d9",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
