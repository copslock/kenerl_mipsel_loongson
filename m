Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 19:41:21 +0000 (GMT)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:23301 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225262AbTBTTlU>;
	Thu, 20 Feb 2003 19:41:20 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id h1KJfHN06769;
	Thu, 20 Feb 2003 14:41:17 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h1KJfHf29420;
	Thu, 20 Feb 2003 14:41:17 -0500
Received: from deneb.localdomain (msalter.cipe.redhat.com [10.0.0.36])
	by pobox.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h1KJfFt18445;
	Thu, 20 Feb 2003 14:41:16 -0500
Received: by deneb.localdomain (Postfix, from userid 500)
	id 2A21378A6D; Thu, 20 Feb 2003 14:41:15 -0500 (EST)
From: Mark Salter <msalter@redhat.com>
To: tpolgar@freehandsystems.com
Cc: ppopov@mvista.com, krishnakumar@naturesoft.net,
	linux-mips@linux-mips.org
In-reply-to: <3E552CDF.ECD08EEF@freehandsystems.com> (message from Tibor
	Polgar on Thu, 20 Feb 2003 11:30:39 -0800)
Subject: Re: Ramdisk image on flash.
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <3E552CDF.ECD08EEF@freehandsystems.com>
Message-Id: <20030220194115.2A21378A6D@deneb.localdomain>
Date: Thu, 20 Feb 2003 14:41:15 -0500 (EST)
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msalter@redhat.com
Precedence: bulk
X-list: linux-mips

>>>>> Tibor Polgar writes:

> Pete Popov wrote:
>> 
>> On Wed, 2003-02-19 at 22:05, Krishnakumar. R wrote:
>> > Hi,
>> >
>> > Is there any way that I can keep
>> > a ramdisk image (containing the root filesystem)
>> > in a flash device and boot to it.
>> 
>> Yes, and other architectures have support for passing arguments to the
>> kernel that tell it where the ramdisk is. I don't know that we've done
>> that for MIPS, yet.  It wouldn't be too hard to do and maybe someone on
>> this list is already working on it (I think someone actually is working
>> on it and was preparing a patch for Ralf).

> For having separate initrd and kernel load we also need an aware bootloader
> that knows where to find the ramdisk.   RedBoot, from what i read, seems to be
> i386 specific.

Not at all. RedBoot can be used to pass a command line to MIPS kernels. It
would be simple to add the passing of a ramdisk address. It already supports
ramdisks from ARM and SH kernels.

--Mark
