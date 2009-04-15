Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2009 22:39:30 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53211 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20024704AbZDOVjX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Apr 2009 22:39:23 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49e653ba0000>; Wed, 15 Apr 2009 17:38:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 15 Apr 2009 14:37:15 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 15 Apr 2009 14:37:15 -0700
Message-ID: <49E6538A.3050701@caviumnetworks.com>
Date:	Wed, 15 Apr 2009 14:37:14 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Joseph S. Myers" <joseph@codesourcery.com>,
	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.0904152018070.3560@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2009 21:37:15.0075 (UTC) FILETIME=[57EF2930:01C9BE12]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Joseph S. Myers wrote:
> On Sun, 1 Mar 2009, Maciej W. Rozycki wrote:
> 
>> Hello,
>>
>>  Here is code to implement the getcontext API for MIPS.  This glibc patch 
>> is sent to the linux-mips mailing list, because it makes use of an 
>> internal syscall which has not been designated as a part of the public 
>> ABI.  I am writing to request this syscall to become fixed as a part of 
>> the ABI or to seek for an alternative.  See below for the rationale.
> 
> Was there any conclusion about whether the assumptions this patch makes 
> about the kernel are OK (and so it can go in) or not?
> 

My (unofficial) conclusion is that this should be part of the kernel's 
public ABI, and that you should commit the glibc patch.  However, Ralf 
should probably weigh in the subject so we can know this definitively.

David Daney
