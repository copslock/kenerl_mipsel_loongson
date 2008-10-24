Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 13:07:54 +0100 (BST)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:43665 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S22289215AbYJXMHq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 13:07:46 +0100
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 26BE558ABD;
	Fri, 24 Oct 2008 14:07:34 +0200 (MEST)
Date:	Fri, 24 Oct 2008 14:07:34 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: RBTX4927 with VxWorks boot loader crashes in prom_getenv()
In-Reply-To: <Pine.LNX.4.64.0810241118120.27263@vixen.sonytel.be>
Message-ID: <Pine.LNX.4.64.0810241406590.17952@vixen.sonytel.be>
References: <Pine.LNX.4.64.0810241118120.27263@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-410574624-1224850054=:17952"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-410574624-1224850054=:17952
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 24 Oct 2008, Geert Uytterhoeven wrote:
> BTW, after making this change, I still have another issue with the network.
> I get

> This is plain 2.6.27+ as of yesterday. I'll see if it goes away with today's
> linux-mips git tree.

Seems to be fixed in 2.6.28-rc1 (both mainline and linux-mips git).

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
---584349381-410574624-1224850054=:17952--
