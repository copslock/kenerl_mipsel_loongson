Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4TDI1a25640
	for linux-mips-outgoing; Tue, 29 May 2001 06:18:01 -0700
Received: from blackdog.wirespeed.com ([208.170.106.25])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4TDHwd25635
	for <linux-mips@oss.sgi.com>; Tue, 29 May 2001 06:17:58 -0700
Received: from redhat.com (IDENT:joe@uberdog.hsv.redhat.com [172.16.16.108])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id HAA24136;
	Tue, 29 May 2001 07:51:54 -0500
Message-ID: <3B139DF6.2060203@redhat.com>
Date: Tue, 29 May 2001 08:02:46 -0500
From: Joe deBlaquiere <jadb@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.8.1) Gecko/20010422
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010528190412.15200Q-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Maciej W. Rozycki wrote:

> On Mon, 28 May 2001, Kevin D. Kissell wrote:
> 
> 
>> Use a global variable testable by the inline code?
> 
> 
>  With both variants inlined?  Now that's really ugly.
> 
> 
>>>  Are vr41xx plain ISA I or crippled ISA II+ CPUs?
>> 
>> Actually, they are crippled MIPS III+ 64-bit CPUs
> 
> 
>  Then an ll/sc and lld/scd emulation seems to be most appropriate here.  I
> don't think we want to add _test_and_set() to mips64*-linux. 

All the cases I've seen have been for 32-bit kernels. A 64-bit PDA kernel seems like a wee tiny bit of overkill



-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
