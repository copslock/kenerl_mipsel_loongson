Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:36:32 +0000 (GMT)
Received: from mail.kernelconcepts.de ([212.60.202.196]:30121 "EHLO
	mail.kernelconcepts.de") by ftp.linux-mips.org with ESMTP
	id S21366485AbZCFQg3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Mar 2009 16:36:29 +0000
Received: from [192.168.2.28]
	by mail.kernelconcepts.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nils.faerber@kernelconcepts.de>)
	id 1LfdHU-0008H3-Rg
	for linux-mips@linux-mips.org; Fri, 06 Mar 2009 17:52:16 +0100
Message-ID: <49B1510B.8020606@kernelconcepts.de>
Date:	Fri, 06 Mar 2009 17:36:27 +0100
From:	Nils Faerber <nils.faerber@kernelconcepts.de>
Organization: kernel concepts GbR
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Ingenic JZ4730 - illegal instruction
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <nils.faerber@kernelconcepts.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nils.faerber@kernelconcepts.de
Precedence: bulk
X-list: linux-mips

Hello!
I am rather playing than really working on a Ingenic JZ4730 based
device. The JZ4730 is a MIPS32 SOC included in many types of devices,
like media players and thelike but also in small power efficient
subnotebooks (this is the device I am trying to support based on the
Ingebic Linux kernel patch).

The current kernel patch from Ingenic

http://www.ingenic.cn/eng/productServ/App/JZ4730/pfCustomPage.aspx
or
ftp://ftp.ingenic.cn/3sw/01linux/02kernel/linux-2.6.24/linux-2.6.24.3-jz-20090218.patch.gz

for the patch (I used an even older patch to start my board support but
they basically only added newer CPU types in later patches).

The support for my board is almost in place but I see from time to time
failing applications with "illegal instruction" faults. Most shell
applications work pretty fine, especially more complex GUI applications
seem to fail, like a webbrowser or such.
I also tested this with different GCC and glibc version which makes me
pretty sure that I am seeing a kernel problem here rather than a
userspace problem.

I am pretty clueless how to debug this. Apropos debig as another hint:
Some application work if I start them in GDB but fail outside.

Any hint how to start debugging this would be greatly appreciated! And a
fix would be like a dream ;)

Many thanks!

Cheers
  nils faerber

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
