Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OKgXt01843
	for linux-mips-outgoing; Thu, 24 Jan 2002 12:42:33 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OKgUP01812
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 12:42:30 -0800
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16TplO-00029S-00
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 13:42:23 -0600
Message-ID: <3C507199.CBCF56EF@cotw.com>
Date: Thu, 24 Jan 2002 14:42:01 -0600
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: gdb, pthreads and MIPS
References: <3C502108.B4024075@cotw.com> <20020124121544.A26522@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Daniel Jacobowitz wrote:
--snip--
> 
> Primarily glibc.  I've spent a long long time trying to get this fixed
> and Ulrich categorically refused the patch.  The size of prgregset in
> the headers is wrong.
> 
> Edit /usr/include/sys/procfs.h, change the typedef of pr*regset from
> *regset_t to elf_*regset_t, rebuild GDB, see if it works.

You sure made my day! This fix worked.

Wow, I sure can believe it took you "a long long time to get this
fixed".

Thanks,
Scott

> 
> --
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer

-- 
Scott A. McConnell
