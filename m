Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f48D4RJ14582
	for linux-mips-outgoing; Tue, 8 May 2001 06:04:27 -0700
Received: from the-village.bc.nu (router-100M.swansea.linux.org.uk [194.168.151.17])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f48D4PF14577
	for <linux-mips@oss.sgi.com>; Tue, 8 May 2001 06:04:25 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14x7DA-0005br-00; Tue, 8 May 2001 14:07:32 +0100
Subject: Re: Linux on a Tektronix XP217C xterm
To: milang@tal.org (Kaj-Michael Lang)
Date: Tue, 8 May 2001 14:07:29 +0100 (BST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <Pine.LNX.4.33.0105080945260.20283-100000@tori.tal.org> from "Kaj-Michael Lang" at May 08, 2001 09:56:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14x7DA-0005br-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Any chance of getting linux running on a tektronix x-terminal ? It has
> a LR33020 cpu, that I think is a R3000 integrated with some graphics
> chip. I've tried searching for documentation for the chip but I didn't
> find anything.

MMUless pseudo mips embedded CPU. Hardwired TLB's for KSEG etc. Also a few
other cute suprises such as multiply being interruptible and the irq handler
having to save cpu magic registers before doing another one.

Some of the 3com routers I hacked on used variants of these beasties. I suspect
its a ucLinux target unless you have one with loadable TLB's
