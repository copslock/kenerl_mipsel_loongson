Received:  by oss.sgi.com id <S553923AbQLAADB>;
	Thu, 30 Nov 2000 16:03:01 -0800
Received: from u-59-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.59]:45320
        "EHLO u-59-20.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553918AbQLAACx>; Thu, 30 Nov 2000 16:02:53 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869735AbQLAACe>;
	Fri, 1 Dec 2000 01:02:34 +0100
Date:	Fri, 1 Dec 2000 01:02:34 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:	Ian Chilton <ian@ichilton.co.uk>,
        Jesse Dyson <jesse@winston-salem.com>, linux-mips@oss.sgi.com
Subject: Re: Kernel Boot Hard Locks Indigo 2
Message-ID: <20001201010234.B6172@bacchus.dhis.org>
References: <20001129191730.A22085@woody.ichilton.co.uk> <20001129112640.A22235@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001129112640.A22235@chem.unr.edu>; from wesolows@chem.unr.edu on Wed, Nov 29, 2000 at 11:26:40AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 29, 2000 at 11:26:40AM -0800, Keith M Wesolowski wrote:

> PROMs older than a certain date (which may be sometime in 1995)
> require ECOFF kernels because they are incapable of understanding ELF.
> The symptom is mentioned in the FAQ.  This seems to happen with most
> if not all Indigo2s and a few older Indys.
> 
> > > PROM Monitor SGI Version 5.1 Rev B IP22 Sep 16, 1993 (BE)
> > 
> > Not sure, Ralf will be able to tell you what's the score with that..
> 
> You need ECOFF.  My Indigo2 has this date also and does not understand
> ELF.

Rule of thumb, R5k IP22 can handle ELF, pre-R5k firmware may or may not.

  Ralf
