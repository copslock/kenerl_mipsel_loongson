Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FEost19289
	for linux-mips-outgoing; Fri, 15 Feb 2002 06:50:54 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FEoo919286
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 06:50:51 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 16biyn-0003EB-00; Fri, 15 Feb 2002 14:04:49 +0000
Subject: Re: hot patching
To: keith_siders@toshibatv.com (Siders, Keith)
Date: Fri, 15 Feb 2002 14:04:49 +0000 (GMT)
Cc: linux-mips@oss.sgi.com ("Linux-Mips (E-mail)")
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA1B7578@ATVX> from "Siders, Keith" at Feb 15, 2002 07:39:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16biyn-0003EB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I'm attempting to set up a "hot patcher" in an embedded product. I'm
> attempting to use shared memory, however the "target" process is not aware
> of the patch being applied to it. Can a pseudo-driver attach a shared memory
> segment to a process which can then be executable by that process via a jump
> or jump-and-link, or is shared memory only for passing data and messages
> between collaborating processes? The references I've read only indicate the
> RW permissions, no X permissions. Or should I have the pseudo-driver
> actually allocate (by get_free_pages()) the memory required? And can it do
> this on behalf of the target process?

You shouldnt even need a driver if you are clever. The ptrace() functionality
for debuggers is sufficient to patch running code, and to do other interesting
things by adding new functions and calling them
