Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2004 17:28:30 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:3293 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225266AbULYRZU>; Sat, 25 Dec 2004 17:25:20 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id 5ADE71F126; Sat, 25 Dec 2004 18:25:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 200711ED41;
	Sat, 25 Dec 2004 18:25:07 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 1B1FB1EA0F;
	Sat, 25 Dec 2004 18:24:58 +0100 (CET)
Subject: [patch 7/9] delete unused file
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, domen@coderock.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:25:08 +0100
Message-Id: <20041225172458.1B1FB1EA0F@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-mips/ng1.h |   55 ----------------------------------------------
 1 files changed, 55 deletions(-)

diff -L include/asm-mips/ng1.h -puN include/asm-mips/ng1.h~remove_file-include_asm_mips_ng1.h /dev/null
--- kj/include/asm-mips/ng1.h
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,55 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * SGI/Newport video card ioctl definitions
- */
-#ifndef _ASM_NG1_H
-#define _ASM_NG1_H
-
-typedef struct {
-        int flags;
-        __u16 w, h;
-        __u16 fields_sec;
-} ng1_vof_info_t;
-
-struct ng1_info {
-	struct gfx_info gfx_info;
-	__u8 boardrev;
-        __u8 rex3rev;
-        __u8 vc2rev;
-        __u8 monitortype;
-        __u8 videoinstalled;
-        __u8 mcrev;
-        __u8 bitplanes;
-        __u8 xmap9rev;
-        __u8 cmaprev;
-        ng1_vof_info_t ng1_vof_info;
-        __u8 bt445rev;
-        __u8 paneltype;
-};
-
-#define GFX_NAME_NEWPORT "NG1"
-
-/* ioctls */
-#define NG1_SET_CURSOR_HOTSPOT 21001
-struct ng1_set_cursor_hotspot {
-	unsigned short xhot;
-        unsigned short yhot;
-};
-
-#define NG1_SETDISPLAYMODE     21006
-struct ng1_setdisplaymode_args {
-        int wid;
-        unsigned int mode;
-};
-
-#define NG1_SETGAMMARAMP0      21007
-struct ng1_setgammaramp_args {
-        unsigned char red   [256];
-        unsigned char green [256];
-        unsigned char blue  [256];
-};
-
-#endif /* _ASM_NG1_H */
_
