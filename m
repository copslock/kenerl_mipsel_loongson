Received:  by oss.sgi.com id <S42217AbQFYTbk>;
	Sun, 25 Jun 2000 12:31:40 -0700
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:35424 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S42183AbQFYTbK>;
	Sun, 25 Jun 2000 12:31:10 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 136I3I-0002yR-00; Sun, 25 Jun 2000 20:26:44 +0100
Subject: Re: errno assignment in _syscall macros and glibc
To:     ralf@uni-koblenz.de (Ralf Baechle)
Date:   Sun, 25 Jun 2000 20:26:42 +0100 (BST)
Cc:     aj@suse.de (Andreas Jaeger), mfklar@ponymail.com (Mike Klar),
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
In-Reply-To: <20000625204334.E1572@bacchus.dhis.org> from "Ralf Baechle" at Jun 25, 2000 08:43:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E136I3I-0002yR-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Andreas - I think the syscall interface should finally officially be
> declared a private interface between libc and the kernel, that is nobody
> except these two should use it.  Many of the other attempts to use it
> have been quite problematic - portabilitywise and worse.

Don't make it too private. glibc is still worryingly large for some embedded
applications. Between a libc and the kernel yes, between glibc and the kernel
no.

Alan
