Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4U0flH16394
	for linux-mips-outgoing; Tue, 29 May 2001 17:41:47 -0700
Received: from saturn.mikemac.com (saturn.mikemac.com [216.99.199.88])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4U0fhh16390
	for <linux-mips@oss.sgi.com>; Tue, 29 May 2001 17:41:43 -0700
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id IAA13454;
	Tue, 29 May 2001 08:45:20 -0700
Message-Id: <200105291545.IAA13454@saturn.mikemac.com>
To: Joe deBlaquiere <jadb@redhat.com>
cc: linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel 
In-Reply-To: Your message of "Tue, 29 May 2001 08:02:46 CDT."
             <3B139DF6.2060203@redhat.com> 
Date: Tue, 29 May 2001 08:45:20 -0700
From: Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>Date: Tue, 29 May 2001 08:02:46 -0500
>From: Joe deBlaquiere <jadb@redhat.com>
>To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
>Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
>
>
>
>Maciej W. Rozycki wrote:
>
>> On Mon, 28 May 2001, Kevin D. Kissell wrote:
>> 
>> 
>>> Use a global variable testable by the inline code?
>> 
>> 
>>  With both variants inlined?  Now that's really ugly.
>> 
>> 
>>>>  Are vr41xx plain ISA I or crippled ISA II+ CPUs?
>>> 
>>> Actually, they are crippled MIPS III+ 64-bit CPUs
>> 
>> 
>>  Then an ll/sc and lld/scd emulation seems to be most appropriate here.  I
>> don't think we want to add _test_and_set() to mips64*-linux. 
>
>All the cases I've seen have been for 32-bit kernels. A 64-bit PDA kernel seems like a wee tiny bit of overkill

  I've been asked about running 64 bit binaries on a VR4121.

  Mike McDonald
  mikemac@mikemac.com
