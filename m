Received:  by oss.sgi.com id <S553700AbRBGUtf>;
	Wed, 7 Feb 2001 12:49:35 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:32014 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S553691AbRBGUtR>; Wed, 7 Feb 2001 12:49:17 -0800
Received: from redhat.com (IDENT:joe@dhcp-4.wirespeed.com [172.16.17.4])
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id OAA10922;
	Wed, 7 Feb 2001 14:36:54 -0600
Message-ID: <3A81B388.1090806@redhat.com>
Date:   Wed, 07 Feb 2001 14:43:52 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     Jun Sun <jsun@mvista.com>
CC:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
References: <E14QZie-00011I-00@the-village.bc.nu> <3A81A3DC.E75E6045@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



Jun Sun wrote:

> Alan Cox wrote:
> 
>>>  The i386 way seems reasonable, IMHO.  Have a configure option to enable
>>> an FPU emulator.  Panic upon boot if no FP hardware is available and no
>>> emulator is compiled in.
>> 
>> Its an interesting question whether it belongs in the kernel or libc.
>> Discuss ;)
>> 
> 
> 
> I favor the libc approach as it is faster.

You can still compile in the FP emulator just 'in case'... That way you 
leave it up to the application as to whether to do be quick or cheap. 
This also ensures binary portability (well, mostly, there's always .so 
ABI issues and the like...)

> 
> Unfortunately I don't think glibc for MIPS can be configured with
> --without-fp.  I modified a patch to get glibc 2.0.6 working for no-fp config,
> but it is not a clean one.  Is anybody working on that for the latest glibc
> 2.2?
> 
> 

AFAIK, 2.0.7-20 (from Jay Carlson), 2.1.95 (from SGI), 2.2, and the 
current CVS can all be configured for soft float.

>> Also we missed a trick on the x86 and I want to fix that one day, which is
>> to have an __fpu ELF segment so if you boot an FPU emu kernel on an fpu
>> box you regain 47K
> 
> 
> Ironically for MIPS you MUST have the FPU emulater when the CPU actually has a
> FPU. :-)
> 

I'm confused here... why is this?



-- 
Joe
