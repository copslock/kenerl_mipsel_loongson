Received:  by oss.sgi.com id <S554076AbRBVEMU>;
	Wed, 21 Feb 2001 20:12:20 -0800
Received: from [208.170.106.25] ([208.170.106.25]:2323 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S554069AbRBVEMR>; Wed, 21 Feb 2001 20:12:17 -0800
Received: from redhat.com (IDENT:joe@dhcp-246.hsv.redhat.com [172.16.17.246] (may be forged))
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id WAA23751;
	Wed, 21 Feb 2001 22:07:08 -0600
Message-ID: <3A949279.5020707@redhat.com>
Date:   Wed, 21 Feb 2001 22:15:53 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8) Gecko/20010217
X-Accept-Language: en
MIME-Version: 1.0
To:     Crossfire <xfire@xware.cx>
CC:     kjlin <kj.lin@viditec-netmedia.com.tw>, linux-mips@oss.sgi.com
Subject: Re: Does linux support for microprocessor without MMU?
References: <00ba01c09c6e$84788380$056aaac0@kjlin> <20010222133602.A24899@eris.xware.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Crossfire wrote:

> kjlin was once rumoured to have said:
> 
>> Howdy,
>> 
>> I got an embedded MIPS board recently.
>> It has the following features:
>> - CPU implements a five-stage pipeline with performance similar to the MIPS R3000 pipeline.
>> - MIPS32 compatible instruction set
>> - R4000 style privileged resource architecture.
>> - Without MMU.
>> 
>> I am estimating the possibility of porting linux on it.
>> Can Linux/MIPS 2.2 or 2.4 support for such a board which without MMU ?
>> Because i consider it is the most difficult part in the porting process.
>> Am i right?
> 
> 
> the Standard Linux kernels all require an MMU.  However, there is a
> version of the kernel known as "ucLinux" (Microcontroller Linux) which
> will run on CPUs without MMU.
> 
> I don't know if ucLinux has a MIPS target yet.
> 
> C.

There isn't (yet) support for MIPS on uClinux.

-- 
Joe

(aka joe@uclinux.org)
