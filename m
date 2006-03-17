Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 13:09:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:42686 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133395AbWCQNJ3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 13:09:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2HDIpwn004937;
	Fri, 17 Mar 2006 13:18:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2HDIoTF004935;
	Fri, 17 Mar 2006 13:18:50 GMT
Date:	Fri, 17 Mar 2006 13:18:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vadivelan@soc-soft.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Init not working in 64-bit kernel
Message-ID: <20060317131850.GA3771@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C01524CFE@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C01524CFE@soc-mail.soc-soft.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 17, 2006 at 03:36:50PM +0530, Vadivelan@soc-soft.com wrote:

> 	I'm porting a 64-bit linux kernel provided for a mips4
> architecture to a mips3 target board. The existing NFS root file system
> has been compiled for a 64-bit mips4 architecture.
> If I mount this file system, the init does not run.
> After mounting the filesystem, I get the following messages and the
> kernel hangs.
> 
> -------------------------------------------------
> Looking up port of RPC 100003/2 on 192.168.5.93
> Looking up port of RPC 100005/1 on 192.168.5.93
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 132k freed

That's a rather generic kind of death uppon entry of userspace sympthom,
so I cannot really give alot of advice other than below:

> I also tried to mount a 32-bit working NFS root filesystem.
> Still I get the same problem. I thought 32-bit binaries will execute
> fine in 64-bit kernel.

They do - but you need to enable 32-bit compatibility:

CONFIG_MIPS32_COMPAT=y
CONFIG_MIPS32_O32=y

And if you have an N32 root filesystem (unlikely) you also have to set
CONFIG_MIPS32_N32=y.

> Do I have to recompile the binutils and glibc for my target file system?

No.  The entire software should just work.

> Kindly ignore the confidentiality notice attached at the end of the
> mail. It is an automatically generated one and I cannot remove it.I'm
> extremely sorry for the inconvenience.

We're fabulous at ignoring things ;-)

  Ralf
