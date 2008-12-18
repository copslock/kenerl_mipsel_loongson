Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 01:44:46 +0000 (GMT)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:64584 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24208061AbYLRBoo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 01:44:44 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4949aae50000>; Wed, 17 Dec 2008 20:44:05 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 17:43:24 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 17:43:24 -0800
Message-ID: <4949AABC.2070507@caviumnetworks.com>
Date:	Wed, 17 Dec 2008 17:43:24 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	"Joseph S. Myers" <joseph@codesourcery.com>
CC:	linux-mips@linux-mips.org
Subject: Re: N32 fallocate syscall
References: <Pine.LNX.4.64.0812180009000.31179@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.0812180009000.31179@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2008 01:43:24.0644 (UTC) FILETIME=[04204A40:01C960B2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Joseph S. Myers wrote:
> The N32 syscall table uses sys_fallocate instead of sys32_fallocate.  
> However, glibc expects to be using the syscall version with 32-bit 
> arguments on N32, which should work with sys32_fallocate but not 
> sys_fallocate.
> 
> What should the N32 interface for this syscall be?  My inclination is that 
> glibc is right not to do anything special and different from other 32-bit 
> ABIs here, and so sys32_fallocate should be used.
> 

The prototype for that would be something like:

sys_fallocate(int32_t, int32_t, int64_t, int64_t);

The N32 and N64 ABIs treat this identically, the parameters are passed
in a0, a1, a2, and a3.  As you noted, the current (2.6.28-rc8) kernel
sources follow the ABI for N32 and N64.  I think the kernel is
correct.

If glibc is not using the ABI calling convention for both N32 and N64 (I
haven't checked), it should probably be fixed.

> (glibc is also expecting the 32-bit version for N64, but that's a clear 
> bug in glibc that I'll be fixing.)
> 

David Daney
