Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g240Wjp30916
	for linux-mips-outgoing; Sun, 3 Mar 2002 16:32:45 -0800
Received: from dea.linux-mips.net (a1as07-p52.stg.tli.de [195.252.188.52])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g240Wb930913
	for <linux-mips@oss.sgi.com>; Sun, 3 Mar 2002 16:32:39 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g23NWSe17853;
	Mon, 4 Mar 2002 00:32:28 +0100
Date: Mon, 4 Mar 2002 00:32:28 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Rani Assaf <rani@paname.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Changes to head.S
Message-ID: <20020304003228.A17827@dea.linux-mips.net>
References: <20020303185049.A1788@paname.org> <20020303225630.A16898@dea.linux-mips.net> <20020303230449.K1788@paname.org> <20020303231906.A17147@dea.linux-mips.net> <20020303235416.D3190@paname.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020303235416.D3190@paname.org>; from rani@paname.org on Sun, Mar 03, 2002 at 11:54:16PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 03, 2002 at 11:54:16PM +0100, Rani Assaf wrote:

> On Sun, Mar 03, 2002 at 11:19:06PM +0100, Ralf Baechle wrote:
> > these two lines in the linker script arch/mips/ld.script.in:
> > 
> >   . = ALIGN(8192);
> >   .data.init_task : { *(.data.init_task) }
> 
> Yep, I was just  looking at it. So the problem  is in init_task.c. The
> following line should be changed from:
> 
>         __attribute__((__section__(".text"))) =
> 
> to:
> 	__attribute__((__section__(".data.init_task"))) =
> 
> Right?

Yes, just as it already is in CVS for kernel 2.4.

  Ralf
