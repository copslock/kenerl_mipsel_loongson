Received:  by oss.sgi.com id <S553774AbQK2T3s>;
	Wed, 29 Nov 2000 11:29:48 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:29188 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553764AbQK2T3Y>;
	Wed, 29 Nov 2000 11:29:24 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id LAA23506;
	Wed, 29 Nov 2000 11:26:40 -0800
Date:   Wed, 29 Nov 2000 11:26:40 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ian Chilton <ian@ichilton.co.uk>
Cc:     Jesse Dyson <jesse@winston-salem.com>, linux-mips@oss.sgi.com
Subject: Re: Kernel Boot Hard Locks Indigo 2
Message-ID: <20001129112640.A22235@chem.unr.edu>
References: <20001129191730.A22085@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001129191730.A22085@woody.ichilton.co.uk>; from ian@ichilton.co.uk on Wed, Nov 29, 2000 at 07:17:30PM +0000
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 29, 2000 at 07:17:30PM +0000, Ian Chilton wrote:

> >  I believe I need an ecoff version of the
> > kernel (not sure exactly what that means--forgive me)
> 
> I am not too sure either...all I know is some proms require this
> doing...

PROMs older than a certain date (which may be sometime in 1995)
require ECOFF kernels because they are incapable of understanding ELF.
The symptom is mentioned in the FAQ.  This seems to happen with most
if not all Indigo2s and a few older Indys.

> > PROM Monitor SGI Version 5.1 Rev B IP22 Sep 16, 1993 (BE)
> 
> Not sure, Ralf will be able to tell you what's the score with that..

You need ECOFF.  My Indigo2 has this date also and does not understand
ELF.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
