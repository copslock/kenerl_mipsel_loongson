Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 23:11:52 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:49973 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133677AbWHBWLm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 23:11:42 +0100
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-6.cisco.com with ESMTP; 02 Aug 2006 15:11:36 -0700
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11.20060308/8.12.11) with ESMTP id k72MBaSC018138
	for <linux-mips@linux-mips.org>; Wed, 2 Aug 2006 15:11:36 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id k72MBZJi029223
	for <linux-mips@linux-mips.org>; Wed, 2 Aug 2006 15:11:36 -0700 (PDT)
Received: from xfe-sjc-212.amer.cisco.com ([171.70.151.187]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 Aug 2006 15:11:35 -0700
Received: from [171.69.51.42] ([171.69.51.42]) by xfe-sjc-212.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 2 Aug 2006 15:11:35 -0700
Message-ID: <44D12317.7090002@hotmail.com>
Date:	Wed, 02 Aug 2006 15:11:35 -0700
From:	Srinivas Kommu <kommu@hotmail.com>
User-Agent: Thunderbird 1.4 (Windows/20050908)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: highmem questions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2006 22:11:35.0600 (UTC) FILETIME=[9E631300:01C6B680]
Authentication-Results:	sj-dkim-2.cisco.com; header.From=kommu@hotmail.com; dkim=neutral
Return-Path: <kommu@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kommu@hotmail.com
Precedence: bulk
X-list: linux-mips

1. If I have 1 gig physical memory and CONFIG_HIGHMEM disabled, would 
the user processes be able to see the high memory?
  Only 256 meg (this is on BCM1250; so 256 meg is expected) shows up in 
/proc/meminfo and I couldn't malloc more than that much from user processes.

2. With highmem enabled, is there a penalty to the user processes? From 
what I understood, highmem mappings are needed for the kernel to access 
that memory. For the pages belonging to user processes, does it still 
use pkmaps?

3. How do I measure the penalty of highmem on kernel modules? Since the 
code and data for modules resides in highmem, the kernel has to 
constantly map and unmap while running inside the modules? Is there a 
way to quantify the overhead of running with highmem enabled versus not?

thanks in advance!
Srini

--
kommu@hotmail.com
