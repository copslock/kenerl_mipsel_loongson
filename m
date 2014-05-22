Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:43:03 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56148 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818667AbaEVNnBMgTot (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:43:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MDgpHN012455;
        Thu, 22 May 2014 15:42:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MDgjqF012454;
        Thu, 22 May 2014 15:42:45 +0200
Date:   Thu, 22 May 2014 15:42:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yong Zhang <yong.zhang0@gmail.com>
Cc:     Yong Zhang <yong.zhang@windriver.com>, linux-mips@linux-mips.org,
        huawei.libin@huawei.com
Subject: Re: [PATCH] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140522134245.GF10287@linux-mips.org>
References: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com>
 <20140521053853.GC19655@pek-yzhang-d1>
 <20140521112936.GC17197@linux-mips.org>
 <20140522020611.GA6813@zhy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140522020611.GA6813@zhy>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40243
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

On Thu, May 22, 2014 at 10:06:11AM +0800, Yong Zhang wrote:

> On Wed, May 21, 2014 at 01:29:36PM +0200, Ralf Baechle wrote:
> > On Wed, May 21, 2014 at 01:38:53PM +0800, Yong Zhang wrote:
> > 
> > > Please check the V2 in which I add the reporter.
> > > And thanks libin for reporting it :)
> > 
> > The bug was introduced in 5636919b5c909fee54a6ef5226475ecae012ad02
> > [MIPS: Outline udelay and fix a few issues.] in 2009 btw.  I think
> > the intension was to avoid holes in the structure and minimize
> > the bloat.  I instead applied aptch
> 
> Could you please show the patch?
> 
> > which also moves another member
> > of the struct arond such that no hole will be created in the struct.
> > This is important because the strcture it accessed fairly frequently
> > so we want to fit the most important members into as few cache
> > lines as possible.
> 
> I have tried to move the struct member around, but I found that the
> hole cann't be avoided completely because for exampe struct cache_desc
> is a bit special.

Yes, struct cache_desc is still a problem.  Easily solvable though -
some of it's members are excessivly large; by using smaller data types
both the struct and its required alignment will shrink.  But that's
for another patch; as for this patch my goal to just not make things
any worse.

  Ralf

---
 arch/mips/include/asm/cpu-info.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index dc2135b..ff2707a 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -39,14 +39,14 @@ struct cache_desc {
 #define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
 
 struct cpuinfo_mips {
-	unsigned int		udelay_val;
-	unsigned int		asid_cache;
+	unsigned long		asid_cache;
 
 	/*
 	 * Capability and feature descriptor structure for MIPS CPU
 	 */
 	unsigned long		options;
 	unsigned long		ases;
+	unsigned int		udelay_val;
 	unsigned int		processor_id;
 	unsigned int		fpu_id;
 	unsigned int		msa_id;
