Received:  by oss.sgi.com id <S554065AbRBVDYT>;
	Wed, 21 Feb 2001 19:24:19 -0800
Received: from gnyf.wheel.dk ([193.162.159.104]:45307 "EHLO gnyf.wheel.dk")
	by oss.sgi.com with ESMTP id <S554060AbRBVDYE>;
	Wed, 21 Feb 2001 19:24:04 -0800
Received: (from soren@localhost)
	by gnyf.wheel.dk (8.9.1/8.9.1) id EAA23129;
	Thu, 22 Feb 2001 04:23:59 +0100 (CET)
Date:   Thu, 22 Feb 2001 04:23:58 +0100
From:   "Soren S. Jorvang" <soren@wheel.dk>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: R10000 SGI O2
Message-ID: <20010222042358.H22997@gnyf.wheel.dk>
References: <3A895FF4.B627089E@geo.umnw.ethz.ch> <20010213190716.A29070@chem.unr.edu> <20010216175902.C2233@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20010216175902.C2233@bacchus.dhis.org>; from Ralf Baechle on Fri, Feb 16, 2001 at 05:59:02PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 16, 2001 at 05:59:02PM -0800, Ralf Baechle wrote:
> > for r5k-based IP32 (O2) systems.  r10k O2 suffers from the same
> > cache-noncoherency problem as r10k I2 does, and to the best of my
> > knowledge nobody has ever really tried to even boot one.
> > 
> > Not to discourage you at all...there's just a lot of work to do.
> 
> It's really hard work to do.  R12000 O2s however should be much easier to
> do; the processor feature which causes so much grief in the O2 can be
> disabled there.

Unfortunately, noone I have talked to seems to know how
specifically to turn off speculative writes..

Does anyone on this list happen to know?


-- 
Soren
