Received:  by oss.sgi.com id <S553784AbRBUMje>;
	Wed, 21 Feb 2001 04:39:34 -0800
Received: from u-18-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.18]:34544
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553747AbRBUMjO>; Wed, 21 Feb 2001 04:39:14 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1L6C9K07567;
	Wed, 21 Feb 2001 07:12:09 +0100
Date:   Wed, 21 Feb 2001 07:12:09 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Stockli Reto <stockli@geo.umnw.ethz.ch>
Cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@oss.sgi.com
Subject: Re: R10000 SGI O2
Message-ID: <20010221071209.A7335@bacchus.dhis.org>
References: <3A895FF4.B627089E@geo.umnw.ethz.ch> <20010213190716.A29070@chem.unr.edu> <20010216175902.C2233@bacchus.dhis.org> <3A90DE28.FCDE8CB8@geo.umnw.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A90DE28.FCDE8CB8@geo.umnw.ethz.ch>; from stockli@geo.umnw.ethz.ch on Mon, Feb 19, 2001 at 09:49:44AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Gruezi,

On Mon, Feb 19, 2001 at 09:49:44AM +0100, Stockli Reto wrote:

> Thanks Keith and Ralf for your information on running a R10000 O2 with
> Linux. I knew that the video and sound HW as well as some of the
> machine's graphics features were not supported by any linux drivers,
> because it's even hard on SGI/Irix to find useful documentation about
> this hardware! I guess this is the point why so few developers have
> programmed applications that would take advantage of the very nice
> capabilities of the machine.

You're mixing two completly different things.  SGI never released hardware
programming information for the O2 to the general public.  The graphics
APIs however have been published and there is a ton more good reasons to
stick with those like those APIs beying consistent beyond just the O2 and
even SGI platforms.

> So, I still would like to contribute something to the implementation of
> Linux on SGI machines and I have this O2 standing on my desk. I have
> installed and maintained some I386 based linux systems, but am not
> really into fixing kernels. As I see there's no kernel that will boot
> rightaway (with or without screen console). Let me know if the situation
> is hopeless or if I can make a step taking a current mips-kernel (any
> specific R10000-patch around there?) and start to consult R10000/ SGI O2
> manuals.

Only the mips64 kernel has R10000 support.  Anyway you want to use the
mips64 kernel as an O2 can have more memory than 32-bit kernel can handle.

> It would be nice, but maybe I'm too much on the admin/user side and for
> sure I am not into developing kernels. Anyway, curious I am...

Everybody was a newbie once at a time ...

  Ralf
