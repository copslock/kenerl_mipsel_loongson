Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8JDdRg27454
	for linux-mips-outgoing; Wed, 19 Sep 2001 06:39:27 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8JDdOe27448
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 06:39:24 -0700
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15jhZM-0001A8-00; Wed, 19 Sep 2001 09:39:16 -0400
Date: Wed, 19 Sep 2001 09:39:16 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Shaolin Zhang <zhangshaolin@huawei.com>
Cc: Ernest Jih <ernest.jih@idt.com>, linux-mips@oss.sgi.com, renwei@huawei.com
Subject: Re: kgdb with linux-mips problem
Message-ID: <20010919093916.A4421@nevyn.them.org>
References: <00fe01c140b4$ad3f9200$cd22690a@huawei.com> <20010918224620.A22455@nevyn.them.org> <016001c140b9$c5a2e900$cd22690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <016001c140b9$c5a2e900$cd22690a@huawei.com>; from zhangshaolin@huawei.com on Wed, Sep 19, 2001 at 11:18:37AM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 19, 2001 at 11:18:37AM +0800, Shaolin Zhang wrote:
> My gcc verison is 2.95.3 19991030, gdb verison is 20000204.
> What is current version of bintuil and egcs,and where can i get it ?
> thanks.

>From gcc.gnu.org/sources.redhat.com.  The one you'll really need to
update is GDB: sources.redhat.com/pub/gdb/, I think, and look for a
snapshot from the past few weeks.

I highly recommend you use an existing toolchain - MontaVista's
(www.mvista.com, look for Journeyman) or H.J. Lu's (don't know the URL
offhand).

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
