Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 23:14:13 +0200 (CEST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:7488 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S1122963AbSIRVOM>;
	Wed, 18 Sep 2002 23:14:12 +0200
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g8ILE76m019936
	for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 23:14:07 +0200
Message-ID: <3D88EC9F.3060001@murphy.dk>
Date: Wed, 18 Sep 2002 23:14:07 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: pci_unmap_single - 2.5 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

In the 2.5 kernel pci_map_sg contains these lines:

                addr = (unsigned long) page_address(sg->page);
                if (addr)
                        dma_cache_wback_inv(addr, sg->length);

Surely when flushing the offset needs to be added to the page base
address (addr)? So that this reads:

                if (addr)
                        dma_cache_wback_inv(addr + sg->offset, sg->length);


/Brian
