Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2008 01:09:04 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:18413 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20032119AbYEWAJB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 May 2008 01:09:01 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id D0E3131AAEB;
	Fri, 23 May 2008 00:09:07 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri, 23 May 2008 00:09:07 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 22 May 2008 17:08:47 -0700
Message-ID: <48360B0E.9050009@avtrex.com>
Date:	Thu, 22 May 2008 17:08:46 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	akpm@linux-foundation.org
Cc:	mm-commits@vger.kernel.org,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: + mips-remove-board_watchpoint_handler.patch added to -mm tree
References: <200805222351.m4MNp62P027891@imap1.linux-foundation.org>
In-Reply-To: <200805222351.m4MNp62P027891@imap1.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2008 00:08:47.0595 (UTC) FILETIME=[2C019BB0:01C8BC69]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

akpm@linux-foundation.org wrote:
> The patch titled
>      mips: remove board_watchpoint_handler
> has been added to the -mm tree.  Its filename is
>      mips-remove-board_watchpoint_handler.patch
> 
[...]
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 

Thanks Andrew,

The original patch e-mail went to linux-mips@linux-mips.org, so I was 
hoping that Ralf would queue it up.  I will defer to you all to decide 
the proper disposition of the patch.

David Daney


> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: mips: remove board_watchpoint_handler
> From: David Daney <ddaney@avtrex.com>
> 
> It is not used anywhere in tree.
> 
> Signed-off-by: David Daney <ddaney@avtrex.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/mips/kernel/traps.c |    6 ------
>  include/asm-mips/traps.h |    1 -
>  2 files changed, 7 deletions(-)
> 
[...]
