Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8KBUMU20570
	for linux-mips-outgoing; Thu, 20 Sep 2001 04:30:22 -0700
Received: from dea.linux-mips.net (u-100-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.100])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8KBUIe20567
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 04:30:18 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8KBTZw14958;
	Thu, 20 Sep 2001 13:29:35 +0200
Date: Thu, 20 Sep 2001 13:29:35 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: kjlin <kj.lin@viditec-netmedia.com.tw>
Cc: linux-mips@oss.sgi.com
Subject: Re: fork() vs vfork()
Message-ID: <20010920132935.A13439@dea.linux-mips.net>
References: <05e901c141a0$a03e6120$056aaac0@kjlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <05e901c141a0$a03e6120$056aaac0@kjlin>; from kj.lin@viditec-netmedia.com.tw on Thu, Sep 20, 2001 at 02:51:08PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 20, 2001 at 02:51:08PM +0800, kjlin wrote:
> From: "kjlin" <kj.lin@viditec-netmedia.com.tw>
> To: <linux-mips@oss.sgi.com>
> Subject: fork() vs vfork()
> Date: Thu, 20 Sep 2001 14:51:08 +0800
> 
> Hi all,
> 
> How does linux-mips treat the vfork() function?
> I can see the fork() implemented in syscall.c as following:
> 
> save_static_function(sys_fork);
> static_unused int _sys_fork(struct pt_regs regs)
> {
>         int res;
>         res = do_fork(SIGCHLD, regs.regs[29], &regs, 0);
>         return res;
> }

> Why not do the same "sys_vfork" in linux-mips?
> Does it mean that MIPS does not support vfork() or vfork() is equal to fork() in MIPS platform?

Hint: save_static_function is a macro.

  Ralf
