Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 16:32:13 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:50817 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22668966AbYJ2QcB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 16:32:01 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49088ff90000>; Wed, 29 Oct 2008 12:31:53 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 09:31:51 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 09:31:51 -0700
Message-ID: <49088FF7.9060103@caviumnetworks.com>
Date:	Wed, 29 Oct 2008 09:31:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 15/36] Probe for Cavium OCTEON CPUs.
References: <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com> <20081029121737.GA26256@linux-mips.org> <49088CBF.8060109@caviumnetworks.com> <20081029162642.GC26256@linux-mips.org>
In-Reply-To: <20081029162642.GC26256@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2008 16:31:51.0694 (UTC) FILETIME=[D8F31AE0:01C939E3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Oct 29, 2008 at 09:18:07AM -0700, David Daney wrote:
> 
>> Acked-by: David Daney <ddaney@caviumnetworks.com>
>>
>> This seems sane to me assuming that alchemy, sibyte, sandcraft, nxp, and  
>> broadcom all have standard mips{32,64} watch registers (i.e., if the  
>> watch bit in config1 is set the registers have mips semantics).
> 
> The watch bit is a standard feature of the MIPS R1/R2 architecture.  What
> Sandcraft did was bascially an RM7000 clone with some extensions.  I'm
> still trying to track somebody who could verify the correctness of that
> code as I don't have Sandcraft docs ...
> 

R4400 and R10K have the watch registers, but they do not have mips 
semantics, so are not currently usable with the watch register support. 
   This is why I initially was very conservative about the conditions 
under which I probed watch registers.  So I think it is good to try to 
verify these things.

David Daney
