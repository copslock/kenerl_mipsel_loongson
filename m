Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 12:37:16 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:53365 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009352AbcADLhDWSC1O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 12:37:03 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id D8695552FB;
        Mon,  4 Jan 2016 11:37:00 +0000 (UTC)
Received: from redhat.com (vpn1-5-6.ams2.redhat.com [10.36.5.6])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u04Barj2016073;
        Mon, 4 Jan 2016 06:36:54 -0500
Date:   Mon, 4 Jan 2016 13:36:53 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Cc : Andy Whitcroft" <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/3] checkpatch.pl: add missing memory barriers
Message-ID: <1451907395-15978-2-git-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451907395-15978-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

SMP-only barriers were missing in checkpatch.pl

Refactor code slightly to make adding more variants easier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b3c228..0245bbe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5116,7 +5116,14 @@ sub process {
 			}
 		}
 # check for memory barriers without a comment.
-		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
+
+		my @barriers = ('mb', 'rmb', 'wmb', 'read_barrier_depends');
+		my @smp_barriers = ('smp_store_release', 'smp_load_acquire', 'smp_store_mb');
+
+		@smp_barriers = (@smp_barriers, map {"smp_" . $_} @barriers);
+		my $all_barriers = join('|', (@barriers, @smp_barriers));
+
+		if ($line =~ /\b($all_barriers)\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
 				WARN("MEMORY_BARRIER",
 				     "memory barrier without comment\n" . $herecurr);
-- 
MST
