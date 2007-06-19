Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 19:18:51 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:2719 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20023725AbXFSSSr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 19:18:47 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A9E11200A20D;
	Tue, 19 Jun 2007 20:18:20 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07456-01-22; Tue, 19 Jun 2007 20:18:09 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 30628200A1F2;
	Tue, 19 Jun 2007 20:18:07 +0200 (CEST)
Message-ID: <46781DD4.7020304@27m.se>
Date:	Tue, 19 Jun 2007 20:17:56 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Sadarul Firos <sadarul.firos@nestgroup.net>,
	linux-mips@linux-mips.org
Subject: Re: [SPAM] Re: "Segfault/illegal instruction" - udevd - ntpd - glibc
References: <9A1299C7A40D7447A108107E951450CA01C9E015@MAIL-TVM.tvm.nestgroup.net> <20070616193358.GA22195@linux-mips.org>
In-Reply-To: <20070616193358.GA22195@linux-mips.org>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Ralf Baechle wrote:
> On Fri, Jun 15, 2007 at 09:23:34PM +0530, Sadarul Firos wrote:
>
>> I am working with two MIPS based boards (one is MIPS and the other is
>> MIPSEL) running linux-2.6.18/glibc-2.3.5. I am performing a consecutive
>> reboot test on these boards. After some number of reboots (say 80) I  am
>> getting "segmentaion fault/illegal instruction" while running udevd and
>> ntpd during bootup. Upon observing the core dump, it is noted that the
>> segfault occured from the _init function of libnss_dns.so (in the case
>> of ntpd) and libnss_compat.so (in the case of udevd). I assume that
>> there might be a problem somewhere in the call_init function in
>> glibc-2.3.5/elf/dl-init.c. After I put some printf statements for
>> debugging in the call_init function, there is no segfault/illegal
>> instruction in the reboot testing. I have also used gdb to debug the
>> problem but the "segfault/illegal instruction" doesn't occur during the
>> reboot test. Could anyone please help me to sort out this problem. The
>> gdb output using coredump is attached.
>
> Normally the address space layout and most other variables during a
> program load should be identical each time so userspace should behave
> identical.   So I sense the scent of a TLB or more likely cache managment
> problem.
>
> What 2.6.18 variant exactly are you running, that is where & when did
> download it, what CPU?
>
>   Ralf
>
Seems to me like a timing issue if printf'ing helps. You should try
invoking udevd by gdb (without the printf's).

- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGeB3S6I0XmJx2NrwRCNxBAJ9vZb0+ngxP3nW02nXvKlEKY7DDQwCglXkW
ntaDNcvzn2pNdYruCxyZqt8=
=2MG9
-----END PGP SIGNATURE-----
