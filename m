Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 17:42:24 +0000 (GMT)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:22991 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S20037677AbYAORmP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 17:42:15 +0000
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 04BF958ADF;
	Tue, 15 Jan 2008 18:41:56 +0100 (MET)
Date:	Tue, 15 Jan 2008 18:41:55 +0100 (CET)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Karsten Merker <merker@debian.org>,
	Thiemo Seufer <ths@networkno.de>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: pmag-aa-fb
Message-ID: <Pine.LNX.4.64.0801151831370.12445@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-111773905-1200418915=:12445"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-111773905-1200418915=:12445
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

I've just noticed drivers/video/pmag-aa-fb.c is the single remaining frame
buffer device driver that still uses the old 2.4 API (all others have been
converted or removed). So it doesn't work anymore.

Does anyone still care about it?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584349381-111773905-1200418915=:12445--
