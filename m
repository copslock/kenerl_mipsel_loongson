Received:  by oss.sgi.com id <S42287AbQGTBws>;
	Wed, 19 Jul 2000 18:52:48 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:14092 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42280AbQGTBwb>;
	Wed, 19 Jul 2000 18:52:31 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id SAA25769;
	Wed, 19 Jul 2000 18:51:56 -0700
Date:   Wed, 19 Jul 2000 18:51:56 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
Message-ID: <20000719185153.B24731@chem.unr.edu>
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

> There is one thing at this point that would really really help.  I need to
> establish a reference point and follow someone elses procedures exactly to
> determine what the source of my problem is and why some of you are not
> seeing this to the extent that I am.  In this way, we can verify whether
> or not there is a bonified problem, and if it is with the tools, maybe get
> it fixed.

Before you get carried away with this, I should point out that I've
been looking at this problem in more detail. Many of my X programs
don't work either; they get SEGV, never bus errors. I suspect this is
a glibc bug. I can run a few programs, such as xhost and the server
itself. I did have a full X setup, including a working server, under
0.1. That was built exactly the same way I've done it under 0.2b. You
may wish to try both and see which works better.

If you like, I will return to 0.1 and duplicate my previous efforts. I
can then describe the exact procedure to you.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
