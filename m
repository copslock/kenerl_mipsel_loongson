Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 09:44:39 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:42511 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133426AbWB1JoZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 09:44:25 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id CFE4864D3D; Tue, 28 Feb 2006 09:52:04 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id F1DCB81F5; Tue, 28 Feb 2006 10:51:56 +0100 (CET)
Date:	Tue, 28 Feb 2006 09:51:56 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: drivers!
Message-ID: <20060228095156.GC13400@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220003439.GA18438@deprecation.cyrius.com> <20060227191033.GB22383@deprecation.cyrius.com> <200602280447.k1S4l64f029447@mbox02.po.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602280447.k1S4l64f029447@mbox02.po.2iij.net>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2006-02-28 13:47]:
> > Yoichi, as the maintainre of the IBM z50 support, can you comment?
> v2.6 don't include IBM z50(vr41xx) keyboard driver.
> I think it can be removed.

Ralf, please apply.


[CHAR] Remove obsolete IBM z50(vr41xx) keyboard map

Remove the keymap for the IBM z50 workpad since 2.6 doesn't include a
keyboard driver for this platform.  This also brings the linux-mips
tree in sync with mainline.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>


--- mips.git/drivers/char/Makefile	2006-02-28 00:13:54.000000000 +0000
+++ linux-2.6.git/drivers/char/Makefile	2006-02-03 03:06:52.000000000 +0000
@@ -121,8 +115,7 @@
 
 ifdef GENERATE_KEYMAP
 
-$(obj)/defkeymap.c $(obj)/qtronixmap.c $(obj)/ibm_workpad_keymap.c: \
-		$(obj)/%.c: $(src)/%.map
+$(obj)/defkeymap.c $(obj)/qtronixmap.c: $(obj)/%.c: $(src)/%.map
 	loadkeys --mktable $< > $@.tmp
 	sed -e 's/^static *//' $@.tmp > $@
 	rm $@.tmp
