Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 14:26:03 +0000 (GMT)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:11240 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S22506058AbYJ0OZz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 14:25:55 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 2022F58ABD;
	Mon, 27 Oct 2008 15:25:49 +0100 (MET)
Date:	Mon, 27 Oct 2008 15:25:49 +0100 (CET)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org
Subject: Re: RBTX4927 with VxWorks boot loader crashes in prom_getenv()
In-Reply-To: <20081027.230428.18313184.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0810271524500.15795@vixen.sonytel.be>
References: <Pine.LNX.4.64.0810241605380.23415@vixen.sonytel.be>
 <20081024.233538.48533304.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0810271419280.19980@vixen.sonytel.be>
 <20081027.230428.18313184.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-138390815-1225117549=:15795"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-138390815-1225117549=:15795
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 27 Oct 2008, Atsushi Nemoto wrote:
> On Mon, 27 Oct 2008 14:39:32 +0100 (CET), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > Subject: [PATCH] txx9: Make firmware parameter passing more robust
> > 
> > When booting Linux on a txx9 board with VxWorks boot loader, it crashes in
> > prom_getenv(), as VxWorks doesn't pass firmware parameters in a0-a3 (in my
> > case, the actual leftover values in these registers were 0x80002000,
> > 0x80001fe0, 0x2000, and 0x20).
> > 
> > Make the parsing of argc, argv, and envp a bit more robust by checking if argc
> > is a number below CKSEG0, and argv/envp point to CKSEG0.
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> Look OK for me, except for coding style :)

Sorry, how could I have missed that...

> If TAB was used for indent,
> Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thx!

Subject: [PATCH] txx9: Make firmware parameter passing more robust

When booting Linux on a txx9 board with VxWorks boot loader, it crashes in
prom_getenv(), as VxWorks doesn't pass firmware parameters in a0-a3 (in my
case, the actual leftover values in these registers were 0x80002000,
0x80001fe0, 0x2000, and 0x20).

Make the parsing of argc, argv, and envp a bit more robust by checking if argc
is a number below CKSEG0, and argv/envp point to CKSEG0.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
 arch/mips/txx9/generic/setup.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -156,11 +156,23 @@ static struct txx9_board_vec *__init fin
 
 static void __init prom_init_cmdline(void)
 {
-	int argc = (int)fw_arg0;
-	int *argv32 = (int *)fw_arg1;
+	int argc;
+	int *argv32;
 	int i;			/* Always ignore the "-c" at argv[0] */
 	char builtin[CL_SIZE];
 
+	if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
+		/*
+		 * argc is not a valid number, or argv32 is not a valid
+		 * pointer
+		 */
+		argc = 0;
+		argv32 = NULL;
+	} else {
+		argc = (int)fw_arg0;
+		argv32 = (int *)fw_arg1;
+	}
+
 	/* ignore all built-in args if any f/w args given */
 	/*
 	 * But if built-in strings was started with '+', append them
@@ -414,10 +426,12 @@ char * __init prom_getcmdline(void)
 
 const char *__init prom_getenv(const char *name)
 {
-	const s32 *str = (const s32 *)fw_arg2;
+	const s32 *str;
 
-	if (!str)
+	if (fw_arg2 < CKSEG0)
 		return NULL;
+
+	str = (const s32 *)fw_arg2;
 	/* YAMON style ("name", "value" pairs) */
 	while (str[0] && str[1]) {
 		if (!strcmp((const char *)(unsigned long)str[0], name))

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-138390815-1225117549=:15795--
