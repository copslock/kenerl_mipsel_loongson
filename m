Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 02:45:53 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18019 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492020Ab0BYBpu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 02:45:50 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b85d6560000>; Wed, 24 Feb 2010 17:45:58 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Feb 2010 17:45:25 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 24 Feb 2010 17:45:25 -0800
Message-ID: <4B85D635.6050602@caviumnetworks.com>
Date:   Wed, 24 Feb 2010 17:45:25 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Brian Daniels <bdaniels@ciena.com>
CC:     linux-mips@linux-mips.org
Subject: Re: udelay() too slow by a factor of 2 on Cavium chips
References: <4B85D445.2090700@ciena.com>
In-Reply-To: <4B85D445.2090700@ciena.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2010 01:45:25.0874 (UTC) FILETIME=[33AA0520:01CAB5BC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/24/2010 05:37 PM, Brian Daniels wrote:
> We've noticed that udelay() and related functions are too slow by a
> factor of 2 on Cavium CPUs. I did some investigation and it seems to be
> related to the fact that Cavium is the only MIPS CPU family that has
> ARCH_HAS_READ_CURRENT_TIMER defined to use its hardware cycle counter
> (CvmCount) to calibrate loops-per-jiffy. Since udelay() uses lpj to
> calculate the number of loops to wait in __delay() it is affected by the
> lpj calibration.
>
> On a 600MHz Cavium system running 2.6.33-rc8 with HZ=250 the lpj is
> 2404728. This results in udelay() passing 601 to __delay() for a 1us
> delay which would work if __delay took 1 cycle per loop however it takes
> 2 cycles giving a delay of 2us.
>
> It seems the easiest way to fix the problem would be to remove the
> definition of ARCH_HAS_READ_CURRENT_TIMER for Cavium which would use the
> same lpj calibration delay loop as other MIPS CPUs. With this change on
> the same 600MHz system lpj is 1196032 which results in udelay() passing
> 299 to __delay() which would yield close to the desired 1us delay.
>
> I'm not sure what all of the implications would be of effectively
> halving lpj on Cavium CPUs or what the rationale was for defining
> ARCH_HAS_READ_CURRENT_TIMER for Cavium CPUs in the first place. I'm
> hoping someone more informed can take a look at it and propose a fix if
> what I've proposed isn't good enough.
>

Thanks for the report.  I will look at it.

David Daney