--- mips.git/drivers/char/ibm_workpad_keymap.map	2006-01-19 22:18:20.000000000 +0000
+++ b/drivers/char/ibm_workpad_keymap.map	2006-02-27 00:45:54.766344104 +0000
@@ -1,343 +0,0 @@
-# Keymap for IBM Workpad z50
-# US Mapping
-#
-# by Michael Klar <wyldfier@iname.com>
-#
-# This is a great big mess on account of how the Caps Lock key is handled as
-# LeftShift-RightShift.  Right shift key had to be broken out, so don't use
-# use this map file as a basis for other keyboards that don't do the same
-# thing with Caps Lock.
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-
-keymaps 0-2,4-5,8,12,32-33,36-37
-strings as usual
-
-keycode 0 = F1 F11 Console_13
-	shiftr keycode 0 = F11
-	shift shiftr keycode 0 = F11
-	control keycode 0 = F1
-	alt keycode 0 = Console_1
-	control alt keycode 0 = Console_1
-keycode 1 = F3 F13 Console_15
-	shiftr keycode 1 = F13
-	shift shiftr keycode 1 = F13
-	control keycode 1 = F3
-	alt keycode 1 = Console_3
-	control alt keycode 1 = Console_3
-keycode 2 = F5 F15 Console_17
-	shiftr keycode 2 = F15
-	shift shiftr keycode 2 = F15
-	control keycode 2 = F5
-	alt keycode 2 = Console_5
-	control alt keycode 2 = Console_5
-keycode 3 = F7 F17 Console_19
-	shiftr keycode 3 = F17
-	shift shiftr keycode 3 = F17
-	control keycode 3 = F7
-	alt keycode 3 = Console_7
-	control alt keycode 3 = Console_7
-keycode 4 = F9 F19 Console_21
-	shiftr keycode 4 = F19
-	shift shiftr keycode 4 = F19
-	control keycode 4 = F9
-	alt keycode 4 = Console_9
-	control alt keycode 4 = Console_9
-#keycode 5 is contrast down
-#keycode 6 is contrast up
-keycode 7 = F11 F11 Console_23
-	shiftr keycode 7 = F11
-	shift shiftr keycode 7 = F11
-	control keycode 7 = F11
-	alt keycode 7 = Console_11
-	control alt keycode 7 = Console_11
-keycode 8 = F2 F12 Console_14
-	shiftr keycode 8 = F12
-	shift shiftr keycode 8 = F12
-	control keycode 8 = F2
-	alt keycode 8 = Console_2
-	control alt keycode 8 = Console_2
-keycode 9 = F4 F14 Console_16
-	shiftr keycode 9 = F14
-	shift shiftr keycode 9 = F14
-	control keycode 9 = F4
-	alt keycode 9 = Console_4
-	control alt keycode 9 = Console_4
-keycode 10 = F6 F16 Console_18
-	shiftr keycode 10 = F16
-	shift shiftr keycode 10 = F16
-	control keycode 10 = F6
-	alt keycode 10 = Console_6
-	control alt keycode 10 = Console_6
-keycode 11 = F8 F18 Console_20
-	shiftr keycode 11 = F18
-	shift shiftr keycode 11 = F18
-	control keycode 11 = F8
-	alt keycode 11 = Console_8
-	control alt keycode 11 = Console_8
-keycode 12 = F10 F20 Console_22
-	shiftr keycode 12 = F20
-	shift shiftr keycode 12 = F20
-	control keycode 12 = F10
-	alt keycode 12 = Console_10
-	control alt keycode 12 = Console_10
-#keycode 13 is brightness down
-#keycode 14 is brightness up
-keycode 15 = F12 F12 Console_24
-	shiftr keycode 15 = F12
-	shift shiftr keycode 15 = F12
-	control keycode 15 = F12
-	alt keycode 15 = Console_12
-	control alt keycode 15 = Console_12
-keycode 16 = apostrophe quotedbl
-	shiftr keycode 16 = quotedbl
-	shift shiftr keycode 16 = quotedbl
-	control keycode 16 = Control_g
-	alt keycode 16 = Meta_apostrophe
-keycode 17 = bracketleft braceleft
-	shiftr keycode 17 = braceleft
-	shift shiftr keycode 17 = braceleft
-	control keycode 17 = Escape
-	alt keycode 17 = Meta_bracketleft
-keycode 18 = minus underscore backslash       
-	shiftr keycode 18 = underscore
-	shift shiftr keycode 18 = underscore
-	control keycode 18 = Control_underscore
-	shift control keycode 18 = Control_underscore
-	shiftr control keycode 18 = Control_underscore
-	shift shiftr control keycode 18 = Control_underscore
-	alt keycode 18 = Meta_minus
-keycode 19 = zero parenright braceright
-	shiftr keycode 19 = parenright
-	shift shiftr keycode 19 = parenright
-	alt keycode 19 = Meta_zero
-keycode 20 = p
-	shiftr keycode 20 = +P
-	shift shiftr keycode 20 = +p
-keycode 21 = semicolon colon
-	shiftr keycode 21 = colon
-	shift shiftr keycode 21 = colon
-	alt keycode 21 = Meta_semicolon
-keycode 22 = Up Scroll_Backward
-	shiftr keycode 22 = Scroll_Backward
-	shift shiftr keycode 22 = Scroll_Backward
-	alt keycode 22 = Prior
-keycode 23 = slash question
-	shiftr keycode 23 = question
-	shift shiftr keycode 23 = question
-	control keycode 23 = Delete
-	alt keycode 23 = Meta_slash
-
-keycode 27 = nine parenleft bracketright
-	shiftr keycode 27 = parenleft
-	shift shiftr keycode 27 = parenleft
-	alt keycode 27 = Meta_nine
-keycode 28 = o
-	shiftr keycode 28 = +O
-	shift shiftr keycode 28 = +o
-keycode 29 = l
-	shiftr keycode 29 = +L
-	shift shiftr keycode 29 = +l
-keycode 30 = period greater
-	shiftr keycode 30 = greater
-	shift shiftr keycode 30 = greater
-	control keycode 30 = Compose
-	alt keycode 30 = Meta_period
-
-keycode 32 = Left Decr_Console
-	shiftr keycode 32 = Decr_Console
-	shift shiftr keycode 32 = Decr_Console
-	alt keycode 32 = Home
-keycode 33 = bracketright braceright asciitilde      
-	shiftr keycode 33 = braceright
-	shift shiftr keycode 33 = braceright
-	control keycode 33 = Control_bracketright
-	alt keycode 33 = Meta_bracketright
-keycode 34 = equal plus
-	shiftr keycode 34 = plus
-	shift shiftr keycode 34 = plus
-	alt keycode 34 = Meta_equal
-keycode 35 = eight asterisk bracketleft
-	shiftr keycode 35 = asterisk
-	shift shiftr keycode 35 = asterisk
-	control keycode 35 = Delete
-	alt keycode 35 = Meta_eight
-keycode 36 = i
-	shiftr keycode 36 = +I
-	shift shiftr keycode 36 = +i
-keycode 37 = k
-	shiftr keycode 37 = +K
-	shift shiftr keycode 37 = +k
-keycode 38 = comma less
-	shiftr keycode 38 = less
-	shift shiftr keycode 38 = less
-	alt keycode 38 = Meta_comma
-
-keycode 40 = h
-	shiftr keycode 40 = +H
-	shift shiftr keycode 40 = +h
-keycode 41 = y
-	shiftr keycode 41 = +Y
-	shift shiftr keycode 41 = +y
-keycode 42 = six asciicircum
-	shiftr keycode 42 = asciicircum
-	shift shiftr keycode 42 = asciicircum
-	control keycode 42 = Control_asciicircum
-	alt keycode 42 = Meta_six
-keycode 43 = seven ampersand braceleft
-	shiftr keycode 43 = ampersand
-	shift shiftr keycode 43 = ampersand
-	control keycode 43 = Control_underscore
-	alt keycode 43 = Meta_seven
-keycode 44 = u
-	shiftr keycode 44 = +U
-	shift shiftr keycode 44 = +u
-keycode 45 = j
-	shiftr keycode 45 = +J
-	shift shiftr keycode 45 = +j
-keycode 46 = m
-	shiftr keycode 46 = +M
-	shift shiftr keycode 46 = +m
-keycode 47 = n
-	shiftr keycode 47 = +N
-	shift shiftr keycode 47 = +n
-
-# This is the "Backspace" key:
-keycode 49 = Delete Delete
-	shiftr keycode 49 = Delete
-	shift shiftr keycode 49 = Delete
-	control keycode 49 = BackSpace
-	alt keycode 49 = Meta_Delete
-keycode 50 = Num_Lock
-	shift keycode 50 = Bare_Num_Lock
-	shiftr keycode 50 = Bare_Num_Lock
-	shift shiftr keycode 50 = Bare_Num_Lock
-# This is the "Delete" key:
-keycode 51 = Remove
-	control alt keycode 51 = Boot
-
-keycode 53 = backslash bar
-	shiftr keycode 53 = bar
-	shift shiftr keycode 53 = bar
-	control keycode 53 = Control_backslash
-	alt keycode 53 = Meta_backslash
-keycode 54 = Return
-	alt keycode 54 = Meta_Control_m
-keycode 55 = space space           
-	shiftr keycode 55 = space
-	shift shiftr keycode 55 = space
-	control keycode 55 = nul
-	alt keycode 55 = Meta_space
-keycode 56 = g
-	shiftr keycode 56 = +G
-	shift shiftr keycode 56 = +g
-keycode 57 = t
-	shiftr keycode 57 = +T
-	shift shiftr keycode 57 = +t
-keycode 58 = five percent
-	shiftr keycode 58 = percent
-	shift shiftr keycode 58 = percent
-	control keycode 58 = Control_bracketright
-	alt keycode 58 = Meta_five
-keycode 59 = four dollar dollar
-	shiftr keycode 59 = dollar
-	shift shiftr keycode 59 = dollar
-	control keycode 59 = Control_backslash
-	alt keycode 59 = Meta_four
-keycode 60 = r
-	shiftr keycode 60 = +R
-	shift shiftr keycode 60 = +r
-keycode 61 = f
-	shiftr keycode 61 = +F
-	shift shiftr keycode 61 = +f
-	altgr keycode 61 = Hex_F
-keycode 62 = v
-	shiftr keycode 62 = +V
-	shift shiftr keycode 62 = +v
-keycode 63 = b
-	shiftr keycode 63 = +B
-	shift shiftr keycode 63 = +b
-	altgr keycode 63 = Hex_B
-
-keycode 67 = three numbersign
-	shiftr keycode 67 = numbersign
-	shift shiftr keycode 67 = numbersign
-	control keycode 67 = Escape
-	alt keycode 67 = Meta_three
-keycode 68 = e
-	shiftr keycode 68 = +E
-	shift shiftr keycode 68 = +e
-	altgr keycode 68 = Hex_E
-keycode 69 = d
-	shiftr keycode 69 = +D
-	shift shiftr keycode 69 = +d
-	altgr keycode 69 = Hex_D
-keycode 70 = c
-	shiftr keycode 70 = +C
-	shift shiftr keycode 70 = +c
-	altgr keycode 70 = Hex_C
-keycode 71 = Right Incr_Console
-	shiftr keycode 71 = Incr_Console
-	shift shiftr keycode 71 = Incr_Console
-	alt keycode 71 = End
-
-keycode 75 = two at at
-	shiftr keycode 75 = at
-	shift shiftr keycode 75 = at
-	control keycode 75 = nul
-	shift control keycode 75 = nul
-	shiftr control keycode 75 = nul
-	shift shiftr control keycode 75 = nul
-	alt keycode 75 = Meta_two
-keycode 76 = w
-	shiftr keycode 76 = +W
-	shift shiftr keycode 76 = +w
-keycode 77 = s
-	shiftr keycode 77 = +S
-	shift shiftr keycode 77 = +s
-keycode 78 = x
-	shiftr keycode 78 = +X
-	shift shiftr keycode 78 = +x
-keycode 79 = Down Scroll_Forward
-	shiftr keycode 79 = Scroll_Forward
-	shift shiftr keycode 79 = Scroll_Forward
-	alt keycode 79 = Next
-keycode 80 = Escape Escape
-	shiftr keycode 80 = Escape
-	shift shiftr keycode 80 = Escape
-	alt keycode 80 = Meta_Escape
-keycode 81 = Tab Tab             
-	shiftr keycode 81 = Tab
-	shift shiftr keycode 81 = Tab
-	alt keycode 81 = Meta_Tab
-keycode 82 = grave asciitilde
-	shiftr keycode 82 = asciitilde
-	shift shiftr keycode 82 = asciitilde
-	control keycode 82 = nul
-	alt keycode 82 = Meta_grave
-keycode 83 = one exclam
-	shiftr keycode 83 = exclam
-	shift shiftr keycode 83 = exclam
-	alt keycode 83 = Meta_one
-keycode 84 = q
-	shiftr keycode 84 = +Q
-	shift shiftr keycode 84 = +q
-keycode 85 = a
-	shiftr keycode 85 = +A
-	shift shiftr keycode 85 = +a
-	altgr keycode 85 = Hex_A
-keycode 86 = z
-	shiftr keycode 86 = +Z
-	shift shiftr keycode 86 = +z
-
-# This is the windows key:
-keycode 88 = Decr_Console
-keycode 89 = Shift
-keycode 90 = Control
-keycode 91 = Control
-keycode 92 = Alt
-keycode 93 = AltGr
-keycode 94 = ShiftR
-	shift keycode 94 = Caps_Lock

-- 
Martin Michlmayr
http://www.cyrius.com/
