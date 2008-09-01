Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 17:28:34 +0100 (BST)
Received: from harold.telenet-ops.be ([195.130.133.65]:5810 "EHLO
	harold.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20034017AbYIAQ2b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Sep 2008 17:28:31 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by harold.telenet-ops.be (Postfix) with SMTP id E93C330008;
	Mon,  1 Sep 2008 18:28:30 +0200 (CEST)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by harold.telenet-ops.be (Postfix) with ESMTP id D4A4630079;
	Mon,  1 Sep 2008 18:28:30 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m81GSUrI013064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Sep 2008 18:28:30 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m81GST2v013061;
	Mon, 1 Sep 2008 18:28:30 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 1 Sep 2008 18:28:29 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/6] TXx9: IOC LED support
In-Reply-To: <1220275361-5001-3-git-send-email-anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0809011821170.5424@anakin>
References: <1220275361-5001-3-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463808415-137436136-1220286509=:5424"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808415-137436136-1220286509=:5424
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Nemoto-san,

On Mon, 1 Sep 2008, Atsushi Nemoto wrote:
> Add leds-gpio platform device for controlling LEDs connected to IOC on
> RBTX49XX and JMR3927 board.

Thanks, LED[1-3] on my RBTX4927 work fine now!

If I'm correct LED4 and LED5 are not connected to the IOC, but to the
PIO of the TX4927. Do you have a driver for those LEDs, too?
Perhaps I just missed it, I only applied this single patch.

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
---1463808415-137436136-1220286509=:5424--
