Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jun 2004 13:42:11 +0100 (BST)
Received: from apollo.nbase.co.il ([IPv6:::ffff:194.90.137.2]:36626 "EHLO
	apollo.nbase.co.il") by linux-mips.org with ESMTP
	id <S8225763AbUFXMmH>; Thu, 24 Jun 2004 13:42:07 +0100
Received: from mrv.com ([194.90.136.133]) by apollo.nbase.co.il
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 0-44418U200L2S100) with ESMTP id AAA1464
          for <linux-mips@linux-mips.org>; Thu, 24 Jun 2004 15:50:03 +0200
Message-ID: <40DACD33.60801@mrv.com>
Date: Thu, 24 Jun 2004 15:46:43 +0300
From: ypresente@mrv.com (Yaron Presente)
Organization: MRV International
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: non-contiguous physical memory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ypresente@mrv.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ypresente@mrv.com
Precedence: bulk
X-list: linux-mips

Hi all,
I'm running montavista linux (2.4.18_mvl30-malta-mips_fp_le) on a board 
that has 2 memory banks of physical memory.
1. 32MB from physical address 0x00000000
2. 16MB from physical address 0x20000000

Currently I can only access the first bank (by add_memory_region(0, 32 
<< 20, BOOT_MEM_RAM) in prom_init() ).
I tried the obvious solution of adding another region at 0x20000000 
(add_memory_region(0x20000000, 16 << 20, BOOT_MEM_RAM))
but that didn't seem to work. I've also tried to add a BOOT_MEM_RESERVED 
region in between the regions in order to create a seemingly contiguous 
memory, with no success.
My questions are:
Is it possible to access the second bank as well under MIPS ?
Is there a way to define a "hole" in the physical memory?
Do I have to use CONFIG_DISCONTIGMEM ? is it fully supported ?
Thanks for your help,

-- 
Yaron Presente
MRV International
Direct   : 972-4-9936237
Fax      : 972-4-9890564
Email   : ypresente@mrv.com
www.mrv.com
