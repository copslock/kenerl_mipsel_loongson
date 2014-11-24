Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 11:31:43 +0100 (CET)
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:56543 "EHLO
        cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006625AbaKXKbihj4I9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 11:31:38 +0100
Received: from cpsps-ews03.kpnxchange.com ([10.94.84.170]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 24 Nov 2014 11:31:33 +0100
Received: from CPSMTPM-TLF104.kpnxchange.com ([195.121.3.7]) by cpsps-ews03.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 24 Nov 2014 11:31:33 +0100
Received: from [192.168.10.100] ([77.173.140.92]) by CPSMTPM-TLF104.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 24 Nov 2014 11:31:32 +0100
Message-ID: <1416825092.10073.6.camel@x220>
Subject: MIPS: 64BIT_PHYS_ADDR
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Nov 2014 11:31:32 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2014 10:31:32.0550 (UTC) FILETIME=[D0BF4660:01D007D1]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Ralf,

Your commit 5bd35e65f101 ("MIPS: Replace MIPS-specific 64BIT_PHYS_ADDR
with generic PHYS_ADDR_T_64BIT") is included in today's linux-next (ie,
next-20141124). That commit does what it promises to do. There are a few
references to 64BIT_PHYS_ADDR in linux-next:
    $ git grep -n 64BIT_PHYS_ADDR 
    arch/mips/include/asm/pgtable-32.h:225:#endif /* defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32) */
    drivers/dma/txx9dmac.c:79:#if defined(CONFIG_32BIT) && !defined(CONFIG_64BIT_PHYS_ADDR)
    drivers/dma/txx9dmac.h:70:#if defined(CONFIG_32BIT) && !defined(CONFIG_64BIT_PHYS_ADDR)
    drivers/dma/txx9dmac.h:204:#if defined(CONFIG_32BIT) && !defined(CONFIG_64BIT_PHYS_ADDR)
    drivers/pcmcia/Kconfig:150:     select 64BIT_PHYS_ADDR
    drivers/pcmcia/Kconfig:161:     select 64BIT_PHYS_ADDR

I assume that patches to replace these references too are queued
somewhere. Is that correct?


Paul Bolle
