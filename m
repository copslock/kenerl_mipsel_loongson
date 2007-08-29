Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 17:52:11 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:28051 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20022326AbXH2QwC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 17:52:02 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id EC9E6200A1FD;
	Wed, 29 Aug 2007 18:52:00 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17355-01-64; Wed, 29 Aug 2007 18:51:59 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id BD243200A1E2;
	Wed, 29 Aug 2007 18:51:59 +0200 (CEST)
Message-ID: <46D5A42F.4090503@27m.se>
Date:	Wed, 29 Aug 2007 18:51:59 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.12 (X11/20070730)
MIME-Version: 1.0
To:	Ricardo Mendoza <mendoza.ricardo@gmail.com>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: Exception while loading kernel
References: <1188030215.13999.14.camel@scarafaggio>	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>	 <1188321514.6882.3.camel@scarafaggio>	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>	 <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>	 <1188377693.7270.1.camel@scarafaggio> <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com>
In-Reply-To: <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Ricardo Mendoza wrote:
> On 8/29/07, Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
> wrote:
>
>> I already tried the 32bit kernel and I found the same problem.
>> Are you telling me that I should use 32bit for debugging instead
>> of 64?
>
> No, what I'm telling you to do is to try and build it with
> CONFIG_BUILD_ELF64 disabled, more explicitly that is under
> Executable file formats or something like that. About kgdb
> debugging, what I am telling you is that ip32 has no hook ups coded
> for it yet, in other words, no support.
>
>
> Ricardo
>
You're all wrong build it with -g (i.e. enable 'Kernel
Hacking'-options), then strip it and saved the copy with debugging
symbols. Then you run gdb on the one with debugging symbols and voila
you get the function.

//Markus

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

iD8DBQFG1aQt6I0XmJx2NrwRCAi+AJ9mpYqqEFnRPl9+f9MDRPUhAGHBBwCgkYXL
U0ltGP7+Y+2xj9itgyjfJ6E=
=fgJH
-----END PGP SIGNATURE-----
