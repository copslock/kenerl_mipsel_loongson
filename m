Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 12:01:08 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:45262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009441AbcAKLAqpQive (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2016 12:00:46 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id C30F48F4F7;
        Mon, 11 Jan 2016 11:00:40 +0000 (UTC)
Received: from redhat.com (vpn1-6-10.ams2.redhat.com [10.36.6.10])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0BB0V2a024011;
        Mon, 11 Jan 2016 06:00:32 -0500
Date:   Mon, 11 Jan 2016 13:00:30 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
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
        Julian Calaby <julian.calaby@gmail.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v4 2/3] checkpatch: check for __smp outside barrier.h
Message-ID: <1452509968-19778-3-git-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452509968-19778-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51056
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

Introduction of __smp barriers cleans up a bunch of duplicate code, but
it gives people an additional handle onto a "new" set of barriers - just
because they're prefixed with __* unfortunately doesn't stop anyone from
using it (as happened with other arch stuff before.)

Add a checkpatch test so it will trigger a warning.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 94b4e33..25476c2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5143,6 +5143,16 @@ sub process {
 			}
 		}
 
+		my $underscore_smp_barriers = qr{__smp_(?:$barrier_stems)}x;
+
+		if ($realfile !~ m@^include/asm-generic/@ &&
+		    $realfile !~ m@/barrier\.h$@ &&
+		    $line =~ m/\b(?:$underscore_smp_barriers)\s*\(/ &&
+		    $line !~ m/^.\s*\#\s*define\s+(?:$underscore_smp_barriers)\s*\(/) {
+			WARN("MEMORY_BARRIER",
+			     "__smp memory barriers shouldn't be used outside barrier.h and asm-generic\n" . $herecurr);
+		}
+
 # check for waitqueue_active without a comment.
 		if ($line =~ /\bwaitqueue_active\s*\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
-- 
MST
