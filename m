Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3HGk7l15465
	for linux-mips-outgoing; Tue, 17 Apr 2001 09:46:07 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3HGk6M15458
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 09:46:06 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id LAA29104
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 11:46:04 -0500
Message-ID: <3ADC81F1.72309FD0@cotw.com>
Date: Tue, 17 Apr 2001 10:48:33 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: Link problems with 2.4.3 kernel
References: <3ADB5181.BCE02A9@cotw.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Scott A McConnell wrote:

> No matter what I do I can not get _ftext to appear at 80001000. I use
> identical ld.scripts for bother kernels.
> At first I thought it was my binutils so I switched to the same tools
> that I used with my 2.4.0-test5 kernel.
>
> Addresses appear to be off by 0x1000.  Which is why my 2.4.3 kernel dies
> on the jump to init_arch out of kernel_entry.
>
> Any thoughts about what I might be doing wrong?
>
> Thanks,
> Scott

I tracked it down to a missing:

ifdef LOADADDR
LINKFLAGS     += -Ttext $(word 1,$(LOADADDR))
endif

in arch/mips/Makefile

I have no idea who added it or removed it.

I also am forced to edit the ld.script file to replace the LOADADDR
inserted with sed with 80000000.

Am I suppose to be accomplishing what I did above some other way?

Scott
