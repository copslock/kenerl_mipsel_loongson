Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f66IP8113469
	for linux-mips-outgoing; Fri, 6 Jul 2001 11:25:08 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f66IP7V13466
	for <linux-mips@oss.sgi.com>; Fri, 6 Jul 2001 11:25:07 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f66INg022312;
	Fri, 6 Jul 2001 11:23:42 -0700
Message-ID: <3B460176.37CD992D@mvista.com>
Date: Fri, 06 Jul 2001 11:20:38 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kjlin <kj.lin@viditec-netmedia.com.tw>
CC: linux-mips@oss.sgi.com
Subject: Re: Kernel panic: Attempted to kill init!
References: <013801c104f4$a807cf60$056aaac0@kjlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> kjlin wrote:
> 
> Hi,
> 
> When the kernel boots up and mounts the root file system,
> the kernel start to do "execve("/sbin/AP",argv_init,envp_init)" to run a AP.
> But in my case, it panics when kernel tries to do the
> "execve("/sbin/AP",argv_init,envp_init)".
> The kernel panic message shows " Kernel panic: Attempted to kill init! ".
> What situation will trigger such kernel panic?
> 
> Thanks,
> KJ

A common reason is that /sbin/AP has a seg fault or some other faults.  I
would debug AP program in a stable environment and then make sure I can see
the first "printf" from AP.  From there, you can debug AP with printf.

Jun
