Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 17:55:16 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:45971 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S8133592AbWG0QzH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Jul 2006 17:55:07 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 44AA5B0B4C;
	Thu, 27 Jul 2006 13:07:48 -0400 (EDT)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 27 Jul 2006 13:07:48 -0400 (EDT)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Jul 2006 09:54:58 -0700
Message-ID: <44C8EFE2.4010102@avtrex.com>
Date:	Thu, 27 Jul 2006 09:54:58 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jul 2006 16:54:58.0471 (UTC) FILETIME=[64BCBB70:01C6B19D]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Instead of dump all possible address in the stack, unwind the stack
> frame based on prologue code analysis, as like as get_chan() does.
> While the code analysis might fail for some reason, there is a new
> kernel option "raw_show_trace" to disable this feature.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Let me start by saying I have not analyzed how all this code works, but 
I have done something similar in user space.

Since the kernel ABI does not use gp, many functions may not have a 
prolog (especially when compiled with newer versions of GCC).  In the 
user space case, most leaf functions have no prolog.  For the kernel I 
would imagine that many non-leaf functions (simple non-leaf functions 
that do only a tail call) would also not have a prolog.

I would be worried that many stack traces would become less useful.

If this were conditional on -fno-omit-frame-pointer, then I think it 
would be a good idea.

David Daney.
