Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2011 15:08:14 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54891 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491126Ab1F2NII (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Jun 2011 15:08:08 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5TD7LWv021276;
        Wed, 29 Jun 2011 14:07:23 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5TD7BAE021254;
        Wed, 29 Jun 2011 14:07:11 +0100
Date:   Wed, 29 Jun 2011 14:07:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, alan@linux.intel.com, bcasavan@sgi.com,
        airlied@linux.ie, grundler@parisc-linux.org,
        JBottomley@parallels.com, perex@perex.cz, rpurdie@rpsys.net,
        klassert@mathematik.tu-chemnitz.de, tj@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various section mismatches and build errors.
Message-ID: <20110629130711.GA15649@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
 <20110627.221257.1290251511587162468.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110627.221257.1290251511587162468.davem@davemloft.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23825

On Mon, Jun 27, 2011 at 10:12:57PM -0700, David Miller wrote:

> commit 948252cb9e01d65a89ecadf67be5018351eee15e
> Author: David S. Miller <davem@davemloft.net>
> Date:   Tue May 31 19:27:48 2011 -0700
> 
>     Revert "net: fix section mismatches"
>     
>     This reverts commit e5cb966c0838e4da43a3b0751bdcac7fe719f7b4.
>     
>     It causes new build regressions with gcc-4.2 which is
>     pretty common on non-x86 platforms.
>     
>     Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> and postings that led to this revert including:
> 
> http://marc.info/?l=linux-netdev&m=130653748205263&w=2

Thanks for the pointers; I looked into it a bit deeper and found that the
construct which hppa64-linux-gcc 4.2.4 doesn't like is the combination of
const and __devinitconst __devinitdata.

My patches are minimalistic and don't do any constification and seem to
work fine for PA-RISC.

A possible alternative to allow the use of Michał's reverted patch would
be to conditionalize the definition of __devinitconst.  There is no
user of __devexitconst so I left that unchanged.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 include/linux/init.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 577671c..e12fd85 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -84,7 +84,15 @@
 /* Used for HOTPLUG */
 #define __devinit        __section(.devinit.text) __cold
 #define __devinitdata    __section(.devinit.data)
+#if defined __GNUC__ && (__GNUC__ == 4) && (__GNUC_MINOR__ == 2)
+/*
+ * GCC 4.2 will sometimes throw an error if the combination of const and
+ * __devinitconst is being used.  As a workaround make __devinitconst a noop
+ */
+#define __devinitconst
+#else
 #define __devinitconst   __section(.devinit.rodata)
+#endif
 #define __devexit        __section(.devexit.text) __exitused __cold
 #define __devexitdata    __section(.devexit.data)
 #define __devexitconst   __section(.devexit.rodata)
