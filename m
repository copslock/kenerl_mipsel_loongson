Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1AIOqw20653
	for linux-mips-outgoing; Sun, 10 Feb 2002 10:24:52 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1AIOV920649
	for <linux-mips@oss.sgi.com>; Sun, 10 Feb 2002 10:24:31 -0800
Received: from post.webmailer.de ([192.67.198.70]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA29833
	for <linux-mips@oss.sgi.com>; Sun, 10 Feb 2002 09:20:03 -0800 (PST)
	mail_from (karsten@excalibur.cologne.de)
Received: from excalibur.cologne.de (p50851953.dip.t-dialin.net [80.133.25.83])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id SAA18143
	for <linux-mips@oss.sgi.com>; Sun, 10 Feb 2002 18:10:42 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16ZxbK-0000Am-00
	for <linux-mips@oss.sgi.com>; Sun, 10 Feb 2002 18:17:18 +0100
Date: Sun, 10 Feb 2002 18:17:18 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: DECstation keyboard mappings and XFree
Message-ID: <20020210181718.A641@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo everybody,

I have modified the keycode remapping table in drivers/tc/lk201-remap.c
to deliver PC compatible keycodes. Aim of this modification is easier
use of XFree86 on DECstations (with the standard PC-keyboard map) and
the possibility to use existing loadable national keymaps for i386.
In theory, this should work, in practice, it does not :-(.
I have encountered several problems when running the new remapping table
with a standard i386 us.kmap.gz:
- the "Alt Function" keys on an LK401 seem to deliver no keypress event
  (same behaviour with the original DECstation mapping, so this
  seems to be a generic problem. Does the LK401 need a particular
  initialization to use these keys (which do not exist on an LK201)?
- When running in console mode, everything besides console switching
  (because of the missing ALT-keycode) and activating NumLock (keypad
  is always in cursor mode) works. In XFree86 the normal character 
  keys and the main keyboard number keys work fine, but cursor keys,
  the Del/Insert/Pos1/End/etc. block and the numeric keyblock do not 
  work at all or deliver wrong keycodes.

I would be very grateful if somebody could give me a hint about the
reason for this behaviour, the modified lk201-remap.c is attached to
this mail.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--h31gzZEtNLTqOjlF
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="lk201-remap.c"

/*
 * PC-compatible keyboard mappings for DEC LK201/401/501 keyboards
 * 2002/02/09 by Karsten Merker <merker@linuxtag.org>,
 * based on the layout of the original lk201-remap.c written 
 * 17.05.99 by Michael Engel (engel@unix-ag.org).
 * This file is subject to the terms and conditions of the GNU General 
 * Public License, version 2. See the file "COPYING" in the main 
 * directory of this archive for more details.
 *
 * Rationale:
 *
 * DEC US keyboards generate keycodes in the range 0x55 - 0xfb
 *
 * The (historically PC-centric) Linux keycodes have to be in the 
 * range 0x00-0x7f, so the raw keycodes from the keyboard have to 
 * be remapped appropriately.
 *
 * This remapping table in contrast to the original lk201-remap.c (which
 * numbered the keys by their position from top left to lower right)
 * delivers PC-compatible keycodes.
 *
 * Relocated keys (from a PC-keyboard point of view):
 * SysReq/ScrollLock/Pause are on F13/F14/Help
 * Pos1/End are on Find/Select
 * ESC is on Do
 * LeftPenguin/RightPenguin are on LeftCompose/RightCompose
 * Menu/RightControl are on F17/F18
 * The numeric keypad has PC-like layout
 */

unsigned char scancodeRemap[256] = {
/* ----- 								*/
/*  0 */ 0,		0,		0,		0,
/* ----- 								*/
/*  4 */ 0,		0,		0,		0,
/* ----- 								*/
/*  8 */ 0,		0,		0,		0,
/* ----- 								*/
/*  c */ 0,		0,		0,		0,
/* ----- 								*/
/* 10 */ 0,		0,		0,		0,
/* ----- 								*/
/* 14 */ 0,		0,		0,		0,
/* ----- 								*/
/* 18 */ 0,		0,		0,		0,
/* ----- 								*/
/* 1c */ 0,		0,		0,		0,
/* ----- 								*/
/* 20 */ 0,		0,		0,		0,
/* ----- 								*/
/* 24 */ 0,		0,		0,		0,
/* ----- 								*/
/* 28 */ 0,		0,		0,		0,
/* ----- 								*/
/* 2c */ 0,		0,		0,		0,
/* ----- 								*/
/* 30 */ 0,		0,		0,		0,
/* ----- 								*/
/* 34 */ 0,		0,		0,		0,
/* ----- 								*/
/* 38 */ 0,		0,		0,		0,
/* ----- 								*/
/* 3c */ 0,		0,		0,		0,
/* ----- 								*/
/* 40 */ 0,		0,		0,		0,
/* ----- 								*/
/* 44 */ 0,		0,		0,		0,
/* ----- 								*/
/* 48 */ 0,		0,		0,		0,
/* ----- 								*/
/* 4c */ 0,		0,		0,		0,
/* ----- 								*/
/* 50 */ 0,		0,		0,		0,
/* ----- 	 	   		F1		F2 		*/
/* 54 */ 0,		0,		59,  		60,
/* ----- F3		F4		F5				*/
/* 58 */ 61,  		62,		63,		0,
/* ----- 								*/
/* 5c */ 0,		0,		0,		0,
/* ----- 								*/
/* 60 */ 0,		0,		0,		0,
/* ----- F6		F7		F8		F9		*/
/* 64 */ 64,		65,		66,		67, 
/* ----- F10								*/
/* 68 */ 68,		0,		0,		0,
/* ----- 								*/
/* 6c */ 0,		0,		0,		0,
/* ----- 		F11   		F12		F13/SYSREQ	*/
/* 70 */ 0,		87,  		88,		99,
/* ----- F14/SCR.LOCK							*/
/* 74 */ 70,		0,		0,		0,
/* ----- 								*/
/* 78 */ 0,		0,		0,		0,
/* ----- HELP/PAUSE	DO/ESC						*/
/* 7c */ 119,		1,		0,		0,
/* ----- F17/MENU	F18/R.CTRL	F19		F20		*/
/* 80 */ 127,		97,		0,		0,
/* ----- 								*/
/* 84 */ 0,		0,		0,		0,
/* ----- 				FIND/POS1	INSERT		*/
/* 88 */ 0,		0,		102,		110,
/* ----- REMOVE		SELECT/END	PREV/PAGEUP	NEXT/PAGEDOWN	*/
/* 8c */ 111,		107,		104,		109,
/* ----- 				KP 0				*/
/* 90 */ 0,		0,		82,		0,
/* ----- KP .		KP ENTER	KP 1		KP 2		*/
/* 94 */ 83,		96,		79,		80,
/* ----- KP 3		KP 4		KP 5		KP 6		*/
/* 98 */ 81,		75,		76,		77,
/* ----- KP ,/KP +	KP 7		KP 8		KP 9		*/
/* 9c */ 78,		71,		72,		73,
/* ----- KP -/KP+	KP F1/NUM LCK	KP F2/KP /	KP F3/KP *	*/
/* a0 */ 78,		69,		98,		55,
/* ----- KP F4/KP -					LEFT		*/
/* a4 */ 74,		0,		0,		105,
/* ----- RIGHT		DOWN		UP		SHIFT Rt	*/
/* a8 */ 106,		108, 		103,		54,
/* ----- ALT		R.COMP/R.TUX	SHIFT		CONTROL		*/
/* ac */ 56,		126,		42,		29,
/* ----- CAPS		L.COMP/L.TUX	ALT Rt				*/
/* b0 */ 58,		125,		100,		0,
/* ----- 								*/
/* b4 */ 0,		0,		0,		0,
/* ----- 								*/
/* b8 */ 0,		0,		0,		0,
/* ----- BKSP		RET		TAB		`		*/
/* bc */ 14,		28,		15,		0x15,
/* ----- 1		q		a		z		*/
/* c0 */ 2,		16,		30,		44,
/* ----- 		2		w		s		*/
/* c4 */ 0,		3,		17,		31,
/* ----- x		</\\				3		*/
/* c8 */ 45,		86,		0,		4,
/* ----- e		d		c				*/
/* cc */ 18,		32,		46,		0,
/* ----- 4		r		f		v		*/
/* d0 */ 5,		19,		33,		47,
/* ----- SPACE				5		t		*/
/* d4 */ 57,		0,		6,		20,
/* ----- g		b				6		*/
/* d8 */ 34,		48,		0,		7,
/* ----- y		h		n				*/
/* dc */ 21,		35,		49,		0,
/* ----- 7		u		j		m		*/
/* e0 */ 8,		22,		36,		50,
/* ----- 		8		i		k		*/
/* e4 */ 0,		9,		23,		37,
/* ----- ,				9		o		*/
/* e8 */ 51,		0,		10,		24,
/* ----- l		.				0		*/
/* ec */ 38,		52,		0,		11,
/* ----- p				;		/		*/
/* f0 */ 25,		0,		39,		53,
/* ----- 		=		]		\\/\'		*/
/* f4 */ 0,		13,		27,		43,
/* ----- 		-		[		\'		*/
/* f8 */ 0,		12,		26,		40,
/* ----- 								*/
/* fc */ 0,		0,		0,		0,
};


--h31gzZEtNLTqOjlF--
