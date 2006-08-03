Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2006 11:35:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51154 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133645AbWHDKf2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2006 11:35:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k74AZXEb014069;
	Fri, 4 Aug 2006 11:35:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k73NppD7032303;
	Fri, 4 Aug 2006 00:51:52 +0100
Date:	Fri, 4 Aug 2006 00:51:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Srinivas Kommu <kommu@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: highmem questions
Message-ID: <20060803235151.GA30970@linux-mips.org>
References: <44D12317.7090002@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D12317.7090002@hotmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 02, 2006 at 03:11:35PM -0700, Srinivas Kommu wrote:

> 1. If I have 1 gig physical memory and CONFIG_HIGHMEM disabled, would 
> the user processes be able to see the high memory?
>  Only 256 meg (this is on BCM1250; so 256 meg is expected) shows up in 
> /proc/meminfo and I couldn't malloc more than that much from user processes.

While I've originally implemented highmem for the BCM1250 in early 2002
highmem is and stays the same stupid idea it was back then.  Go for a
64-bit kernel, it's far less headache.  If you don't want to run 64-bit
binaries applications, run a standard 32-bit distribution.

> 2. With highmem enabled, is there a penalty to the user processes? From 
> what I understood, highmem mappings are needed for the kernel to access 
> that memory. For the pages belonging to user processes, does it still 
> use pkmaps?

User process performance is identical.  The performance penalty is on I/O
or any sort of kernel activity on highmem pages..

> 3. How do I measure the penalty of highmem on kernel modules? Since the 
> code and data for modules resides in highmem, the kernel has to 
> constantly map and unmap while running inside the modules? Is there a 
> way to quantify the overhead of running with highmem enabled versus not?

The physical address of modules does not make any difference.

Highmem, just say no.

  Ralf
