Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 15:12:31 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34581 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdEaNMYFxJQy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 15:12:24 +0200
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4VDBYl8094981
        for <linux-mips@linux-mips.org>; Wed, 31 May 2017 09:12:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2asx3v197c-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 31 May 2017 09:12:21 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 31 May 2017 09:12:20 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 31 May 2017 09:12:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v4VDCO8l393702;
        Wed, 31 May 2017 13:12:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E235B2050;
        Wed, 31 May 2017 09:09:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.233.220])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id E63B7B2046;
        Wed, 31 May 2017 09:09:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F12E916C61F2; Wed, 31 May 2017 06:12:16 -0700 (PDT)
Date:   Wed, 31 May 2017 06:12:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-kO==gMDm3E6U8CR-zhwmZGztRy7Trcezf8oZxgn01g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 17053113-0040-0000-0000-00000350E966
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00007149; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000212; SDB=6.00868204; UDB=6.00431441; IPR=6.00648083;
 BA=6.00005388; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00015656; XFM=3.00000015;
 UTC=2017-05-31 13:12:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17053113-0041-0000-0000-00000744E9EA
Message-Id: <20170531131216.GJ3956@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1703280000
 definitions=main-1705310240
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58088
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

On Wed, May 31, 2017 at 12:21:10PM +0200, Arnd Bergmann wrote:
> On Wed, May 31, 2017 at 11:43 AM, Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> > On 5/30/2017 1:20 PM, Arnd Bergmann wrote:
> >>
> >> An unknown change in the kernel headers caused a build regression
> >> in an MTD partition driver:
> >>
> >> In file included from drivers/mtd/bcm47xxpart.c:12:0:
> >> include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
> >> include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first
> >> use in this function)
> >>
> >> Clearly we want to include linux/errno.h here.
> >
> >
> > unfortunate that you did not find the commit that caused this build
> > regression. You could produce preprocessor output when it was working to see
> > where errno.h got implicitly included and start looking there for git
> > history.
> 
> I did a 'git bisect run make drivers/mtd/bcm47xxpart.o' now, which pointed to
> 0bc2d534708b ("rcu: Refactor #includes from include/linux/rcupdate.h").
> 
> That commit seems reasonable, it was just bad luck that it caused this
> regression. The commit is currently in the rcu/rcu/next branch of tip.git,
> so Paul could merge the patch there.

Apologies for the inconvenience, not sure why 0day test robot didn't
find this.  Probably because it cannot test each and every driver.  ;-)

This patch, correct?

	https://lkml.org/lkml/2017/5/30/348

							Thanx, Paul
