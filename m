Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 22:29:43 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:58375 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225457AbUCEW3m>;
	Fri, 5 Mar 2004 22:29:42 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i25M4M528113
	for <linux-mips@linux-mips.org>; Fri, 5 Mar 2004 17:04:22 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i25MTdM04524
	for <linux-mips@linux-mips.org>; Fri, 5 Mar 2004 17:29:39 -0500
Received: from [172.16.25.141] (dhcp-172-16-25-141.sfbay.redhat.com [172.16.25.141])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i25MTdR32645
	for <linux-mips@linux-mips.org>; Fri, 5 Mar 2004 14:29:39 -0800
Subject: Re: gcc support for mips32 release 2]
From: Eric Christopher <echristo@redhat.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1078525778.3353.2.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Mar 2004 14:29:38 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

More on the thread from Chris since it was cross posted to gcc@ as well.

-eric

-----Forwarded Message-----
> From: cgd@broadcom.com
> To: long21st@yahoo.com
> Cc: gcc@gcc.gnu.org
> Subject: Re: gcc support for mips32 release 2
> Date: Fri, 05 Mar 2004 08:19:08 -0800
> 
> At Fri, 5 Mar 2004 07:54:19 +0000 (UTC), "Long Li" wrote:
> > I have a question about gcc support for mips32 release
> > 2. I noticed that in gnu as(assembler) 2.14, there is
> > an option for it, but does newest gcc version support
> > mips32 release 2? I did not find it in the mips.c or
> > configure file. 
> 
> as others have noted, I contributed it to GCC and it should appear in
> 3.4.
> 
> Note that 3.4 has only partial support for the new instructions.  In
> particular, it only knows how to generate rotates and, IIRC, some of
> the sign-extend instructions.  (it's been a while since i did the
> work.)
> 
> It does *not* know how to do use the insert/extract instructions.
> 
> 
> If anybody knows of a MIPS64 release 2 implementation, I also have
> support for GCC to do that.  (Problem is, the way the GCC MIPS
> back-end currently is, it really wants a processor implementation
> before a new ISA is added.)
> 
> I also have a number of sim changes for 32r2 -- can't remember if i've
> integrated all of them or not, yet -- and 64r2.  (Fairly sure i've not
> done the 64r2 changes.)
> 
> 
> 
> chris
-- 
Eric Christopher <echristo@redhat.com>
