Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 11:58:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39402 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821310Ab3APK6DUVJBX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jan 2013 11:58:03 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0GAw0iV011608;
        Wed, 16 Jan 2013 11:58:00 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0GAvvvm011607;
        Wed, 16 Jan 2013 11:57:57 +0100
Date:   Wed, 16 Jan 2013 11:57:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Cong Ding <dinggnu@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] mpis: cavium-octeon/executive/cvmx-l2c.c: fix
 uninitialized variable
Message-ID: <20130116105757.GB26569@linux-mips.org>
References: <1358200025-15994-1-git-send-email-dinggnu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358200025-15994-1-git-send-email-dinggnu@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Jan 14, 2013 at 10:47:03PM +0100, Cong Ding wrote:

> the variable dummy is used without initialization.

Interesting - I wonder how you found this one.  My compiler (gcc 4.7)
doesn't warn about this one.

Nor does gcc notice that the whole summing up business is wasted efford.

So here's my counter proposal.  It works because ptr is a volatile pointer
so the compiler will always dereference it even if the returned value is
not being used.  The resulting code is a bit smaller.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/cavium-octeon/executive/cvmx-l2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
index 9f883bf..ec3e059 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-l2c.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
@@ -286,7 +286,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
 static void fault_in(uint64_t addr, int len)
 {
 	volatile char *ptr;
-	volatile char dummy;
+
 	/*
 	 * Adjust addr and length so we get all cache lines even for
 	 * small ranges spanning two cache lines.
@@ -300,7 +300,7 @@ static void fault_in(uint64_t addr, int len)
 	 */
 	CVMX_DCACHE_INVALIDATE;
 	while (len > 0) {
-		dummy += *ptr;
+		*ptr;
 		len -= CVMX_CACHE_LINE_SIZE;
 		ptr += CVMX_CACHE_LINE_SIZE;
 	}
