Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6J6dMRw015519
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 23:39:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6J6dMXd015518
	for linux-mips-outgoing; Thu, 18 Jul 2002 23:39:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6J6dCRw015508
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 23:39:12 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6J6dbXb010467;
	Thu, 18 Jul 2002 23:39:37 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA25042;
	Thu, 18 Jul 2002 23:39:38 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6J6ddb10587;
	Fri, 19 Jul 2002 08:39:39 +0200 (MEST)
Message-ID: <3D37B42A.8561D3BC@mips.com>
Date: Fri, 19 Jul 2002 08:39:38 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: "H. J. Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: Malta bus error
References: <3D375B4C.9000403@mvista.com> <20020718180759.A2091@lucon.org> <3D3765F1.6050606@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:

> H. J. Lu wrote:
> > On Thu, Jul 18, 2002 at 05:20:28PM -0700, Jun Sun wrote:
> >
> >>I got the following bus error on Malta.  Does anybody know what causes the
> >>fault?  Is there anyway to disable the error?  Or we should install a malta
> >>bus_error_handler() to discard this kind of error?
> >>
> >>Apparently the error has something to do with the code layout as it only
> >>happens when I start to modify an unrelated function( do_ri()).
> >>
> >>I am using the latest linux_2_4 branch from oss.sgi.com CVS tree.
> >>
> >
> >
> > I got zero problems with 2.4 kernel on oss as of Jul 11 08:18.
> >
>
> Me neither, until I made the following change.  I of course use my own config
> file.
>
> Using Malta's own BE handler to ignore bus error seems to fix the problem,
> although I am not sure if it is the right fix.
>

Ignoring bus errors is usually not healthy, it indicates a problem, that I would
prefer we find, instead of ignoring it.


>
> Jun
>
> --- arch/mips/kernel/traps.c.orig       Thu Jul 18 15:39:50 2002
> +++ arch/mips/kernel/traps.c    Thu Jul 18 16:49:32 2002
> @@ -614,8 +614,7 @@
>    */
>   asmlinkage void do_ri(struct pt_regs *regs)
>   {
> -       if (!user_mode(regs))
> -               BUG();
> +       die_if_kernel("no ll/sc emulation for kernel code", regs);
>
>   #ifndef CONFIG_CPU_HAS_LLSC
>
> Jun

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
