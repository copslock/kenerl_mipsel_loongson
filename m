Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 00:16:48 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990557AbdFAWQkdQRw- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 00:16:40 +0200
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v51ME7Hs077983
        for <linux-mips@linux-mips.org>; Thu, 1 Jun 2017 18:16:39 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2atjysrkc2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Thu, 01 Jun 2017 18:16:38 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Jun 2017 18:16:38 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e18.ny.us.ibm.com (146.89.104.205) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 1 Jun 2017 18:16:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v51MGQYN43974722;
        Thu, 1 Jun 2017 22:16:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A393B2056;
        Thu,  1 Jun 2017 18:14:08 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.110])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id B8FEDB2052;
        Thu,  1 Jun 2017 18:14:07 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4137A16C3835; Thu,  1 Jun 2017 15:16:32 -0700 (PDT)
Date:   Thu, 1 Jun 2017 15:16:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] bcm47xx: fix build regression
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170530112027.3983554-1-arnd@arndb.de>
 <7b6903a2-ce54-44f9-18ed-a14bd32069ce@broadcom.com>
 <CAK8P3a2-kO==gMDm3E6U8CR-zhwmZGztRy7Trcezf8oZxgn01g@mail.gmail.com>
 <20170531131216.GJ3956@linux.vnet.ibm.com>
 <CAK8P3a1wcVC1+dPbtAgn=2RbToV_ai+dGc2tJxdQ4r1s+nxAFg@mail.gmail.com>
 <20170531163110.GL3956@linux.vnet.ibm.com>
 <51fbd3af-853e-f055-bef5-58d7438ba1ae@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51fbd3af-853e-f055-bef5-58d7438ba1ae@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 17060122-0044-0000-0000-000003420660
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00007155; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000212; SDB=6.00868811; UDB=6.00431836; IPR=6.00648736;
 BA=6.00005393; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00015673; XFM=3.00000015;
 UTC=2017-06-01 22:16:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17060122-0045-0000-0000-0000077006AC
Message-Id: <20170601221632.GH3956@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-06-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1703280000
 definitions=main-1706010412
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Wed, May 31, 2017 at 09:30:19PM +0200, Arend van Spriel wrote:
> On 31-05-17 18:31, Paul E. McKenney wrote:
> > On Wed, May 31, 2017 at 03:34:57PM +0200, Arnd Bergmann wrote:
> >> On Wed, May 31, 2017 at 3:12 PM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >>> On Wed, May 31, 2017 at 12:21:10PM +0200, Arnd Bergmann wrote:
> >>>> On Wed, May 31, 2017 at 11:43 AM, Arend van Spriel
> >>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>> On 5/30/2017 1:20 PM, Arnd Bergmann wrote:
> >>>>>>
> >>>>>> An unknown change in the kernel headers caused a build regression
> >>>>>> in an MTD partition driver:
> >>>>>>
> >>>>>> In file included from drivers/mtd/bcm47xxpart.c:12:0:
> >>>>>> include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
> >>>>>> include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first
> >>>>>> use in this function)
> >>>>>>
> >>>>>> Clearly we want to include linux/errno.h here.
> >>>>>
> >>>>>
> >>>>> unfortunate that you did not find the commit that caused this build
> >>>>> regression. You could produce preprocessor output when it was working to see
> >>>>> where errno.h got implicitly included and start looking there for git
> >>>>> history.
> >>>>
> >>>> I did a 'git bisect run make drivers/mtd/bcm47xxpart.o' now, which pointed to
> >>>> 0bc2d534708b ("rcu: Refactor #includes from include/linux/rcupdate.h").
> >>>>
> >>>> That commit seems reasonable, it was just bad luck that it caused this
> >>>> regression. The commit is currently in the rcu/rcu/next branch of tip.git,
> >>>> so Paul could merge the patch there.
> 
> Arnd,
> 
> Thanks for digging a bit further. I am a sucker for telling the whole story.
> 
> >>>
> >>> Apologies for the inconvenience, not sure why 0day test robot didn't
> >>> find this.  Probably because it cannot test each and every driver.  ;-)
> >>
> >> No worries.
> >>
> >>> This patch, correct?
> >>>
> >>>         https://lkml.org/lkml/2017/5/30/348
> >>
> >> Right, I should have included the link.
> > 
> > And my turn to say "no worries".  ;-)
> > 
> > I reworked the commit log to tell the full story as shown below.
> > Anything I misstated or otherwise missed?
> 
> Maybe add the 'Fixes:' tag, ie.:
> 
> Fixes: 0bc2d534708b ("rcu: Refactor #includes from
> include/linux/rcupdate.h")
> 
> Seems a bit redundant given that you mentioned it in the commit message,
> but it might be looked for in kernel-stats scripts.

Had to rebase anyway for other reasons, so why not?

							Thanx, Paul

> Regards,
> Arend
> 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit ff278071dce9af9da2b5e2b33f682710a855d266
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Wed May 31 09:26:07 2017 -0700
> > 
> >     bcm47xx: fix build regression
> >     
> >     Commit 0bc2d534708b ("rcu: Refactor #includes from include/linux/rcupdate.h")
> >     caused a build regression in an MTD partition driver:
> >     
> >     In file included from drivers/mtd/bcm47xxpart.c:12:0:
> >     include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
> >     include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first use in this function)
> >     
> >     The rcupdate.h file has no particular need for linux/errno.h, so this
> >     commit includes linux/errno.h into bcm47xx_nvram.h.
> >     
> >     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
> > index 2793652fbf66..a414a2b53e41 100644
> > --- a/include/linux/bcm47xx_nvram.h
> > +++ b/include/linux/bcm47xx_nvram.h
> > @@ -8,6 +8,7 @@
> >  #ifndef __BCM47XX_NVRAM_H
> >  #define __BCM47XX_NVRAM_H
> >  
> > +#include <linux/errno.h>
> >  #include <linux/types.h>
> >  #include <linux/kernel.h>
> >  #include <linux/vmalloc.h>
> > 
> 
