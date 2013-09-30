Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 16:56:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39775 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6862035Ab3I3O4ksc0-b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Sep 2013 16:56:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8UEuZVN016011;
        Mon, 30 Sep 2013 16:56:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8UEuUA0016005;
        Mon, 30 Sep 2013 16:56:30 +0200
Date:   Mon, 30 Sep 2013 16:56:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Andrew Pinski <Andrew.Pinski@caviumnetworks.com>,
        John Crispin <blogic@openwrt.org>
Subject: Issue with BUG() in asm-gemeric/bug.h if CONFIG_BUG=n
Message-ID: <20130930145630.GA14672@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38067
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

Lately I received several patches for build issues that only strike if
CONFIG_BUG is disabled.  Here's a test case extracted from one of them:

/*
 * Definition of BUG taken from asm-generic/bug.h for the CONFIG_BUG=n case
 */
#define BUG() 	do {} while(0)

int foo(int arg)
{
	int res;

	if (arg == 1)
		res = 23;
	else if (arg == 2)
		res = 42;
	else
		BUG();

	return res;
}

[ralf@h7 ~]$ gcc -O2 -Wall -c bug.c 
bug.c: In function ‘foo’:
bug.c:17:2: warning: ‘res’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  return res;
  ^

It's fairly obvious to see what's happening here - GCC doesn't know that
the else case can not be reached, thus razorsharply concludes that res
may be used uninitialized.

There several locations where MIPS - possibly other architectures as well -
is affected by this.

I think the definition of BUG should be changed to something like

#define BUG()	unreachable()

unreachable() will depending on the compiler being used, expand either
into a call to __builtin_unreachable() or where that function is
unavailable, into do {} while (1).

__builtin_unreachable() was introduce for GCC 4.5.0.

This means there'd be minor bloat for antique compilers - but probably
even better code generation for compilers supporting __builtin_unreachable().

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 7d10f96..6f78771 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -108,7 +108,7 @@ extern void warn_slowpath_null(const char *file, const int line);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
+#define BUG() unreachable()
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON

----- End forwarded message -----

  Ralf
