Received:  by oss.sgi.com id <S553683AbRBQCAb>;
	Fri, 16 Feb 2001 18:00:31 -0800
Received: from sgigate.SGI.COM ([204.94.209.1]:51881 "EHLO dea.waldorf-gmbh.de")
	by oss.sgi.com with ESMTP id <S553661AbRBQCAG>;
	Fri, 16 Feb 2001 18:00:06 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1H1x7803433;
	Fri, 16 Feb 2001 17:59:07 -0800
Date:   Fri, 16 Feb 2001 17:59:02 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     Stockli Reto <stockli@geo.umnw.ethz.ch>, linux-mips@oss.sgi.com
Subject: Re: R10000 SGI O2
Message-ID: <20010216175902.C2233@bacchus.dhis.org>
References: <3A895FF4.B627089E@geo.umnw.ethz.ch> <20010213190716.A29070@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010213190716.A29070@chem.unr.edu>; from wesolows@chem.unr.edu on Tue, Feb 13, 2001 at 07:07:16PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 13, 2001 at 07:07:16PM -0800, Keith M Wesolowski wrote:

> > For not repeating here what has already been done:
> > Has anyone ever tried the same before and what are the problems to
> > encounter? I will most likely boot from a bootp linux server. Is there a
> > chance that I get a console on my O2 or do I only have a serial
> > connection.
> 
> There is no chance whatever that you will get anything.  If you want
> to have any chance at all of getting this to work I would recommend
> you ask Harald for his latest patch; it provides some level of support
> for r5k-based IP32 (O2) systems.  r10k O2 suffers from the same
> cache-noncoherency problem as r10k I2 does, and to the best of my
> knowledge nobody has ever really tried to even boot one.
> 
> Not to discourage you at all...there's just a lot of work to do.

It's really hard work to do.  R12000 O2s however should be much easier to
do; the processor feature which causes so much grief in the O2 can be
disabled there.

  Ralf
