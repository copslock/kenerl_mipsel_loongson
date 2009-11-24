Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 00:40:17 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7234 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493623AbZKXXkO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 00:40:14 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b0c6ed80000>; Tue, 24 Nov 2009 15:40:08 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 24 Nov 2009 15:39:27 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 24 Nov 2009 15:39:27 -0800
Message-ID: <4B0C6EAE.7060809@caviumnetworks.com>
Date:   Tue, 24 Nov 2009 15:39:26 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Adam Nielsen <a.nielsen@shikadi.net>
CC:     linux-mips@linux-mips.org
Subject: Re: Can you add a signature to the kernel ELF image?
References: <4B0C625B.5070408@shikadi.net>
In-Reply-To: <4B0C625B.5070408@shikadi.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2009 23:39:27.0521 (UTC) FILETIME=[5C87E110:01CA6D5F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Adam Nielsen wrote:
> Hi all,
> 
> I'm trying to port the kernel to an NCD HMX X-Terminal (MIPS R4600), but 
> the one thing I have to do before I can actually boot the image is 
> attach a signature to it. I have the signature 'code' in assembly[1], 
> but I'm not sure how to link it so that it ends up as the first bit of 
> code in the ELF image (the very first instruction is a 'b' to jump over 
> the actual signature text.)
> 
> Without this the boot monitor will refuse to boot the kernel.  Any 
> suggestions as to how I might accomplish this?
> 

Edit the linker script (arch/mips/kernel/vmlinux.lds.S)

David Daney
