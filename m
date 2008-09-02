Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2008 15:18:47 +0100 (BST)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:33187 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S20035923AbYIBOSn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Sep 2008 15:18:43 +0100
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 192A258ABD;
	Tue,  2 Sep 2008 16:18:37 +0200 (MEST)
Date:	Tue, 2 Sep 2008 16:18:37 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/6] TXx9: IOC LED support
In-Reply-To: <20080902.224507.128619319.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0809021617450.3986@vixen.sonytel.be>
References: <1220275361-5001-3-git-send-email-anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64.0809011821170.5424@anakin> <20080902.224507.128619319.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-946661120-1220365117=:3986"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-946661120-1220365117=:3986
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Nemoto-san,

On Tue, 2 Sep 2008, Atsushi Nemoto wrote:
> On Mon, 1 Sep 2008 18:28:29 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > If I'm correct LED4 and LED5 are not connected to the IOC, but to the
> > PIO of the TX4927. Do you have a driver for those LEDs, too?
> > Perhaps I just missed it, I only applied this single patch.
> 
> Done ;)
> 
> Note that the patch depends on some patches in linux-queue tree, but
> it would be simple enough so that you can apply it manually.

Thanks a lot! It works fine.

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
---584349381-946661120-1220365117=:3986--
