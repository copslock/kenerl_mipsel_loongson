Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 13:48:26 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:65462 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133594AbVLBNsJ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Dec 2005 13:48:09 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id jB2Dpd55011699;
	Fri, 2 Dec 2005 05:51:40 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id jB2Dpblk008895;
	Fri, 2 Dec 2005 05:51:38 -0800 (PST)
Message-ID: <439051B5.9060500@mips.com>
Date:	Fri, 02 Dec 2005 14:52:53 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Florian DELIZY <florian.delizy@sagem.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Re : where to set the BEV to normal of status in kernel source?
References: <OF5E474B6B.A94FD801-ONC12570CB.004B3FC5-C12570CB.004B4D6D@sagem.com>
In-Reply-To: <OF5E474B6B.A94FD801-ONC12570CB.004B3FC5-C12570CB.004B4D6D@sagem.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

The BEV bit of Status is cleared by the macro setup_c0_status_pri which
is invoked in kernel_entry.  See arch/mips/kernel/head.S.  It's of course
possible that a bootloader will already have cleared it, but it should not
be necessary.  grep is your friend.  ;o)

		Regards,

		Kevin K.

Florian DELIZY wrote:
> Subject : where to set the BEV to normal of status in kernel source?
> 
>>i don't find it in load_mmu(), who can point out for me?
>>thanks!
> 
> 
> Well, if you are speaking about the BEV flag from the Status (SR) register 
> (CP0_STATUS aka $12 of the 1st coprocessor)
> then it controls the interruption/exception handler place, I don't see the 
> relation with mmu ... 
> 
> 
>>is that must be set in bootloader?
> 
> 
> OK, I see, it should be set to 0 by the boot loader so that the TLB 
> exceptions (related to the MMU) goes in RAM. So 
> the kernel does not change it actually and hope the boot loader did.
> 
> -- Florian Delizy
> 
> 
> 
> 
> 
> 
