Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FFfQp25746
	for linux-mips-outgoing; Fri, 15 Feb 2002 07:41:26 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FFfN925740
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 07:41:23 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 16bjli-0003Lr-00; Fri, 15 Feb 2002 14:55:22 +0000
Subject: Re: hot patching
To: keith_siders@toshibatv.com (Siders, Keith)
Date: Fri, 15 Feb 2002 14:55:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'),
   linux-mips@oss.sgi.com ('linux-mips@oss.sgi.com')
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA1B7579@ATVX> from "Siders, Keith" at Feb 15, 2002 08:17:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bjli-0003Lr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> When I looked at the ptrace code it looked to me like it was intended for
> inserting breakpoints for the most part. Are you saying that I can patch

Mostly yes

> into a process and have it vector off to executable code? At this point I've
> identified at least three types of patches: a jump, a call, and simply
> overwrite a few instructions (the easiest and common to all types). I'd love
> to _not_ need a driver.

Have a look at how gdb implements "call functionname"
