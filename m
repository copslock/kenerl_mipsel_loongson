Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 20:08:24 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.199]:8392 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225216AbVAaUHx>;
	Mon, 31 Jan 2005 20:07:53 +0000
Received: by wproxy.gmail.com with SMTP id 57so680662wri
        for <linux-mips@linux-mips.org>; Mon, 31 Jan 2005 12:07:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=bzharHEzJFLyw+JO2XjH7QOP0F4q1q6VP213lYRjtzXql5VqI5AiLy9UPyAc0uLWJkIkDzeNG5imBrbwjLIK2H2kFSM5sDWQvVZBklJWwol7Xq8VlatsWZUATN+wKgrSq8iAGrg+JWFyEBctZw+qWY5ZaHFQNsB7ZRARKnAHsUE=
Received: by 10.54.15.76 with SMTP id 76mr161003wro;
        Mon, 31 Jan 2005 12:07:46 -0800 (PST)
Received: by 10.54.41.39 with HTTP; Mon, 31 Jan 2005 12:07:45 -0800 (PST)
Message-ID: <ecb4efd10501311207faf0550@mail.gmail.com>
Date:	Mon, 31 Jan 2005 15:07:45 -0500
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: initial bootstrap and jtag
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

We are finishing up the design of our new Au1550 based board. I was
wondering if someone could recommend an ejtag wiggler. I need
something that has full linux host support, is good enough to flash a
bootloader and do some minimal debug while getting the board support
working. Looking over the list some people seem to be using the
Abatron BDI 2000 and others are using the Macraigor mpDemon. What do
you guys recommend?

This is my first time doing embedded linux, but I've done quite a bit
with DSPs (written bootloaders, flash programmers, etc). I was
wondering how people go about bootstrapping new Au1xxx systems. Who is
responsible for configuring the PLL or SDRAM enough to allow code to
be loaded into SDRAM? Are bootloaders like YAMON position independent
to run out of SDRAM?

                                     Thanks,
                                     Clem
