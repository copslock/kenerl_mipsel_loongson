Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NI4bR16619
	for linux-mips-outgoing; Wed, 23 May 2001 11:04:37 -0700
Received: from blackdog.wirespeed.com ([208.170.106.25])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NI4YF16612;
	Wed, 23 May 2001 11:04:34 -0700
Received: from redhat.com (IDENT:joe@uberdog.hsv.redhat.com [172.16.16.108])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id MAA05949;
	Wed, 23 May 2001 12:37:53 -0500
Message-ID: <3B0BF7F8.3050306@redhat.com>
Date: Wed, 23 May 2001 12:48:40 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.8.1) Gecko/20010422
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Jun Sun <jsun@mvista.com>, Florian Lohoff <flo@rfc822.org>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Maciej, Jun,

	Didn't mean to bring up a sore point, but it seems that we haven't yet 
come to a consensus on what policy to have here. I think you both make 
valid points that I don't necesarily disagree with, but I would like to 
follow the counterpoint a little further.

Maciej W. Rozycki wrote:

> On Wed, 23 May 2001, Joe deBlaquiere wrote:
> 
> 
>> I would vote for option #4 - make sure the ll/sc emulation stuff works 
>> and use ll/sc in glibc instead of sysmips. Beyond the pthreads mutex 
> 
> 
>  Please don't.  The emulation is an overkill here and the overhead is
> painful for ISA I systems, which are usually not the fastest ones.  This
> has already been discussed here.
> 

There's overhead to sysmips also, so neither one is going to give 
stunning performance. All out performance isn't likely an issue on one 
of these systems anyways.


>  If you want to go for speed and use ll/sc on an ISA II+ system, then
> compile glibc for ISA II or better.  It will never call sysmips() then. 

	The problem here is that now I have mips, mipsel, and mipselnollsc 
configurations of the cross-tools, the c library and the binary 
applications. It's one extra configuration to maintain.

	There's no way to solve the endianness issues, but using emulation to 
handle missing instructions (be they floating point or ll/sc, or 
what-have-you) solves the minor differences in the instruction set from 
the library/application standpoint. If all MIPS processors used the same 
instruction set then we wouldn't have the problem at all. Of course 
there are very good reasons (and probably some silly ones too...) why 
ISAs are tailored.

	The kernel is already going to have to adjust some anyway, so keeping the 
differences in the kernel doesn't increase the testing burden. Throwing 
the problem over to glibc (and the toolchain) does increase the number 
of active configurations.

Just my opinion.

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
