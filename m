Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4O4F8i03805
	for linux-mips-outgoing; Wed, 23 May 2001 21:15:08 -0700
Received: from blackdog.wirespeed.com ([208.170.106.25])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4O4F7F03801
	for <linux-mips@oss.sgi.com>; Wed, 23 May 2001 21:15:07 -0700
Received: from redhat.com (IDENT:joe@dhcp-245.hsv.redhat.com [172.16.17.245] (may be forged))
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id XAA08458;
	Wed, 23 May 2001 23:00:29 -0500
Message-ID: <3B0C89E0.2060204@redhat.com>
Date: Wed, 23 May 2001 23:11:12 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.8.1) Gecko/20010422
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010523212941.16787A-100000@delta.ds2.pg.gda.pl> <011501c0e3e3$007c4780$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Kevin D. Kissell wrote:


>> 
>>  So the problem is?
> 
> 
> The problem is that, out in industry, not everyone wants to
> build their entire userland from source, and nobody particularly 
> wants to deal with  the product management problems of making, 
> maintaining,  testing, and distributing all the permutations of BE/LE, 
> FP/noFP, LLSC/noLLSC, etc, etc.
> 
Could not have said it better myself. If you have the emulation then you 
can always use a noLLSC version of glibc if you are performance-driven. 
Otherwise you can _also_ use the generic LLSC version. The overhead of 
having a few hundreds of words of code is pretty small (compared with 
70+k of filenames via the BUG() macro) and ensures that either glibc 
will work. It's the best of both worlds.

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
