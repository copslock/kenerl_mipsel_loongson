Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2008 01:59:15 +0000 (GMT)
Received: from dotcorporate.com ([67.50.105.12]:30663 "EHLO
	dotexchange.dotcorporation.com") by ftp.linux-mips.org with ESMTP
	id S28601238AbYCDB7N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2008 01:59:13 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: smp8634 add memory at dram1
Date:	Mon, 3 Mar 2008 17:59:11 -0800
Message-ID: <2D30722FBBDE6749973243F4F01BE984A242CB@dotexchange.dotcorporation.com>
In-Reply-To: <47CC974F.3090306@avtrex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: smp8634 add memory at dram1
Thread-Index: Ach9jncajtrbM7+KS8auCZEQx2hQEQABxn5w
From:	"James Zipperer" <jamesz@modsystems.com>
To:	"David Daney" <ddaney@avtrex.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <jamesz@modsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamesz@modsystems.com
Precedence: bulk
X-list: linux-mips

> James Zipperer wrote:
>
>> 
>>  
>> 
>> I'm running out of memory in linux on the smp86xx and attempting to 
>> implement this solution.  Did you ever get it to work?  No luck for
me 
>> yet.  I'm still a bit unclear why you must switch linux to run off
DRAM 
>> 1 instead of leaving it on DRAM 0 and adding an additional call to 
>> add_memory_region in prom_init for DRAM 1.  But then again, I haven't

>> gotten that to work yet either :)
>> 
>>  
>> 
>> Any info/patches are greatly appreciated.  Thanks!
>> 
>>  
>> 
>
>Typically DRAM 1 must be accessed through the TLB as its address lays 
>outside of the 512MB window of KSEG[012].
>
>The best way to make this memory available to Linux may still be up for

>debate.
>
>David Daney


I'm sure this is a dumb question due to the fact that my grasp of the
problem is less than acceptable...  

Can remapped addresses (namely CPU_remap[34]_addr) be used for the call
to add_memory_region()?  That would allow the address for DRAM 1 to be
within the 512MB window of KSEG[012].  I'm unclear whether the CPU_remap
addresses count as PHSYICAL or VIRTUAL addresses.  

I'm guessing that my plan won't work since I tried it and it didn't
work.  My results were that the kernel booted but didn't report any
additional memory available via the 'free' command.

Thanks.

-James
