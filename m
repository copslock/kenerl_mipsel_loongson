Received:  by oss.sgi.com id <S42286AbQGTBkS>;
	Wed, 19 Jul 2000 18:40:18 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:11788 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42280AbQGTBjg>;
	Wed, 19 Jul 2000 18:39:36 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id SAA25410;
	Wed, 19 Jul 2000 18:39:02 -0700
Date:   Wed, 19 Jul 2000 18:39:02 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
Message-ID: <20000719183901.A24731@chem.unr.edu>
References: <20000719101346.B7480@chem.unr.edu> <Pine.SGI.4.10.10007191916250.7274-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.SGI.4.10.10007191916250.7274-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Wed, Jul 19, 2000 at 07:56:25PM -0300
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 19, 2000 at 07:56:25PM -0300, J. Scott Kasten wrote:

> I think the x libs are a good place to start, because I can guarantee that
> I'm breaking those, yet you claim to have them working.  I also know that
> I can grab someone else's prebuilt and compile against those and get
> working apps.  Thus the x libs demonstrate all the "features" of the
> problem that I'm encountering.

Sure.

> #1  You say you built X using the tool chain for Simple 0.2b.  Does that
> mean you compiled it natively on an Indy with what was effectively Simple
> 0.2b installed?  Or was it cross compiled using the same releases of the
> tools?

It was built natively. You will need to obtain cpp from egcs 1.1.2 and
place it into /lib in order to accomplish this. You can get this at
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/userland-0.2b/bin/cpp

> #2 You say X 4.0.  Can you be more specific?  Was it an official 4.0
> tarball on the xfree ftp site?  Pulled from CVS?  Or was it really a
> 4.0.1?  Basicly, I want the exact same starting sources that you used.

It is XFree86 4.0 official + the 000531 version of Guido's patch.

> #3 Where can I get Guido's X patch?

ftp://oss.sgi.com/pub/linux/mips/X/source/newport_000531.diff.gz

> #4 What if anything did you add to the host.def or other config files
> before doing "make World"?

I changed nothing.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
