static const char norm_fg[] = "#d6d4d9";
static const char norm_bg[] = "#1b1b13";
static const char norm_border[] = "#959497";

static const char sel_fg[] = "#d6d4d9";
static const char sel_bg[] = "#76884B";
static const char sel_border[] = "#d6d4d9";

static const char urg_fg[] = "#d6d4d9";
static const char urg_bg[] = "#7EA130";
static const char urg_border[] = "#7EA130";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
