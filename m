Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 16:34:01 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:54776 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225463AbUBEQeA>;
	Thu, 5 Feb 2004 16:34:00 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA21557;
	Fri, 6 Feb 2004 01:33:56 +0900 (JST)
Received: 4UMDO01 id i15GXuG21236; Fri, 6 Feb 2004 01:33:56 +0900 (JST)
Received: 4UMRO00 id i15GXt416468; Fri, 6 Feb 2004 01:33:55 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Fri, 6 Feb 2004 01:33:46 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Added keymap of Victor MP-C30x
Message-Id: <20040206013346.15d4d82a.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for keymap of Victor MP-30x.
Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux-orig/arch/mips/config-shared.in	Fri Jan 16 01:18:59 2004
+++ linux/arch/mips/config-shared.in	Fri Feb  6 00:59:57 2004
@@ -697,7 +697,6 @@
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
-   define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_SCSI n
 fi
 if [ "$CONFIG_ZAO_CAPCELLA" = "y" ]; then
diff -urN -X dontdiff linux-orig/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-orig/drivers/char/Makefile	Fri Jan 23 21:13:49 2004
+++ linux/drivers/char/Makefile	Fri Feb  6 00:59:57 2004
@@ -51,6 +51,9 @@
     ifeq ($(CONFIG_IBM_WORKPAD),y)
       KEYMAP = ibm_workpad_keymap.o
     endif
+    ifeq ($(CONFIG_VICTOR_MPC30X),y)
+      KEYMAP = victor_mpc30x_keymap.o
+    endif
     KEYBD    = vr41xx_keyb.o
   endif
 endif
@@ -357,4 +360,7 @@
 	set -e ; loadkeys --mktable $< | sed -e 's/^static *//' > $@
 
 ibm_workpad_keymap.c: ibm_workpad_keymap.map
+	set -e ; loadkeys --mktable $< | sed -e 's/^static *//' > $@
+
+victor_mpc30x_keymap.c: victor_mpc30x_keymap.map
 	set -e ; loadkeys --mktable $< | sed -e 's/^static *//' > $@
diff -urN -X dontdiff linux-orig/drivers/char/victor_mpc30x_keymap.map linux/drivers/char/victor_mpc30x_keymap.map
--- linux-orig/drivers/char/victor_mpc30x_keymap.map	Thu Jan  1 09:00:00 1970
+++ linux/drivers/char/victor_mpc30x_keymap.map	Fri Feb  6 00:59:57 2004
@@ -0,0 +1,102 @@
+# Victor Interlink MP-C303/304 keyboard keymap
+#
+# Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+keymaps 0-1,4-5,8-9,12
+alt_is_meta
+strings as usual
+compose as usual for "iso-8859-1"
+
+# First line
+keycode 89 = Escape
+keycode  9 = Delete
+
+# 2nd line
+keycode 73 = one              exclam
+keycode 18 = two              quotedbl
+keycode 92 = three            numbersign
+	control	keycode 92 = Escape
+keycode 53 = four             dollar
+	control	keycode 53 = Control_backslash
+keycode 21 = five             percent
+	control	keycode 21 = Control_bracketright
+keycode 50 = six              ampersand
+	control	keycode 50 = Control_underscore
+keycode 48 = seven            apostrophe
+keycode 51 = eight            parenleft
+keycode 16 = nine             parenright
+keycode 80 = zero             asciitilde
+	control	keycode 80 = nul
+keycode 49 = minus            equal
+keycode 30 = asciicircum      asciitilde
+	control	keycode 30 = Control_asciicircum
+keycode  5 = backslash        bar
+	control	keycode  5 = Control_backslash
+keycode 13 = BackSpace
+# 3rd line
+keycode 57 = Tab
+keycode 74 = q
+keycode 26 = w
+keycode 81 = e
+keycode 29 = r
+keycode 37 = t
+keycode 45 = y
+keycode 72 = u
+keycode 24 = i
+keycode 32 = o
+keycode 41 = p
+keycode  1 = at               grave
+	control	keycode  1 = nul
+keycode 54 = bracketleft      braceleft
+keycode 63 = Return
+	alt	keycode 63 = Meta_Control_m
+# 4th line
+keycode 23 = Caps_Lock
+keycode 34 = a
+keycode 66 = s
+keycode 52 = d
+keycode 20 = f
+keycode 84 = g
+keycode 67 = h
+keycode 64 = j
+keycode 17 = k
+keycode 83 = l
+keycode 22 = semicolon        plus
+keycode 61 = colon            asterisk
+	control keycode 61 = Control_g
+keycode 65 = bracketright     braceright
+	control	keycode 65 = Control_bracketright
+# 5th line
+keycode 91 = Shift
+keycode 76 = z
+keycode 68 = x
+keycode 28 = c
+keycode 36 = v
+keycode 44 = b
+keycode 19 = n
+keycode 27 = m
+keycode 35 = comma            less
+keycode  3 = period           greater
+	control	keycode  3 = Compose
+keycode 38 = slash            question
+	control	keycode 38 = Delete
+	shift	control	keycode 38 = Delete
+keycode  6 = backslash        underscore
+	control	keycode  6 = Control_backslash
+keycode 55 = Up
+	alt keycode 55 = PageUp
+keycode 14 = Shift
+# 6th line
+keycode 56 = Control
+keycode 42 = Alt
+keycode 33 = space
+	control	keycode 33 = nul
+keycode  7 = Left
+	alt keycode  7 = Home
+keycode 31 = Down
+	alt keycode 31 = PageDown
+keycode 47 = Right
+	alt keycode 47 = End
