Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 17:34:13 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53482 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20032288AbYHUQeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 17:34:07 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ad98c60000>; Thu, 21 Aug 2008 12:33:15 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Aug 2008 09:33:09 -0700
Received: from [192.168.162.80] ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Aug 2008 09:33:09 -0700
Message-ID: <48AD98BB.9090908@caviumnetworks.com>
Date:	Thu, 21 Aug 2008 09:32:59 -0700
From:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] OCTEON: Add processor-specific constants and detection
 of CPU variants
References: <48A9E6DA.8030208@caviumnetworks.com> <1219263605-21396-1-git-send-email-tpaoletti@caviumnetworks.com> <20080820223358.GA9770@alpha.franken.de>
In-Reply-To: <20080820223358.GA9770@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Aug 2008 16:33:09.0712 (UTC) FILETIME=[98F2F500:01C903AB]
Return-Path: <Tomaso.Paoletti@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpaoletti@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Hi Thomas

Thomas Bogendoerfer wrote:
> On Wed, Aug 20, 2008 at 01:20:05PM -0700, Tomaso Paoletti wrote:
>> --- a/include/asm-mips/bootinfo.h
>> +++ b/include/asm-mips/bootinfo.h
>> @@ -57,6 +57,11 @@
>>  #define	MACH_MIKROTIK_RB532	0	/* Mikrotik RouterBoard 532 	*/
>>  #define MACH_MIKROTIK_RB532A	1	/* Mikrotik RouterBoard 532A 	*/
>>  
>> +/*
>> + * Valid machtype for group CAVIUM
>> + */
>> +#define  MACH_CAVIUM_OCTEON	1	/* Cavium Octeon */
>> +
> 
> no new machtypes please.

Thanks, I've corrected that.
I'm waiting to see if there's more feedback, and will resend the patch 
by this afternoon (PST).

   Tomaso
