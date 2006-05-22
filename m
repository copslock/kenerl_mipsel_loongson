Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2006 10:24:55 +0200 (CEST)
Received: from sigrand.ru ([80.66.88.167]:14986 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133521AbWEVIYr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2006 10:24:47 +0200
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id 9913812A000C
	for <linux-mips@linux-mips.org>; Mon, 22 May 2006 15:24:41 +0700 (NOVST)
Date:	Mon, 22 May 2006 15:24:33 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.62r) UNREG / CD5BF9353B3B7091
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <555953307.20060522152433@sigrand.ru>
To:	linux-mips@linux-mips.org
Subject: Machine Check exception, TLB & ADM5120
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Hi all.
I am work with ADM5120.
Linux kernel 2.6
I have problem with TLB:

Got mcheck at c0086330
[4294725.768000] Cpu 0
[4294725.768000] $ 0   : 00000000 10008400 00000000 00000000
[4294725.768000] $ 4   : 803c5a7c 803c5a7c 10008400 ffff00fe
[4294725.768000] $ 8   : 8122dfe0 00008400 00000000 81250000
[4294725.768000] $12   : 001e8480 00000000 00000057 00000007
[4294725.768000] $16   : 803c5a20 00000055 b1400c00 80240000
[4294725.768000] $20   : 80321600 c0080000 803c5a8a 0000ecc4
[4294725.768000] $24   : 00000002 8000f358
[4294725.768000] $28   : 8122c000 8122de40 000001c2 c0086330
[4294725.768000] Hi    : 0000021f
[4294725.768000] Lo    : 5c28f79e
[4294725.768000] epc   : c0086330 dload_fw+0x274/0x29c [sg16lan]     Not tainted
[4294725.768000] ra    : c0086330 dload_fw+0x274/0x29c [sg16lan]
[4294725.768000] Status: 10208403    KERNEL EXL IE
[4294725.768000] Cause : 00800060
[4294725.768000] PrId  : 0001800b
[4294725.768000]
[4294725.768000] Index:  8 pgmask=4kb va=c0088000 asid=57
[4294725.768000]                        [pa=003fe000 c=3 d=1 v=1 g=1]
[4294725.768000]                        [pa=003ff000 c=3 d=1 v=1 g=1]
[4294725.768000]
[4294725.768000] Index: 10 pgmask=4kb va=c0084000 asid=57
[4294725.768000]                        [pa=01201000 c=3 d=1 v=1 g=1]
[4294725.768000]                        [pa=003c6000 c=3 d=1 v=1 g=1]
[4294725.768000]
[4294725.768000] Index: 13 pgmask=4kb va=c008a000 asid=57
[4294725.768000]                        [pa=003e9000 c=3 d=1 v=1 g=1]
[4294725.768000]                        [pa=00000000 c=0 d=0 v=0 g=1]
[4294725.768000]
[4294725.768000] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.

May it be result of my modyle (sg16lan) work?
And where to look.

Thanks, Plyakov Artem
