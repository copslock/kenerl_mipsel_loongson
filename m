Received:  by oss.sgi.com id <S554077AbQLBQcC>;
	Sat, 2 Dec 2000 08:32:02 -0800
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10762 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S554074AbQLBQbs>;
	Sat, 2 Dec 2000 08:31:48 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 142FZs-0001he-00; Sat, 2 Dec 2000 16:31:56 +0000
Subject: Re: Support for smaller glibc
To:     alhaz@xmission.com (Eric Jorgensen)
Date:   Sat, 2 Dec 2000 16:31:53 +0000 (GMT)
Cc:     alan@lxorguk.ukuu.org.uk (Alan Cox), linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
In-Reply-To: <E142FIH-00017w-00@xmission.xmission.com> from "Eric Jorgensen" at Dec 02, 2000 09:13:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142FZs-0001he-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> 	There are a few other methods. Lineo for instance has a utility
> called Lipo which goes through all the binaries on a system and then

Try it on a real application and with glibc 2.2 at least its far from
large. glibc isnt designed to be modular.

> substantial reduction in the size of libc6. Lipo is a proprietary
> app tho, currently only available supporting ia32 and ppc archetectures as
> part of the Embedix SDK.

Lipo is an afternoons work to do with libbfd so thats a path that is easy
to pursue. (

> 	There's also uClibc, and i've heard some talk of using bsd's libc,
> which i understand is also smaller. These may require modification to the
> sourcecode of your apps to work properly. 

BSD libc is smaller, uClibc is pretty ropey and not very modular. Both the
BSD libc and newlib are modular. Newlib for mips32 without mips16 support 
including FPU emulation with every option on is about 350K
