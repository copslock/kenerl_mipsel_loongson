Received:  by oss.sgi.com id <S42218AbQGCNup>;
	Mon, 3 Jul 2000 06:50:45 -0700
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:38182 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S42217AbQGCNuV>;
	Mon, 3 Jul 2000 06:50:21 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 1396Xy-0004hz-00; Mon, 3 Jul 2000 14:46:02 +0100
Subject: Re: errno assignment in _syscall macros and glibc
To:     nop@nop.com (Jay Carlson)
Date:   Mon, 3 Jul 2000 14:45:58 +0100 (BST)
Cc:     ralf@oss.sgi.com (Ralf Baechle),
        alan@lxorguk.ukuu.org.uk (Alan Cox), aj@suse.de (Andreas Jaeger),
        mfklar@ponymail.com (Mike Klar), linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
In-Reply-To: <073a01bfe29c$00995e90$0a00000a@decoy> from "Jay Carlson" at Jun 30, 2000 10:03:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1396Xy-0004hz-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Does newlib work under Linux?  I thought it was missing (for example) t=
> he
> syscalls, and generally needed work to be ported to Linux.  I'm interes=

You would need to add the syscalls yes. Also the Cygnus^WRed Hat folks tell
me that the eCos libc is built from and replaces newlib.

> *BSD libc has been suggested by a few people.

Good idea - how does it compare ?

> Jay
> 
> 
