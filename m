Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 15:06:57 +0100 (BST)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:62363 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S22296527AbYJXOGp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 15:06:45 +0100
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 4A1FC58ABD;
	Fri, 24 Oct 2008 16:06:28 +0200 (MEST)
Date:	Fri, 24 Oct 2008 16:06:28 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org
Subject: Re: RBTX4927 with VxWorks boot loader crashes in prom_getenv()
In-Reply-To: <20081024.230250.59651236.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0810241605380.23415@vixen.sonytel.be>
References: <Pine.LNX.4.64.0810241118120.27263@vixen.sonytel.be>
 <20081024.230250.59651236.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-1683427686-1224857188=:23415"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1683427686-1224857188=:23415
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Nemoto-san,

On Fri, 24 Oct 2008, Atsushi Nemoto wrote:
> On Fri, 24 Oct 2008 11:39:07 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > My RBTX4927 with VxWorks boot loader crashes in prom_getenv() since commit
> > 860e546c19d88c21819c7f0861c505debd2d6eed ("MIPS: TXx9: Early command-line
> > preprocessing"):
> ...
> > | fw_arg0 = 0x80002000
> > | fw_arg1 = 0x80001fe0
> > | fw_arg2 = 0x2000
> > | fw_arg3 = 0x20
> > 
> > So your assumption that bootloaders other than YAMON pass NULL for fw_arg2 is
> > apparently wrong.
> 
> Indeed.  We should know what sort of value was passed by fw_arg2, and
> I hope auto-detection.
> 
> Do you know what value the boot loader passes via fw_arg2?  If fw_arg2

Unfortunately not. I'll try to Google a bit for it...

> is always small integer (i.e. a not KSEG0/KSEG1 address), we can
> autodetect fw_arg2 was a pointer or not.

Exactly my thoughts.

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
---584349381-1683427686-1224857188=:23415--
