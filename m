Received:  by oss.sgi.com id <S553790AbRBSItv>;
	Mon, 19 Feb 2001 00:49:51 -0800
Received: from ezksun.unizh.ch ([130.60.20.131]:7044 "EHLO geo.umnw.ethz.ch")
	by oss.sgi.com with ESMTP id <S553784AbRBSIts>;
	Mon, 19 Feb 2001 00:49:48 -0800
Received: from geo.umnw.ethz.ch (ezges53d [130.60.20.135])
	by geo.umnw.ethz.ch (8.8.8/8.8.8) with ESMTP id JAA04368;
	Mon, 19 Feb 2001 09:49:45 +0100 (MET)
Message-ID: <3A90DE28.FCDE8CB8@geo.umnw.ethz.ch>
Date:   Mon, 19 Feb 2001 09:49:44 +0100
From:   Stockli Reto <stockli@geo.umnw.ethz.ch>
Organization: Institute for Climate Research, ETH Zuerich
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@oss.sgi.com
Subject: Re: R10000 SGI O2
References: <3A895FF4.B627089E@geo.umnw.ethz.ch> <20010213190716.A29070@chem.unr.edu> <20010216175902.C2233@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi There

> 
> On Tue, Feb 13, 2001 at 07:07:16PM -0800, Keith M Wesolowski wrote:
> 
> > > For not repeating here what has already been done:
> > > Has anyone ever tried the same before and what are the problems to
> > > encounter? I will most likely boot from a bootp linux server. Is there a
> > > chance that I get a console on my O2 or do I only have a serial
> > > connection.
> >
> > There is no chance whatever that you will get anything.  If you want
> > to have any chance at all of getting this to work I would recommend
> > you ask Harald for his latest patch; it provides some level of support
> > for r5k-based IP32 (O2) systems.  r10k O2 suffers from the same
> > cache-noncoherency problem as r10k I2 does, and to the best of my
> > knowledge nobody has ever really tried to even boot one.
> >
> > Not to discourage you at all...there's just a lot of work to do.
> 
> It's really hard work to do.  R12000 O2s however should be much easier to
> do; the processor feature which causes so much grief in the O2 can be
> disabled there.
> 
>   Ralf

Thanks Keith and Ralf for your information on running a R10000 O2 with
Linux. I knew that the video and sound HW as well as some of the
machine's graphics features were not supported by any linux drivers,
because it's even hard on SGI/Irix to find useful documentation about
this hardware! I guess this is the point why so few developers have
programmed applications that would take advantage of the very nice
capabilities of the machine.

So, I still would like to contribute something to the implementation of
Linux on SGI machines and I have this O2 standing on my desk. I have
installed and maintained some I386 based linux systems, but am not
really into fixing kernels. As I see there's no kernel that will boot
rightaway (with or without screen console). Let me know if the situation
is hopeless or if I can make a step taking a current mips-kernel (any
specific R10000-patch around there?) and start to consult R10000/ SGI O2
manuals.

It would be nice, but maybe I'm too much on the admin/user side and for
sure I am not into developing kernels. Anyway, curious I am...

Cheers,
Reto
