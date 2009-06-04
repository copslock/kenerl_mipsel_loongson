Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 23:42:04 +0100 (WEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53803 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022926AbZFDWlv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 23:41:51 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n54Mfh4o003145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jun 2009 15:41:44 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n54Mfgt9013257;
	Thu, 4 Jun 2009 15:41:42 -0700
Date:	Thu, 4 Jun 2009 15:41:42 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	sshtylyov@ru.mvista.com, davem@davemloft.net,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, tiwai@suse.de, ralf@linux-mips.org
Subject: Re: [PATCH 1/8] add lib/gcd.c
Message-Id: <20090604154142.71985f17.akpm@linux-foundation.org>
In-Reply-To: <200906041639.04868.florian@openwrt.org>
References: <200906041615.10467.florian@openwrt.org>
	<4A27DAAD.5000303@ru.mvista.com>
	<200906041639.04868.florian@openwrt.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 4 Jun 2009 16:39:03 +0200
Florian Fainelli <florian@openwrt.org> wrote:

> This patch adds lib/gcd.c which contains a greatest
> common divider implementation taken from
> sound/core/pcm_timer.c
> 
> Changes from v1:
> - fixed indentation
> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL as
> suggested by Ralf Baechle

I'm not sure about the _GPL change really - it's just a little helper
function.  But whatever - I'm trained to avoid that issue.

I made some changes:

From: Andrew Morton <akpm@linux-foundation.org>

- use swap() (pointed out by Joe)

- Just add gcd.o to lib-y, reove Kconfig changes.

Cc: David S. Miller <davem@davemloft.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Julius Volz <juliusv@google.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/Kconfig  |    3 ---
 lib/Makefile |    3 +--
 lib/gcd.c    |    8 +++-----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff -puN lib/Kconfig~lib-add-lib-gcdc-fix lib/Kconfig
--- a/lib/Kconfig~lib-add-lib-gcdc-fix
+++ a/lib/Kconfig
@@ -10,9 +10,6 @@ menu "Library routines"
 config BITREVERSE
 	tristate
 
-config GCD
-	bool
-
 config GENERIC_FIND_FIRST_BIT
 	bool
 
diff -puN lib/Makefile~lib-add-lib-gcdc-fix lib/Makefile
--- a/lib/Makefile~lib-add-lib-gcdc-fix
+++ a/lib/Makefile
@@ -12,7 +12,7 @@ lib-y := ctype.o string.o vsprintf.o cmd
 	 idr.o int_sqrt.o extable.o prio_tree.o \
 	 sha1.o irq_regs.o reciprocal_div.o argv_split.o \
 	 proportions.o prio_heap.o ratelimit.o show_mem.o \
-	 is_single_threaded.o plist.o decompress.o
+	 is_single_threaded.o plist.o decompress.o gcd.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
@@ -57,7 +57,6 @@ obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_CRC7)	+= crc7.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
-obj-$(CONFIG_GCD)	+= gcd.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff -puN lib/gcd.c~lib-add-lib-gcdc-fix lib/gcd.c
--- a/lib/gcd.c~lib-add-lib-gcdc-fix
+++ a/lib/gcd.c
@@ -1,3 +1,4 @@
+#include <linux/kernel.h>
 #include <linux/gcd.h>
 #include <linux/module.h>
 
@@ -6,11 +7,8 @@ unsigned long gcd(unsigned long a, unsig
 {
 	unsigned long r;
 
-	if (a < b) {
-		r = a;
-		a = b;
-		b = r;
-	}
+	if (a < b)
+		swap(a, b);
 	while ((r = a % b) != 0) {
 		a = b;
 		b = r;
_
