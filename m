Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 09:31:00 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:15113
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225557AbTIWIat>; Tue, 23 Sep 2003 09:30:49 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1iZL-0006bm-00; Tue, 23 Sep 2003 10:30:47 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1iZL-0003ly-00; Tue, 23 Sep 2003 10:30:47 +0200
Date: Tue, 23 Sep 2003 10:30:47 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] PMAG-AA Hardware cursor support
Message-ID: <20030923083047.GT13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030921212313.GN13578@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030922194304.25762C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030922194304.25762C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 21 Sep 2003, Thiemo Seufer wrote:
> 
> > @@ -37,8 +37,7 @@ static inline void bt455_read_cmap_entry
> >  					 u8* red, u8* green, u8* blue)
> >  {
> >  	bt455_select_reg(regs, cr);
> > -	
> > -	mb();
> > +	rmb();
> >  	*red = regs->addr_cmap_data & 0x0f;
> >  	rmb();
> >  	*green = regs->addr_cmap_data & 0x0f;
> 
>  I do think it has to be an mb() as the first access is a write and the
> second one is a read. 
> 
>  You may also consider using ISO C initializers for struct members -- I
> can do the conversion myself, but since you are actively working on the
> code right now, I guess it might give you an unnecessary burden of chasing
> the changing master sources.

An updated patch is appended.


Thiemo


diff -abdpruNPX /bigdisk/src/dontdiff linux-orig/drivers/video/bt431.h linux/drivers/video/bt431.h
--- linux-orig/drivers/video/bt431.h	Tue Sep 16 17:05:14 2003
+++ linux/drivers/video/bt431.h	Sun Sep 21 22:39:12 2003
@@ -73,22 +73,42 @@ static inline u8 bt431_get_value(u16 val
 
 static inline void bt431_select_reg(struct bt431_regs *regs, int ir)
 {
+	/*
+	 * The compiler splits the write in two bytes without these
+	 * helper variables.
+	 */
+	volatile u16 *lo = &(regs->addr_lo);
+	volatile u16 *hi = &(regs->addr_hi);
+
 	mb();
-	regs->addr_lo = bt431_set_value(ir & 0xff);
-	regs->addr_hi = bt431_set_value((ir >> 8) & 0xff);
+	*lo = bt431_set_value(ir & 0xff);
+	wmb();
+	*hi = bt431_set_value((ir >> 8) & 0xff);
 }
 
 /* Autoincrement read/write. */
 static inline u8 bt431_read_reg_inc(struct bt431_regs *regs)
 {
+	/*
+	 * The compiler splits the write in two bytes without the
+	 * helper variable.
+	 */
+	volatile u16 *r = &(regs->addr_reg);
+
 	mb();
-	return bt431_get_value(regs->addr_reg);
+	return bt431_get_value(*r);
 }
 
 static inline void bt431_write_reg_inc(struct bt431_regs *regs, u8 value)
 {
+	/*
+	 * The compiler splits the write in two bytes without the
+	 * helper variable.
+	 */
+	volatile u16 *r = &(regs->addr_reg);
+
 	mb();
-	regs->addr_reg = bt431_set_value(value);
+	*r = bt431_set_value(value);
 }
 
 static inline u8 bt431_read_reg(struct bt431_regs *regs, int ir)
@@ -97,23 +117,35 @@ static inline u8 bt431_read_reg(struct b
 	return bt431_read_reg_inc(regs);
 }
 
-static inline void bt431_write_reg(struct bt431_regs *regs, int ir, u16 value)
+static inline void bt431_write_reg(struct bt431_regs *regs, int ir, u8 value)
 {
 	bt431_select_reg(regs, ir);
 	bt431_write_reg_inc(regs, value);
 }
 
-/* Autoincremented read/write for the cursor map */
+/* Autoincremented read/write for the cursor map. */
 static inline u16 bt431_read_cmap_inc(struct bt431_regs *regs)
 {
+	/*
+	 * The compiler splits the write in two bytes without the
+	 * helper variable.
+	 */
+	volatile u16 *r = &(regs->addr_cmap);
+
 	mb();
-	return regs->addr_cmap;
+	return *r;
 }
 
 static inline void bt431_write_cmap_inc(struct bt431_regs *regs, u16 value)
 {
+	/*
+	 * The compiler splits the write in two bytes without the
+	 * helper variable.
+	 */
+	volatile u16 *r = &(regs->addr_cmap);
+
 	mb();
-	regs->addr_cmap = value;
+	*r = value;
 }
 
 static inline u16 bt431_read_cmap(struct bt431_regs *regs, int cr)
@@ -130,10 +162,9 @@ static inline void bt431_write_cmap(stru
 
 static inline void bt431_enable_cursor(struct bt431_regs *regs)
 {
-/*	bt431_write_reg(regs, BT431_REG_CMD,
+	bt431_write_reg(regs, BT431_REG_CMD,
 			BT431_CMD_CURS_ENABLE | BT431_CMD_OR_CURSORS
 			| BT431_CMD_4_1_MUX | BT431_CMD_THICK_1);
-*/	bt431_write_reg(regs, BT431_REG_CMD, BT431_CMD_CURS_ENABLE);
 }
 
 static inline void bt431_erase_cursor(struct bt431_regs *regs)
@@ -166,64 +197,40 @@ static inline void bt431_position_cursor
 	bt431_write_reg_inc(regs, (y >> 8) & 0x0f); /* BT431_REG_CYHI */
 }
 
-/*u16 _bt431_default_cursor[64 * 8] = {
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0xffff, 0, 0, 0, 0, 0, 0, 0,
-	0,
-};
-*/
-static inline void bt431_load_cursor_sprite(struct bt431_regs *regs)
+static inline void bt431_set_font(struct bt431_regs *regs, u8 fgc,
+				  u16 width, u16 height)
 {
 	int i;
+	u16 fgp = fgc ? 0xffff : 0x0000;
+	u16 bgp = fgc ? 0x0000 : 0xffff;
 
 	bt431_select_reg(regs, BT431_REG_CRAM_BASE);
-	for (i = 0; i < 64 * 8; i++)
-		bt431_write_cmap_inc(regs, ((i < 16 * 8) && (i % 8)) ? 0xffff : 0);
+	for (i = BT431_REG_CRAM_BASE; i <= BT431_REG_CRAM_END; i++) {
+		u16 value;
+
+		if (height << 6 <= i << 3)
+			value = bgp;
+		else if (width <= i % 8 << 3)
+			value = bgp;
+		else if (((width >> 3) & 0xffff) > i % 8)
+			value = fgp;
+		else
+			value = fgp & ~(bgp << (width % 8 << 1));
+
+		bt431_write_cmap_inc(regs, value);
+	}
 }
 
 static inline void bt431_init_cursor(struct bt431_regs *regs)
 {
-	bt431_write_reg(regs, BT431_REG_CMD,
-			BT431_CMD_CURS_ENABLE | BT431_CMD_OR_CURSORS
-			| BT431_CMD_4_1_MUX | BT431_CMD_THICK_1);
-
-	/* home cursor */
-#if 0
-	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_CXLO */
-	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_CXHI */
-	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_CYLO */
-	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_CYHI */
-#endif
-	bt431_write_reg_inc(regs, 0x80); /* BT431_REG_CXLO */
-	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_CXHI */
-	bt431_write_reg_inc(regs, 0x80); /* BT431_REG_CYLO */
-	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_CYHI */
-
 	/* no crosshair window */
+	bt431_select_reg(regs, BT431_REG_WXLO);
 	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WXLO */
 	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WXHI */
 	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WYLO */
 	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WYHI */
-//	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WWLO */
-	bt431_write_reg_inc(regs, 0x01); /* BT431_REG_WWLO */
+	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WWLO */
 	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WWHI */
-//	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WHLO */
-	bt431_write_reg_inc(regs, 0x01); /* BT431_REG_WHLO */
+	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WHLO */
 	bt431_write_reg_inc(regs, 0x00); /* BT431_REG_WHHI */
-
-	bt431_load_cursor_sprite(regs);
 }
diff -abdpruNPX /bigdisk/src/dontdiff linux-orig/drivers/video/bt455.h linux/drivers/video/bt455.h
--- linux-orig/drivers/video/bt455.h	Tue Sep 16 17:05:14 2003
+++ linux/drivers/video/bt455.h	Tue Sep 23 10:26:53 2003
@@ -37,7 +37,6 @@ static inline void bt455_read_cmap_entry
 					 u8* red, u8* green, u8* blue)
 {
 	bt455_select_reg(regs, cr);
-	
 	mb();
 	*red = regs->addr_cmap_data & 0x0f;
 	rmb();
@@ -50,7 +49,6 @@ static inline void bt455_write_cmap_entr
 					  u8 red, u8 green, u8 blue)
 {
 	bt455_select_reg(regs, cr);
-
 	wmb();
 	regs->addr_cmap_data = red & 0x0f;
 	wmb();
@@ -59,10 +57,11 @@ static inline void bt455_write_cmap_entr
 	regs->addr_cmap_data = blue & 0x0f;
 }
 
-static inline void bt455_write_ovly_entry(struct bt455_regs *regs,
+static inline void bt455_write_ovly_entry(struct bt455_regs *regs, int cr,
 					  u8 red, u8 green, u8 blue)
 {
-	mb();
+	bt455_select_reg(regs, cr);
+	wmb();
 	regs->addr_ovly = red & 0x0f;
 	wmb();
 	regs->addr_ovly = green & 0x0f;
@@ -82,10 +81,15 @@ static inline void bt455_set_cursor(stru
 
 static inline void bt455_erase_cursor(struct bt455_regs *regs)
 {
-//	bt455_write_cmap_entry(regs, 8, 0x00, 0x00, 0x00);
-//	bt455_write_cmap_entry(regs, 9, 0x00, 0x00, 0x00);
-	bt455_write_cmap_entry(regs, 8, 0x03, 0x03, 0x03);
-	bt455_write_cmap_entry(regs, 9, 0x07, 0x07, 0x07);
+	/* bt455_write_cmap_entry(regs, 8, 0x00, 0x00, 0x00); */
+	/* bt455_write_cmap_entry(regs, 9, 0x00, 0x00, 0x00); */
+	bt455_write_ovly_entry(regs, 8, 0x03, 0x03, 0x03);
+	bt455_write_ovly_entry(regs, 9, 0x07, 0x07, 0x07);
 
-	bt455_write_ovly_entry(regs, 0x09, 0x09, 0x09);
+	wmb();
+	regs->addr_ovly = 0x09;
+	wmb();
+	regs->addr_ovly = 0x09;
+	wmb();
+	regs->addr_ovly = 0x09;
 }
diff -abdpruNPX /bigdisk/src/dontdiff linux-orig/drivers/video/pmag-aa-fb.c linux/drivers/video/pmag-aa-fb.c
--- linux-orig/drivers/video/pmag-aa-fb.c	Tue Sep 16 17:05:14 2003
+++ linux/drivers/video/pmag-aa-fb.c	Tue Sep 23 10:26:52 2003
@@ -13,10 +13,14 @@
  *	Public License.  See the file COPYING in the main directory of this
  *	archive for more details.
  *
- *	Version 0.01 2002/09/28 first try to get a PMAG-AA running
+ *	2002-09-28  Karsten Merker <merker@linuxtag.org>
+ *		Version 0.01: First try to get a PMAG-AA running.
  * 
- *	2003/02/24  Thiemo Seufer  <seufer@csv.ica.uni-stuttgart.de>
- *		Code cleanup.
+ *	2003-02-24  Thiemo Seufer  <seufer@csv.ica.uni-stuttgart.de>
+ *		Version 0.02: Major code cleanup.
+ *
+ *	2003-09-21  Thiemo Seufer  <seufer@csv.ica.uni-stuttgart.de>
+ *		Hardware cursor support.
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -30,22 +34,26 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/fb.h>
+#include <linux/console.h>
 
 #include <asm/bootinfo.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/tc.h>
 
 #include <video/fbcon.h>
-#include <video/fbcon-mfb.h>
 #include <video/fbcon-cfb8.h>
 
 #include "bt455.h"
 #include "bt431.h"
 
 /* Version information */
-#define DRIVER_VERSION "v0.02"
+#define DRIVER_VERSION "0.02"
 #define DRIVER_AUTHOR "Karsten Merker <merker@linuxtag.org>"
-#define DRIVER_DESC "PMAG-AA Framebuffer Driver"
+#define DRIVER_DESCRIPTION "PMAG-AA Framebuffer Driver"
+
+/* Prototypes */
+static int aafb_set_var(struct fb_var_screeninfo *var, int con,
+			struct fb_info *info);
 
 /*
  * Bt455 RAM DAC register base offset (rel. to TC slot base address).
@@ -63,9 +71,23 @@
  */
 #define PMAG_AA_ONBOARD_FBMEM_OFFSET	0x200000
 
+struct aafb_cursor {
+	struct timer_list timer;
+	int enable;
+	int on;
+	int vbl_cnt;
+	int blink_rate;
+	u16 x, y, width, height;
+};
+
+#define CURSOR_TIMER_FREQ	(HZ / 50)
+#define CURSOR_BLINK_RATE	(20)
+#define CURSOR_DRAW_DELAY	(2)
+
 struct aafb_info {
 	struct fb_info info;
 	struct display disp;
+	struct aafb_cursor cursor;
 	struct bt455_regs *bt455;
 	struct bt431_regs *bt431;
 	unsigned long fb_start;
@@ -81,57 +103,174 @@ static struct aafb_info my_fb_info[3];
 static struct aafb_par {
 } current_par;
 
-static int currcon = 0;
+static int currcon = -1;
 
-static void aafb_get_par(struct aafb_par *par)
+static void aafb_set_cursor(struct aafb_info *info, int on)
 {
-	*par = current_par;
+	struct aafb_cursor *c = &info->cursor;
+
+	if (on) {
+		bt431_position_cursor(info->bt431, c->x, c->y);
+		bt431_enable_cursor(info->bt431);
+	} else
+		bt431_erase_cursor(info->bt431);
 }
 
-static void aafb_encode_fix(struct fb_fix_screeninfo *fix,
-			    struct aafb_par *par, struct aafb_info *info)
+static void aafbcon_cursor(struct display *disp, int mode, int x, int y)
 {
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, "PMAG-AA");
+	struct aafb_info *info = (struct aafb_info *)disp->fb_info;
+	struct aafb_cursor *c = &info->cursor;
 
-	fix->smem_start = info->fb_start;
-	fix->smem_len = info->fb_size;
-	fix->type = FB_TYPE_PACKED_PIXELS;
-	fix->visual = FB_VISUAL_MONO10;
-	fix->line_length = info->fb_line_length;
-	fix->accel = FB_ACCEL_NONE;
+	x *= fontwidth(disp);
+	y *= fontheight(disp);
+
+	if (c->x == x && c->y == y && (mode == CM_ERASE) == !c->enable)
+		return;
+
+	c->enable = 0;
+	if (c->on)
+		aafb_set_cursor(info, 0);
+	c->x = x - disp->var.xoffset;
+	c->y = y - disp->var.yoffset;
+
+	switch (mode) {
+		case CM_ERASE:
+			c->on = 0;
+			break;
+		case CM_DRAW:
+		case CM_MOVE:
+			if (c->on)
+				aafb_set_cursor(info, c->on);
+			else
+				c->vbl_cnt = CURSOR_DRAW_DELAY;
+			c->enable = 1;
+			break;
+	}
+}
+
+static int aafbcon_set_font(struct display *disp, int width, int height)
+{
+	struct aafb_info *info = (struct aafb_info *)disp->fb_info;
+	struct aafb_cursor *c = &info->cursor;
+	u8 fgc = ~attr_bgcol_ec(disp, disp->conp);
+
+	if (width > 64 || height > 64 || width < 0 || height < 0)
+		return -EINVAL;
+
+	c->height = height;
+	c->width = width;
+
+	bt431_set_font(info->bt431, fgc, width, height);
+
+	return 1;
+}
+
+static void aafb_cursor_timer_handler(unsigned long data)
+{
+	struct aafb_info *info = (struct aafb_info *)data;
+	struct aafb_cursor *c = &info->cursor;
+
+	if (!c->enable)
+		goto out;
+
+	if (c->vbl_cnt && --c->vbl_cnt == 0) {
+		c->on ^= 1;
+		aafb_set_cursor(info, c->on);
+		c->vbl_cnt = c->blink_rate;
+	}
+
+out:
+	c->timer.expires = jiffies + CURSOR_TIMER_FREQ;
+	add_timer(&c->timer);
+}
+
+static void __init aafb_cursor_init(struct aafb_info *info)
+{
+	struct aafb_cursor *c = &info->cursor;
+
+	c->enable = 1;
+	c->on = 1;
+	c->x = c->y = 0;
+	c->width = c->height = 0;
+	c->vbl_cnt = CURSOR_DRAW_DELAY;
+	c->blink_rate = CURSOR_BLINK_RATE;
+
+	init_timer(&c->timer);
+	c->timer.data = (unsigned long)info;
+	c->timer.function = aafb_cursor_timer_handler;
+	mod_timer(&c->timer, jiffies + CURSOR_TIMER_FREQ);
+}
+
+static void __exit aafb_cursor_exit(struct aafb_info *info)
+{
+	struct aafb_cursor *c = &info->cursor;
+
+	del_timer_sync(&c->timer);
+}
+
+static struct display_switch aafb_switch8 = {
+	.setup = fbcon_cfb8_setup,
+	.bmove = fbcon_cfb8_bmove,
+	.clear = fbcon_cfb8_clear,
+	.putc = fbcon_cfb8_putc,
+	.putcs = fbcon_cfb8_putcs,
+	.revc = fbcon_cfb8_revc,
+	.cursor = aafbcon_cursor,
+	.set_font = aafbcon_set_font,
+	.clear_margins = fbcon_cfb8_clear_margins,
+	.fontwidthmask = FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+};
+
+static void aafb_get_par(struct aafb_par *par)
+{
+	*par = current_par;
 }
 
 static int aafb_get_fix(struct fb_fix_screeninfo *fix, int con,
 			struct fb_info *info)
 {
-	struct aafb_par par;
+	struct aafb_info *ip = (struct aafb_info *)info;
 
-	aafb_get_par(&par);
-	aafb_encode_fix(fix, &par, (struct aafb_info *) info);
+	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+	strcpy(fix->id, "PMAG-AA");
+	fix->smem_start = ip->fb_start;
+	fix->smem_len = ip->fb_size;
+	fix->type = FB_TYPE_PACKED_PIXELS;
+	fix->ypanstep = 1;
+	fix->ywrapstep = 1;
+	fix->visual = FB_VISUAL_MONO10;
+	fix->line_length = 1280;
+	fix->accel = FB_ACCEL_NONE;
 
 	return 0;
 }
 
-static void aafb_set_disp(int con, struct fb_info *info)
+static void aafb_set_disp(struct display *disp, int con,
+			  struct aafb_info *info)
 {
 	struct fb_fix_screeninfo fix;
-	struct display *disp = (con < 0) ? info->disp : (fb_display + con);
 
-	aafb_get_fix(&fix, con, info);
+	disp->fb_info = &info->info;
+	aafb_set_var(&disp->var, con, &info->info);
+	if (disp->conp && disp->conp->vc_sw && disp->conp->vc_sw->con_cursor)
+		disp->conp->vc_sw->con_cursor(disp->conp, CM_ERASE);
+	disp->dispsw = &aafb_switch8;
+	disp->dispsw_data = 0;
 
-	disp->screen_base = (char *) fix.smem_start;
+	aafb_get_fix(&fix, con, &info->info);
+	disp->screen_base = (u8 *) fix.smem_start;
 	disp->visual = fix.visual;
 	disp->type = fix.type;
 	disp->type_aux = fix.type_aux;
 	disp->ypanstep = fix.ypanstep;
 	disp->ywrapstep = fix.ywrapstep;
-//	disp->line_length = fix.line_length;
-	disp->next_line = fix.line_length;
+	disp->line_length = fix.line_length;
+	disp->next_line = 2048;
 	disp->can_soft_blank = 1;
 	disp->inverse = 0;
-//	disp->scrollmode = SCROLL_YREDRAW;
-	disp->dispsw = &fbcon_cfb8;
+	disp->scrollmode = SCROLL_YREDRAW;
+
+	aafbcon_set_font(disp, fontwidth(disp), fontheight(disp));
 }
 
 static int aafb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
@@ -147,14 +286,38 @@ static int aafb_get_cmap(struct fb_cmap 
 static int aafb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 			 struct fb_info *info)
 {
+	u16 color[2] = {0x0000, 0x000f};
+
+	if (cmap->start == 0
+	    && cmap->len == 2
+	    && memcmp(cmap->red, color, sizeof(color)) == 0
+	    && memcmp(cmap->green, color, sizeof(color)) == 0
+	    && memcmp(cmap->blue, color, sizeof(color)) == 0
+	    && cmap->transp == NULL)
+		return 0;
+	else
 	return -EINVAL;
 }
 
+static int aafb_ioctl(struct inode *inode, struct file *file, u32 cmd,
+		      unsigned long arg, int con, struct fb_info *info)
+{
+	/* TODO: Not yet implemented */
+	return -ENOIOCTLCMD;
+}
+
 static int aafb_switch(int con, struct fb_info *info)
 {
+	struct aafb_info *ip = (struct aafb_info *)info;
+	struct display *old = (currcon < 0) ? &ip->disp : (fb_display + currcon);
+	struct display *new = (con < 0) ? &ip->disp : (fb_display + con);
+
+	if (old->conp && old->conp->vc_sw && old->conp->vc_sw->con_cursor)
+		old->conp->vc_sw->con_cursor(old->conp, CM_ERASE);
+
 	/* Set the current console. */
 	currcon = con;
-	aafb_set_disp(con, info);
+	aafb_set_disp(new, con, ip);
 
 	return 0;
 }
@@ -218,6 +381,12 @@ static int aafb_set_var(struct fb_var_sc
 
 static int aafb_update_var(int con, struct fb_info *info)
 {
+	struct aafb_info *ip = (struct aafb_info *)info;
+	struct display *disp = (con < 0) ? &ip->disp : (fb_display + con);
+
+	if (con == currcon)
+		aafbcon_cursor(disp, CM_ERASE, ip->cursor.x, ip->cursor.y);
+
 	return 0;
 }
 
@@ -229,15 +398,17 @@ static void aafb_blank(int blank, struct
 	u8 val = blank ? 0x00 : 0x0f;
 
 	bt455_write_cmap_entry(ip->bt455, 1, val, val, val);
+	aafbcon_cursor(&ip->disp, CM_ERASE, ip->cursor.x, ip->cursor.y);
 }
 
 static struct fb_ops aafb_ops = {
-	owner:THIS_MODULE,
-	fb_get_fix:aafb_get_fix,
-	fb_get_var:aafb_get_var,
-	fb_set_var:aafb_set_var,
-	fb_get_cmap:aafb_get_cmap,
-	fb_set_cmap:aafb_set_cmap
+	.owner = THIS_MODULE,
+	.fb_get_fix = aafb_get_fix,
+	.fb_get_var = aafb_get_var,
+	.fb_set_var = aafb_set_var,
+	.fb_get_cmap = aafb_get_cmap,
+	.fb_set_cmap = aafb_set_cmap,
+	.fb_ioctl = aafb_ioctl
 };
 
 static int __init init_one(int slot)
@@ -258,20 +429,6 @@ static int __init init_one(int slot)
 	ip->fb_line_length = 2048;
 
 	/*
-	 * Configure the RAM DACs.
-	 */
-// TODO
-//	bt455_erase_cursor(ip->bt455);
-//	bt455_set_cursor(ip->bt455);
-//	bt431_erase_cursor(ip->bt431);
-//	bt431_init_cursor(ip->bt431);
-//	bt431_position_cursor(ip->bt431, 16, 16);
-
-	/* Init colormap. */
-	bt455_write_cmap_entry(ip->bt455, 0, 0x00, 0x00, 0x00);
-	bt455_write_cmap_entry(ip->bt455, 1, 0x0f, 0x0f, 0x0f);
-
-	/*
 	 * Let there be consoles..
 	 */
 	strcpy(ip->info.modename, "PMAG-AA");
@@ -284,8 +441,20 @@ static int __init init_one(int slot)
 	ip->info.updatevar = &aafb_update_var;
 	ip->info.blank = &aafb_blank;
 
-	aafb_set_disp(-1, &ip->info);
-	aafb_set_var(&ip->disp.var, -1, &ip->info);
+	aafb_set_disp(&ip->disp, currcon, ip);
+
+	/*
+	 * Configure the RAM DACs.
+	 */
+	bt455_erase_cursor(ip->bt455);
+
+	/* Init colormap. */
+	bt455_write_cmap_entry(ip->bt455, 0, 0x00, 0x00, 0x00);
+	bt455_write_cmap_entry(ip->bt455, 1, 0x0f, 0x0f, 0x0f);
+
+	/* Init hardware cursor. */
+	bt431_init_cursor(ip->bt431);
+	aafb_cursor_init(ip);
 
 	/* Clear the screen. */
 	memset ((void *)ip->fb_start, 0, ip->fb_size);
@@ -293,7 +462,7 @@ static int __init init_one(int slot)
 	if (register_framebuffer(&ip->info) < 0)
 		return -EINVAL;
 
-	printk(KERN_INFO "fb%d: %s frame buffer device in TC slot %d\n",
+	printk(KERN_INFO "fb%d: %s frame buffer in TC slot %d\n",
 	       GET_FB_IDX(ip->info.node), ip->info.modename, slot);
 
 	return 0;
@@ -336,4 +505,10 @@ static void __exit pmagaafb_exit(void)
 	}
 }
 
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
+#ifdef MODULE
+module_init(pmagaafb_init);
+module_exit(pmagaafb_exit);
+#endif
