Received:  by oss.sgi.com id <S553904AbRAPSzS>;
	Tue, 16 Jan 2001 10:55:18 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:6159 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553910AbRAPSzO>;
	Tue, 16 Jan 2001 10:55:14 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6C5F57FB; Tue, 16 Jan 2001 19:54:31 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EE055F597; Tue, 16 Jan 2001 19:48:17 +0100 (CET)
Date:   Tue, 16 Jan 2001 19:48:17 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116194817.B12610@paradigm.rfc822.org>
References: <20010116153618.A1347@paradigm.rfc822.org> <Pine.GSO.3.96.1010116162557.5546J-100000@delta.ds2.pg.gda.pl> <20010116174905.D7327@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116174905.D7327@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Jan 16, 2001 at 05:49:05PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 05:49:05PM +0100, Florian Lohoff wrote:
> On Tue, Jan 16, 2001 at 05:01:15PM +0100, Maciej W. Rozycki wrote:
> > 
> >  Meanwhile, could you please try to boot with "mem=0x07800000@0x08800000"
> > command line option?  This will show if the non-contiguous memory is the
> > problem or not -- you have a relatively small block at the beginning.
> > 
> 
> Works
> 

Once removed all the debugging stuff even without the mem= parm - Interesting.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
