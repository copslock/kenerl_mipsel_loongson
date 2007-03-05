Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 18:19:08 +0000 (GMT)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:54912 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20037619AbXCESTB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 18:19:01 +0000
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id ED3F63E357;
	Mon,  5 Mar 2007 13:18:23 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17900.24303.861861.342312@zeus.sw.starentnetworks.com>
Date:	Mon, 5 Mar 2007 13:18:23 -0500
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org, David Daney <ddaney@avtrex.com>
Subject: Re: SMP+PREEMPT causes NULL dereference in khelper on startup
In-Reply-To: <45EC4D64.5050803@avtrex.com>
References: <17897.48239.366047.442797@zeus.sw.starentnetworks.com>
	<17900.19125.660006.553487@zeus.sw.starentnetworks.com>
	<45EC4D64.5050803@avtrex.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney writes:
> Dave Johnson wrote:
> > I found the issue.  This appears to be a compiler bug in
> > __unhash_process().
> 
> Perhaps you could tell us the compiler/binutils versions you are using.

Very old:

sbtools-2.7.1 (a.k.a. '3.2.3 with SiByte modifications')

We've found other problems in sbtools-2.5.11 (a.k.a. '3.0.3 with
SiByte modifications') relating to incorrect structure offset
calculations, but this is the first problem we've found in 3.2.3.

I'll probably look into upgrading again...

-- 
Dave Johnson
Starent Networks
