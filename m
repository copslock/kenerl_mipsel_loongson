Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 19:19:39 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3953 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22675850AbYJ2TT0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 19:19:26 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4908b7180001>; Wed, 29 Oct 2008 15:18:49 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 12:18:47 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 12:18:47 -0700
Message-ID: <4908B717.3010603@caviumnetworks.com>
Date:	Wed, 29 Oct 2008 12:18:47 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Christoph Hellwig <hch@lst.de>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <20081029184552.GB32500@lst.de>
In-Reply-To: <20081029184552.GB32500@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2008 19:18:47.0442 (UTC) FILETIME=[2ACCF720:01C939FB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> On Mon, Oct 27, 2008 at 05:02:38PM -0700, David Daney wrote:
>> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  .../cavium-octeon/executive/cvmx-csr-addresses.h   | 8391 ++++++
>>  arch/mips/cavium-octeon/executive/cvmx-csr-enums.h |   86 +
>>  .../cavium-octeon/executive/cvmx-csr-typedefs.h    |27517 ++++++++++++++++++++
> 
> 27517 lines in a header and it's all junk?  
> 

I'm glad you asked.  No it is not all junk.

That file contains the bit definitions for all on-chip registers.

We are interested in transforming this information into a form suitable 
for inclusion in the kernel.  Any specific suggestions as to improve the 
patch will be considered.

Several possibilities are:

1) Don't typedef all the unions in  cvmx-csr-typedefs.h.  An rename the 
file so it doesn't contain the reprehensible word 'typedef'

2) Break cvmx-csr-addresses.h and cvmx-csr-typedefs.h into several 
parts, one for each functional block in the processor.

There are obviously other options as well...

Thanks,
David Daney
