Received:  by oss.sgi.com id <S42219AbQFYVaT>;
	Sun, 25 Jun 2000 14:30:19 -0700
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:10082 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S42183AbQFYV35>;
	Sun, 25 Jun 2000 14:29:57 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 136JuZ-0003C0-00; Sun, 25 Jun 2000 22:25:51 +0100
Subject: Re: errno assignment in _syscall macros and glibc
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Sun, 25 Jun 2000 22:25:48 +0100 (BST)
Cc:     alan@lxorguk.ukuu.org.uk (Alan Cox), aj@suse.de (Andreas Jaeger),
        mfklar@ponymail.com (Mike Klar), linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
In-Reply-To: <20000625232138.A3802@bacchus.dhis.org> from "Ralf Baechle" at Jun 25, 2000 11:21:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E136JuZ-0003C0-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Sure; these days glibc is more or less synonym with libc and I was using
> it in that sense.
> 
> What small, portable libcs do we have available anyway?  Some mipers will
> want one.

I've been playing with the Linux8086 libc which is tiny but not portable when
Prumpf pointed out that Cygnus newlib is designed for precisely this job. Its
about 250K MIPS32 (my PDA has mips32/mips64 but not mips16 - duh!!)

Alan
