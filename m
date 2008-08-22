Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 02:46:25 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:32334 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S28587841AbYHVBqR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Aug 2008 02:46:17 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ae1a620000>; Thu, 21 Aug 2008 21:46:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Aug 2008 18:46:09 -0700
Received: from [192.168.162.80] ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Aug 2008 18:46:09 -0700
Message-ID: <48AE1A56.5070800@caviumnetworks.com>
Date:	Thu, 21 Aug 2008 18:45:58 -0700
From:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] OCTEON: Add workaround file
References: <48A9E6DA.8030208@caviumnetworks.com> <1219263625-21540-1-git-send-email-tpaoletti@caviumnetworks.com> <20080821065813.GA12645@linux-mips.org>
In-Reply-To: <20080821065813.GA12645@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Aug 2008 01:46:09.0771 (UTC) FILETIME=[D9CE2BB0:01C903F8]
Return-Path: <Tomaso.Paoletti@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpaoletti@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Aug 20, 2008 at 01:20:25PM -0700, Tomaso Paoletti wrote:
> 
>> Add OCTEON specific version of the workarounds file.
>> None of these apply to OCTEON, but the file is required.
> 
> Yes - intentionally.  I want to force people having to think about if they
> need any of the workaround enabled because the bugs from not having a
> necessary workaround enabled could be painfully subtle.

I've modified the patch comment to confirm that we verified the 
applicability of all defines.
Thanks

   Tomaso
