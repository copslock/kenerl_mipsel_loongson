Received:  by oss.sgi.com id <S553861AbQJ3PJe>;
	Mon, 30 Oct 2000 07:09:34 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:8978 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553842AbQJ3PJN>;
	Mon, 30 Oct 2000 07:09:13 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id HAA06669;
	Mon, 30 Oct 2000 07:08:46 -0800
Date:   Mon, 30 Oct 2000 07:08:46 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     ian@ichilton.co.uk
Cc:     linux-mips@oss.sgi.com
Subject: Re: GCC Problem
Message-ID: <20001030070846.A6450@chem.unr.edu>
References: <20001030115010.A18728@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001030115010.A18728@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Mon, Oct 30, 2000 at 11:50:10AM +0000
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 11:50:10AM +0000, Ian Chilton wrote:

> I had a problem compiling egcs 1.0.3a nativly. I had it a few weeks
> ago, and fixed it, and it worked. Now, I am having exactly the same
> problem again, and I can't seem to fix it...annoying..

> /lfstmp/egcs-1.0.3a/gcc-build/gcc/xgcc
> -B/lfstmp/egcs-1.0.3a/gcc-build/gcc/ -g -O2 -fno-implicit-templates
> -EL -Wl,-soname,libstdc++.so.`echo 2.8.0 | sed
> 's/\([0-9][.][0-9]\).*/\1/'` -shared -o libstdc++.so.2.8.0 `cat
> piclist` -lm /usr/lib/libm.so: could not read symbols: Invalid
> operation collect2: ld returned 1 exit status make[4]: ***
> [libstdc++.so.2.8.0] Error 1

I used to get this too; I think it's simply a bug in old egcs. It
tries to multilib libstdc++, which is usually impossible, since you
would need to have both big and little endian libm.so in the same
place. Since you don't need little-endian (or big-endian, if building
mipsel) libstdc++ anyway, and the big endian one has already been
built, the error is ignorable.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
