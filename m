Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 12:26:52 +0100 (CET)
Received: from linux-libre.fsfla.org ([208.118.235.54]:49413 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825729AbaAML0sNQCLb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jan 2014 12:26:48 +0100
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id s0DBQiK8012859;
        Mon, 13 Jan 2014 11:26:45 GMT
Received: from livre.home (livre.home [172.31.160.2])
        by freie.home (8.14.7/8.14.7) with ESMTP id s0DBQBfV030916;
        Mon, 13 Jan 2014 09:26:15 -0200
From:   Alexandre Oliva <oliva@gnu.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [3.13-rc regression] Unbreak Loongson2 and r4k-generic flush icache range
Organization: Free thinker, not speaking for the GNU Project
Date:   Mon, 13 Jan 2014 09:26:10 -0200
Message-ID: <ord2jwnmwd.fsf@livre.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <oliva@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliva@gnu.org
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

Commit 14bd8c08, that replaced Loongson2-specific ifdefs with cpu tests,
inverted the CPU test in local_r4k_flush_icache_range.  Loongson2 won't
boot up using the generic icache flush code.  Presumably other CPUs
might face other problems when presented with Loongson2-specific icache
flush code too.  This patch enabled my Yeeloong to boot up successfully
a 3.13-rc kernel for the first time, after a long git bisect session.

Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>
---
 arch/mips/mm/c-r4k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 62ffd20..1c2029d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -580,11 +580,11 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 	else {
 		switch (boot_cpu_type()) {
 		case CPU_LOONGSON2:
-			protected_blast_icache_range(start, end);
+			protected_loongson23_blast_icache_range(start, end);
 			break;
 
 		default:
-			protected_loongson23_blast_icache_range(start, end);
+			protected_blast_icache_range(start, end);
 			break;
 		}
 	}
-- 
1.8.3.1

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
