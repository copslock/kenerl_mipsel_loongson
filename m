Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2009 17:31:12 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:15370 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493343AbZFZPbG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2009 17:31:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a44e8c40001>; Fri, 26 Jun 2009 11:27:01 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 08:26:49 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 08:26:49 -0700
Message-ID: <4A44E8B6.8010107@caviumnetworks.com>
Date:	Fri, 26 Jun 2009 08:26:46 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	joe seb <joe.seb8@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: linux porting - doubts
References: <4f9abdc70906260030q3cefba63tb2fd30245a7015df@mail.gmail.com>
In-Reply-To: <4f9abdc70906260030q3cefba63tb2fd30245a7015df@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jun 2009 15:26:49.0252 (UTC) FILETIME=[860DB640:01C9F672]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

joe seb wrote:
> Hi,
> 
> We are trying to port linux to our new platform based on MIPS32 24Kc.
> 
> In our platform we have physical RAM of 256M mapped from 0x90000000
> to 0xa0000000( KSEG0 - cached) and 0xb0000000 to 0xc0000000(KSEG1- 
> uncached).
> 
> We made the following changes for our platform,
> 
> CAC_BASE to  0x90000000 in spaces.h
> KSEG0 to 0x90000000 and KSEG1 to 0xb0000000 in addrspace.h
> CKSEG0 to 0x90000000 and CKSEG1 to 0xb0000000 in addrspace.h
> loadaddr to 0x90000000 in the Makefile under arch/mips folder.
> 
> Are these changes sufficient??
> Is there any other platform port with such variations which we can refer to
> make sure about the changes made.
> 

That seems mostly wrong.

The CAC_BASE, KSEG0, and CKSEG0 should probably be left unchanged.  You 
the load-y in arch/mips/Makefile for your target to the load address of 
the kernel.  Then when registering memory call  add_memory_region() only 
for the physical memory that you want the kernel to use.  In your case 
physical addresses from 0 to fffffff would seem to have no RAM, so you 
would do something like:

  add_memory_region(0x10000000, 0x10000000, BOOT_MEM_RAM);

David Daney
