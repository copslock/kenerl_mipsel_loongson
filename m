Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Sep 2013 20:43:15 +0200 (CEST)
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:47679 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3ITSnNF-6rT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Sep 2013 20:43:13 +0200
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2EA7FC209C;
        Fri, 20 Sep 2013 18:43:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dime44_559f2a9c3a216
X-Filterd-Recvd-Size: 2980
Received: from [192.168.1.157] (pool-96-251-49-11.lsanca.fios.verizon.net [96.251.49.11])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Sep 2013 18:43:08 +0000 (UTC)
Message-ID: <1379702587.2301.12.camel@joe-AO722>
Subject: Re: [PATCH 2/2] framebuffer: Remove pmag-aa-fb
From:   Joe Perches <joe@perches.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Date:   Fri, 20 Sep 2013 11:43:07 -0700
In-Reply-To: <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com>
         <6f500d88eb23fd9a4cfc5583f5ca17bc5f58fe24.1379641901.git.joe@perches.com>
         <CAMuHMdW6R5qTJ0uvsUUaYBZAqFcNshPsXeMbz5hwqq5UOkJr-g@mail.gmail.com>
         <alpine.LFD.2.03.1309201907380.8379@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Fri, 2013-09-20 at 19:18 +0100, Maciej W. Rozycki wrote:
> Joe, Geert --

Hi Maciej

> Can we please wait with that a few days?  I've been reviving DECstation 
> bits recently but the generic stuff took priority (thankfully little 
> bitrot there, the port generally works, except from the 64-bit mode).  I 
> think it'll make more sense if we have an incremental diff in the repo 
> rather than a complete removal, followed with a readdition with necessary 
> adjustments.

Good for you.

I do wonder how many of these still exist though.

I haven't had one of those on a desk since the early
'90's (a VAXstation w/VMS and a DECstation w/Ultrix)

This one's been dead for about that long too so
what's a little more time...

The commit that removed it was:
-------------------
commit c708093f8164011d01eb3bbdf7d61965f283ee0e
Author: James Simmons <jsimmons@maxwell.earthlink.net>
Date:   Wed Oct 30 20:06:21 2002 -0800

Moved all console configuration out of arch directories into
drivers/video/console. Allow resize of a single VC via the tty layer.
Nuked GET_FB_IDX.
-------------------

I think you could do:

---

 drivers/video/pmag-aa-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/pmag-aa-fb.c b/drivers/video/pmag-aa-fb.c
index 8384248..0362fb7 100644
--- a/drivers/video/pmag-aa-fb.c
+++ b/drivers/video/pmag-aa-fb.c
@@ -459,7 +459,7 @@ static int __init init_one(int slot)
 		return -EINVAL;
 
 	printk(KERN_INFO "fb%d: %s frame buffer in TC slot %d\n",
-	       GET_FB_IDX(ip->info.node), ip->info.modename, slot);
+	       ip->info.node, ip->info.modename, slot);
 
 	return 0;
 }
