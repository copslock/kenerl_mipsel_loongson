Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 13:13:22 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:36266 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8225738AbVCHNM7>;
	Tue, 8 Mar 2005 13:12:59 +0000
Received: from [192.168.0.85] ([192.168.0.85]) by exterity.co.uk with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 8 Mar 2005 13:14:22 +0000
Subject: clear_user_page in page.h
From:	JP Foster <jp.foster@exterity.co.uk>
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain
Date:	Tue, 08 Mar 2005 13:12:52 +0000
Message-Id: <1110287573.30647.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.6 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2005 13:14:22.0437 (UTC) FILETIME=[BE6CB950:01C523E0]
Return-Path: <jpfoster@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp.foster@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Hi all,
I'm building the video4linux drivers as modules and the video-buf driver
can't load as it has no reference to shm_align_mask and
flush_data_cache_page. 

These are needed by asm-mips/page.h for the inline funcs, pages_do_alias
and clear/copy_user_page.
How should shm_align_mask and flush_data_cache_page. be exported to
modules?

Most other asm-xxx/page.h doesn't need any externs, all is #defined
within page.h or files included by it.

Any ideas how I deal with this? Presumably other modules will be 
affected by this.

-- 
jp.foster@exterity.co.uk
Digital Simplicity
