Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 13:40:28 +0000 (GMT)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:42979 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S22502092AbYJ0Nji (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 13:39:38 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 3491858ABD;
	Mon, 27 Oct 2008 14:39:32 +0100 (MET)
Date:	Mon, 27 Oct 2008 14:39:32 +0100 (CET)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org
Subject: Re: RBTX4927 with VxWorks boot loader crashes in prom_getenv()
In-Reply-To: <20081024.233538.48533304.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0810271419280.19980@vixen.sonytel.be>
References: <Pine.LNX.4.64.0810241118120.27263@vixen.sonytel.be>
 <20081024.230250.59651236.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0810241605380.23415@vixen.sonytel.be>
 <20081024.233538.48533304.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-1734353941-1225114772=:19980"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1734353941-1225114772=:19980
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Nemoto-san,

On Fri, 24 Oct 2008, Atsushi Nemoto wrote:
> On Fri, 24 Oct 2008 16:06:28 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > > > | fw_arg0 = 0x80002000
> > > > | fw_arg1 = 0x80001fe0
> > > > | fw_arg2 = 0x2000
> > > > | fw_arg3 = 0x20
> > > > 
> > > > So your assumption that bootloaders other than YAMON pass NULL for fw_arg2 is
> > > > apparently wrong.
> > > 
> > > Indeed.  We should know what sort of value was passed by fw_arg2, and
> > > I hope auto-detection.
> > > 
> > > Do you know what value the boot loader passes via fw_arg2?  If fw_arg2
> > 
> > Unfortunately not. I'll try to Google a bit for it...
> 
> BTW, it looks fw_arg0 is not 'argc'.  Fortunately current code just
> ignores argv if argc was negative, but it is not intentional
> behaviour, just a luck ;)

Woops...

The memory pointed to by fw_arg0 and fw_arg1 contains just zeroes.

According to the sources, the VxWorks bootloader just jumps to the kernel's
entry point, without passing any parameters in a0-a3 at all. So they're just
leftovers.

> You can put a string starting with "-" in CONFIG_CMDLINE, so that
> fw_arg0 is ignored regardless of its value.  Hmm... putting "noenv" or
> something in CONFIG_CMDLINE (and check it in preprocess_cmdline()) can
> be an another workaround for getenv problem...

Prepending my command line in CONFIG_CMDLINE with `-' doesn't help.
prom_getenv() is still called.

So I came up with the patch below.

Subject: [PATCH] txx9: Make firmware parameter passing more robust

When booting Linux on a txx9 board with VxWorks boot loader, it crashes in
prom_getenv(), as VxWorks doesn't pass firmware parameters in a0-a3 (in my
case, the actual leftover values in these registers were 0x80002000,
0x80001fe0, 0x2000, and 0x20).

Make the parsing of argc, argv, and envp a bit more robust by checking if argc
is a number below CKSEG0, and argv/envp point to CKSEG0.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 5526375..f4486a5 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -156,11 +156,20 @@ static struct txx9_board_vec *__init find_board_byname(const char *name)
 
 static void __init prom_init_cmdline(void)
 {
-	int argc = (int)fw_arg0;
-	int *argv32 = (int *)fw_arg1;
+	int argc;
+	int *argv32;
 	int i;			/* Always ignore the "-c" at argv[0] */
 	char builtin[CL_SIZE];
 
+	if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
+	    /* argc is not a valid number, or argv32 is not a valid pointer */
+	    argc = 0;
+	    argv32 = NULL;
+	} else {
+	    argc = (int)fw_arg0;
+	    argv32 = (int *)fw_arg1;
+	}
+
 	/* ignore all built-in args if any f/w args given */
 	/*
 	 * But if built-in strings was started with '+', append them
@@ -414,10 +423,12 @@ char * __init prom_getcmdline(void)
 
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
---584349381-1734353941-1225114772=:19980--
