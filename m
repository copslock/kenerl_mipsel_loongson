Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4OMoMX09733
	for linux-mips-outgoing; Thu, 24 May 2001 15:50:22 -0700
Received: from blackdog.wirespeed.com ([208.170.106.25])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4OMoLF09730
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 15:50:21 -0700
Received: from redhat.com (IDENT:joe@uberdog.hsv.redhat.com [172.16.16.108])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id RAA12329;
	Thu, 24 May 2001 17:35:57 -0500
Message-ID: <3B0D8F51.6000100@redhat.com>
Date: Thu, 24 May 2001 17:46:41 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.8.1) Gecko/20010422
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010524173937.19424A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Maciej W. Rozycki wrote:

> On Thu, 24 May 2001, Kevin D. Kissell wrote:
> 
> 
>>>  First, we are talking about glibc and not the entire userland.
>> 
>> But since essentially the entire userland is linked with glibc,
>> I'm not sure how much that distinction matters, in practical
>> terms.
> 
> 
>  Do you link statically?  If not, then almost no code from glibc is
> incorporated into your binaries, with an unimportant exception of a few
> functions from libc_nonshared.
> 

and those pesky little inlined code snippets...

#define PT_EI extern inline

PT_EI long int
testandset (int *spinlock)

which of course uses ll/sc if your world is built for _MIPS_ISA >= 
_MIPS_ISA_MIPS2


This can be fixed, of course. 

-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
