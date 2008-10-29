Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 20:54:02 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4137 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22681042AbYJ2Uxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 20:53:52 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4908cd460000>; Wed, 29 Oct 2008 16:53:26 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 13:53:24 -0700
Received: from [192.168.162.106] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 13:53:24 -0700
Message-ID: <4908CD44.503@caviumnetworks.com>
Date:	Wed, 29 Oct 2008 13:53:24 -0700
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.14eol) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.13~pre080323b-0etch3)
MIME-Version: 1.0
To:	Christoph Hellwig <hch@lst.de>
CC:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <20081029184552.GB32500@lst.de> <4908B717.3010603@caviumnetworks.com> <20081029192756.GA2449@lst.de>
In-Reply-To: <20081029192756.GA2449@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2008 20:53:24.0547 (UTC) FILETIME=[629E7130:01C93A08]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> On Wed, Oct 29, 2008 at 12:18:47PM -0700, David Daney wrote:
>> Christoph Hellwig wrote:
>>> On Mon, Oct 27, 2008 at 05:02:38PM -0700, David Daney wrote:
>>>> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
>>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>>> ---
>>>> .../cavium-octeon/executive/cvmx-csr-addresses.h   | 8391 ++++++
>>>> arch/mips/cavium-octeon/executive/cvmx-csr-enums.h |   86 +
>>>> .../cavium-octeon/executive/cvmx-csr-typedefs.h    |27517 
>>>> ++++++++++++++++++++
>>> 27517 lines in a header and it's all junk?  
>>>
>> I'm glad you asked.  No it is not all junk.
>>
>> That file contains the bit definitions for all on-chip registers.
>>
>> We are interested in transforming this information into a form suitable 
>> for inclusion in the kernel.  Any specific suggestions as to improve the 
>> patch will be considered.
>>
>> Several possibilities are:
>>
>> 1) Don't typedef all the unions in  cvmx-csr-typedefs.h.  An rename the 
>> file so it doesn't contain the reprehensible word 'typedef'
>>
>> 2) Break cvmx-csr-addresses.h and cvmx-csr-typedefs.h into several 
>> parts, one for each functional block in the processor.
> 
> The two are very good ideas, but not really the important part.
> 
> Adding a massive inline for every single bit somewhere in a register
> just doesn't make sense.  Take a look at normal hardware defintion
> headers in the tree.
> 
> Have a simple define for each _register_ (applied relative to a bank/chip
> or whatever is appropriate) and if the individual bits in it are
> important add bit defintions, too - leaving the arithmetics for it to
> the caller.
> 
> Also please don't add defintions for those blocks of the chip that
> aren't actually used in your submission.  That's best done with one
> header per block that can be added with the driver supporting that
> block.
> 
> And yes, we had this a few times.  Eventually I'll make a fortune
> by selling a perl script generating proper headers out of common HDLs..
> 

The kernel's normal method of defining a whole bunch of #defines for
every bit doesn't really work well for maintainability. Many times it
isn't obvious which define goes with which register. It also doesn't
cover changes in hardware over time. Our CSR definitions are generated
from the RTL and designed to catch incompatibilities that might show up
in the future. The "s" member of the union contains all of the bits that
 don't conflict for the known Octeon chips. If a bit changes meaning in
a future Octeon, then the bit will disappear out of the "s" member and
only be available through the chip specific unions. This makes the
compiler find all usages of the change bit and forces you to fix them.

It also doesn't make sense to leave out registers that aren't currently
used. How does anyone write a new driver if the register definitions
aren't there? Typing these in after the fact is a waste of time.

Chad
