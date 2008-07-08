Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 18:40:35 +0100 (BST)
Received: from [66.209.47.173] ([66.209.47.173]:19123 "EHLO mythtv.ewol.com")
	by ftp.linux-mips.org with ESMTP id S20046635AbYGHRk0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2008 18:40:26 +0100
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by mythtv.ewol.com (8.14.2/8.14.2) with ESMTP id m68He6DZ023622;
	Tue, 8 Jul 2008 13:40:07 -0400
Message-ID: <4873A676.8050906@cortland.com>
Date:	Tue, 08 Jul 2008 13:40:06 -0400
From:	Steve Brown <sbrown@cortland.com>
Reply-To: sbrown@cortland.com
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Michael Buesch <mb@bu3sch.de>
Subject: Correct way to set coherent_dma_mask on a non-pci device?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sbrown@cortland.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbrown@cortland.com
Precedence: bulk
X-list: linux-mips

There appears to be no function like pci_set_consistent_dma_mask to set 
the coherent mask for a non-pci device.

What is the "proper" way to set it?

The context for the question is a recent change to ssb_dma_set_mask() in 
drivers/ssb/main.c that removed the somewhat fragile, direct 
manipulation of dma_mask and coherent_dma_mask in favor of a call to 
dma_set_mask().

Thanks,
Steve
