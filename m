Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 14:45:50 +0100 (BST)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:45628 "EHLO
	pophost.sonytel.be" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20022514AbZEONpn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 14:45:43 +0100
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id CDBFF44472;
	Fri, 15 May 2009 15:45:36 +0200 (CEST)
Date:	Fri, 15 May 2009 15:45:36 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] TXx9: Add ACLC support
In-Reply-To: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
Message-ID: <alpine.LRH.2.00.0905151516300.32617@vixen.sonytel.be>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

On Thu, 14 May 2009, Atsushi Nemoto wrote:
> Add platform support for ACLC of TXx9 SoCs.

I gave it a try on my RBTX4927, and after some fight^H^H^H^H^Hplaying with the
alsa tools, I could play sound using `speaker-test --test wav --channels 2'!

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
