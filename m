Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 04:54:59 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:58057 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007002AbcDTCyyyPGoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 04:54:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date; bh=4f2+MEgHK8M7jlVumIEAiCFNjObBxRiDiRVyEpp+PEg=; b=jaYs8g9Pr1aZ
        YeQXcvZ4ZXZYb90SzlAdC1MgoBvf8RWrLoCnZkohX6ekvTe+EfTz6oteWjImV8u7AG7/BwovqB5aS
        J48WaQvEXCto1B59EXzg7mRdJCP/3vldIvizKM4lI//iUWZtDofUvJFayU/2YdXy4TQbAv44Bp2rd
        q+GIkLqivsD95/7Ub3o5MSQDWEfTM3xkAQNWW9AsT+EtTECIw3nW5XqhOFw4i3EVK15Ub5YeSAgU/
        3SUBiGmjK+SMPdwDKEvqe9b4lwWC0dcrNDOEHYqdCwP4fxssIuP5VrgLUOo7Gl3fBS822l8ZHaAiS
        9chjNcfIs9AgYQl0gjlaYw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:35734 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1asiHu-002jMM-Td; Wed, 20 Apr 2016 02:54:47 +0000
Date:   Tue, 19 Apr 2016 19:54:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next: fuloong2e qemu boot failure due to 'MIPS: Loongson: Add
 Loongson-3A R2 basic support'
Message-ID: <20160420025454.GA17200@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Hi,

qemu fails to boot in -next for machine fulong2e with configuration
fuloong2e_defconfig. Bisect points to commit 'MIPS: Loongson: Add
Loongson-3A R2 basic support'. qemu hangs in boot, after displaying 
"Inode-cache hash table entries: 16384 (order: 3, 131072 bytes)".

Bisect log is attached.

Guenter

---
# bad: [1bd7a2081d2c7b096f75aa934658e404ccaba5fd] Add linux-next specific files for 20160418
# good: [bf16200689118d19de1b8d2a3c314fc21f5dc7bb] Linux 4.6-rc3
git bisect start 'HEAD' 'v4.6-rc3'
# bad: [493ac92ff65ec4c4cd4c43870e778760a012951d] Merge remote-tracking branch 'ipvs-next/master'
git bisect bad 493ac92ff65ec4c4cd4c43870e778760a012951d
# bad: [20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792] Merge remote-tracking branch 'btrfs-kdave/for-next'
git bisect bad 20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792
# good: [c454e65fb9ade11d0f84718d06a6888e2c92804d] Merge remote-tracking branch 'omap/for-next'
git bisect good c454e65fb9ade11d0f84718d06a6888e2c92804d
# good: [6f5c70fb9b4fc0534157bfa40cea9b402e6f2506] Merge remote-tracking branch 'microblaze/next'
git bisect good 6f5c70fb9b4fc0534157bfa40cea9b402e6f2506
# bad: [7f053cd68fd14243c8f202b4086d7dd75c409e6f] MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT
git bisect bad 7f053cd68fd14243c8f202b4086d7dd75c409e6f
# good: [e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8] MIPS: Allow RIXI to be used on non-R2 or R6 cores
git bisect good e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8
# good: [d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d] MAINTAINERS: add Loongson1 architecture entry
git bisect good d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d
# good: [13ff6275bb389c3669082d3ef8483592a31eb0ea] MIPS: Fix siginfo.h to use strict posix types
git bisect good 13ff6275bb389c3669082d3ef8483592a31eb0ea
# good: [66e74bdd51e617023fa2e79a807b704fb3eed8aa] MIPS: Enable ptrace hw watchpoints on MIPS R6
git bisect good 66e74bdd51e617023fa2e79a807b704fb3eed8aa
# good: [f7cabc2dac8adf5986dbc700584bc3b8fe493d4d] MIPS: Loongson-3: Adjust irq dispatch to speedup processing
git bisect good f7cabc2dac8adf5986dbc700584bc3b8fe493d4d
# bad: [4978c8477e96fb9e9d870d8f42328dcabf1a65e9] MIPS: Loongson-3: Set cache flush handlers to cache_noop
git bisect bad 4978c8477e96fb9e9d870d8f42328dcabf1a65e9
# bad: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS: Loongson: Add Loongson-3A R2 basic support
git bisect bad 04a35922c1dac1b4864b8b366a37474e9e51d8c0
# first bad commit: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS: Loongson: Add Loongson-3A R2 basic support
