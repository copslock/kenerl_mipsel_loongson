Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 16:06:35 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:1923 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S22215387AbYJWPG3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 16:06:29 +0100
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 028D64002B;
	Thu, 23 Oct 2008 17:06:27 +0200 (CEST)
Received: from [192.168.27.166] (152-186-96-87.cust.blixtvik.se [87.96.186.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id DCAFC40017;
	Thu, 23 Oct 2008 17:06:26 +0200 (CEST)
Message-ID: <490092F4.2020004@27m.se>
Date:	Thu, 23 Oct 2008 17:06:28 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	"Arao H. Filho" <eletronicaecia@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: AR7 MIPS development tools
References: <4d5c51d30810221714g740c9285n7d72f17c2ff487d2@mail.gmail.com>
In-Reply-To: <4d5c51d30810221714g740c9285n7d72f17c2ff487d2@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Could you precise the question a bit more?
Which JTAG-probe are you using and which software for it?
Do you have a schematic layout and datasheet?

Since this list is for Linux, you should be surprised if you get some
more help.
As well the format doesn't matter as long as your JTAG-software is
able to handle it, myself I prefer Motorola SREC.

//Markus

Arao H. Filho wrote:
> Hi, I work with microcontrollers,  (8051, 68hc11, avr, pic, arm
> based, real time programs) and I have some DSL-500t (dlink) boards,
> that I want to use as development boards, loading and running some
> C programs on it board and debugging with the JTAG port.
>
>
> 1- How do I find some information of how to find some .h headers
> for the i/o's and serial? (i/o register address locations)
>
> 2-How did I "upload" the program to the flash? The JTAG pinout I
> found, I need the software name.
>
> 3-Which format did I use on this file? (.bin/intel hex/motorola
> hex, special?)
>
> -All these questions are whitout the linux kernel!, running the
> program without any operating system.
>
> I work with C on PIC, 8051, AVR and ARM7TDMI, where there's a lot
> of information for how to do these tasks, if you can help please
> email me.
>
>
> Thanks so much! --
>
>
> Arao H. F.
>
>


- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJAJLx6I0XmJx2NrwRCAmfAKDBMEo2pcLdUv/xvbfJBngNhElLRwCguLaa
Tfj+FpEe8FEJHUozP4uYiRM=
=Z2tM
-----END PGP SIGNATURE-----
