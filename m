Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:45:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51194 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826582Ab3IRNpjVwV2G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 15:45:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8IDja8b030107;
        Wed, 18 Sep 2013 15:45:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8IDjXf8030106;
        Wed, 18 Sep 2013 15:45:33 +0200
Date:   Wed, 18 Sep 2013 15:45:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: ath79: Avoid using unitialized 'reg' variable
Message-ID: <20130918134533.GN22468@linux-mips.org>
References: <1377082042-4219-1-git-send-email-markos.chandras@imgtec.com>
 <20130903133839.GA10563@linux-mips.org>
 <5225EC3B.1070701@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5225EC3B.1070701@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37865
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

On Tue, Sep 03, 2013 at 03:03:39PM +0100, Markos Chandras wrote:

> >Was this triggered by CONFIG_BUG=n?
> >
> >   Ralf
> >
> 
> Hi Ralf,
> 
> Yes it was triggered by CONFIG_BUG=n

So here's a small test case to demonstrate the issue:

/*
 * Definition of BUG taken from asm-generic/bug.h for the CONFIG_BUG=n case
 */
#define BUG() 	do {} while(0)

int foo(int arg)
{
	int res;

	if (arg == 1)
		res = 23;
	else if (arg -= 2)
		res = 42;
	else
		BUG();

	return res;
}

[ralf@h7 linux-mips]$ gcc -O2 -Wall -c bug.c 
bug.c: In function ‘foo’:
bug.c:17:2: warning: ‘res’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  return res;
  ^

It's fairly obvious to see what's happening here - GCC doesn't know that
the else case can not be reached, thus razorsharply concludes that res
may be used uninitialized.

I think the definition of BUG should be changed to something like

#define BUG()	unreachable()

This has the disadvantage of of expanding into a while (1) loop for older
compilers - but that's only for older compilers, relativly minor in
bloat and last I checked BUG() wasn't performance critical ;-)

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
