Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2014 21:28:00 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:39926 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859944AbaGST1zAlMXB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jul 2014 21:27:55 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1X8aIT-0004jW-VY
        for linux-mips@linux-mips.org; Sat, 19 Jul 2014 21:27:54 +0200
Date:   Sat, 19 Jul 2014 21:27:53 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Subject: Dirty memory amount corruption on Loongson 2E kernel
Message-ID: <20140719192753.GA31695@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

Hi all,

Debian is using Loongson 2E machines as part of the buildd network. From
time to time we observed a corruption of the amount of dirty memory as
it can be seen below:

| # cat /proc/meminfo
| MemTotal:        1033008 kB
| MemFree:           81504 kB
| MemAvailable:     781552 kB
| Buffers:          133104 kB
| Cached:           660752 kB
| SwapCached:        13152 kB
| Active:           513680 kB
| Inactive:         348016 kB
| Active(anon):      20288 kB
| Inactive(anon):    48048 kB
| Active(file):     493392 kB
| Inactive(file):   299968 kB
| Unevictable:          96 kB
| Mlocked:              96 kB
| SwapTotal:       2097136 kB
| SwapFree:        2046624 kB
| Dirty:          18446744073709288640 kB
| Writeback:             0 kB
| AnonPages:         65296 kB
| Mapped:            16992 kB
| Shmem:               496 kB
| Slab:              79312 kB
| SReclaimable:      69872 kB
| SUnreclaim:         9440 kB
| KernelStack:        1664 kB
| PageTables:         2752 kB
| NFS_Unstable:          0 kB
| Bounce:                0 kB
| WritebackTmp:          0 kB
| CommitLimit:     2613632 kB
| Committed_AS:     178464 kB
| VmallocTotal:   1069547488 kB
| VmallocUsed:         656 kB
| VmallocChunk:   1069538528 kB
| AnonHugePages:         0 kB
| HugePages_Total:       0
| HugePages_Free:        0
| HugePages_Rsvd:        0
| HugePages_Surp:        0
| Hugepagesize:      32768 kB

The consequences is that all write accesses to disk are very very slow,
while read access are running at normal speed. My guess is that the
kernel is trying to flush dirty pages in priority, but there are none.

It usually happens after 3 to 6 days of continuous work, but we haven't
found any pattern triggering the issue so far. We first thought it could
be a bad interaction of transparent hugepages, but even setting them to
"never" does not fix the issue.

Do you have an idea about what could be the issue, or if not how can we
debug it?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
