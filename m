Received:  by oss.sgi.com id <S554070AbRBNDHT>;
	Tue, 13 Feb 2001 19:07:19 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:14349 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S554063AbRBNDHL>;
	Tue, 13 Feb 2001 19:07:11 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id TAA29416;
	Tue, 13 Feb 2001 19:07:16 -0800
Date:   Tue, 13 Feb 2001 19:07:16 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Stockli Reto <stockli@geo.umnw.ethz.ch>
Cc:     linux-mips@oss.sgi.com
Subject: Re: R10000 SGI O2
Message-ID: <20010213190716.A29070@chem.unr.edu>
References: <3A895FF4.B627089E@geo.umnw.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A895FF4.B627089E@geo.umnw.ethz.ch>; from stockli@geo.umnw.ethz.ch on Tue, Feb 13, 2001 at 05:25:25PM +0100
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 13, 2001 at 05:25:25PM +0100, Stockli Reto wrote:

> I will give a try later to have my SGI O2 R10000 175MHz running Linux
> and will report found problems and possible solutions. 

Well, the most serious problem is known: that architecture isn't
supported.

> For not repeating here what has already been done:
> Has anyone ever tried the same before and what are the problems to
> encounter? I will most likely boot from a bootp linux server. Is there a
> chance that I get a console on my O2 or do I only have a serial
> connection.

There is no chance whatever that you will get anything.  If you want
to have any chance at all of getting this to work I would recommend
you ask Harald for his latest patch; it provides some level of support
for r5k-based IP32 (O2) systems.  r10k O2 suffers from the same
cache-noncoherency problem as r10k I2 does, and to the best of my
knowledge nobody has ever really tried to even boot one.

Not to discourage you at all...there's just a lot of work to do.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
