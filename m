Received:  by oss.sgi.com id <S42364AbQI0RbX>;
	Wed, 27 Sep 2000 10:31:23 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:21000 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42278AbQI0RbL>;
	Wed, 27 Sep 2000 10:31:11 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA14696;
	Wed, 27 Sep 2000 10:30:29 -0700
Date:   Wed, 27 Sep 2000 10:30:29 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: egcs problem
Message-ID: <20000927103029.D13870@chem.unr.edu>
References: <20000926233724.A15790@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000926233724.A15790@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Tue, Sep 26, 2000 at 11:37:24PM +0100
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 11:37:24PM +0100, Ian Chilton wrote:

> make[4]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/el/libio'
> /lfstmp/egcs-1.0.3a/gcc-build/gcc/xgcc -B/lfstmp/egcs-1.0.3a/gcc-build/gcc/ -g -O2 -fno-implicit-templates  -EL -Wl,-soname,libstdc++.so.`echo 2.8.0 | sed 's/\([0-9][.][0-9]\).*/\1/'` -shared -o libstdc++.so.2.8.0 `cat piclist` -lm
> /usr/lib/libm.so: could not read symbols: Invalid operation
> collect2: ld returned 1 exit status
> make[3]: *** [libstdc++.so.2.8.0] Error 1
> make[3]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/el/libstdc++'

I believe this is ignorable. It's trying to build a little-endian
libstdc++ by its multilib mechanism, but your system is big-endian so
the math library isn't compatible with it. Since it's already built
the bigendian one, just do make install and you should have a working
library. You didn't indicate what happened when building groff, so I
won't attempt to guess.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
