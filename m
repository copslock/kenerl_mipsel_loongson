Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1J2YPW04210
	for linux-mips-outgoing; Mon, 18 Feb 2002 18:34:25 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1J2YM904207
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 18:34:22 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g1J1YJN15989;
	Mon, 18 Feb 2002 17:34:19 -0800
Date: Mon, 18 Feb 2002 17:34:19 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: Girish Gulawani <girishvg@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Page Size 16KB.
Message-ID: <20020218173419.A15980@momenco.com>
References: <002301c1b8d2$22a0efe0$443784d3@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002301c1b8d2$22a0efe0$443784d3@gol.com>; from girishvg@yahoo.com on Tue, Feb 19, 2002 at 08:15:18AM +0900
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Does your userspace shell set the CREAD flag properly?

Matt

On Tue, Feb 19, 2002 at 08:15:18AM +0900, Girish Gulawani wrote:
> hi, all.
> while in the process of changing page size of kernel to 16KB i am facing a
> strange problem. the kernel boots up & user command, currently statically
> linked shell, loads. it displays first prompt.  pressing enter keys, the
> serial device receives the interrupts but no activity on shell's part. where
> could the shell possibly be stuck?
> this is LSI MIPS EZ4021 implementation. please please help!!!
> many thanks & regards,
> girish.
> 
> 
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer
