Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 20:01:04 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990439AbeGQSA7W2HRl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2018 20:00:59 +0200
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HHxGP4097151
        for <linux-mips@linux-mips.org>; Tue, 17 Jul 2018 14:00:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k9hfjasp5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 17 Jul 2018 14:00:56 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 14:00:56 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 14:00:49 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HI0nrO57933968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 18:00:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4986EB2066;
        Tue, 17 Jul 2018 14:00:40 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2954CB206A;
        Tue, 17 Jul 2018 14:00:40 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 14:00:40 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E80C916CA213; Tue, 17 Jul 2018 11:03:12 -0700 (PDT)
Date:   Tue, 17 Jul 2018 11:03:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
Reply-To: paulmck@linux.vnet.ibm.com
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
 <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071718-2213-0000-0000-000002CC2C67
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009381; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062195; UDB=6.00545347; IPR=6.00840052;
 MB=3.00022173; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 18:00:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071718-2214-0000-0000-00005ADF1203
Message-Id: <20180717180312.GP12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170188
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64900
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

On Tue, Jul 17, 2018 at 10:52:32AM -0700, Paul Burton wrote:
> Hi Huacai,
> 
> On Fri, Jul 13, 2018 at 03:37:57PM +0800, Huacai Chen wrote:
> > Linux expects that if a CPU modifies a memory location, then that
> > modification will eventually become visible to other CPUs in the system.
> > 
> > On Loongson-3 processor with SFB (Store Fill Buffer), loads may be
> > prioritised over stores so it is possible for a store operation to be
> > postponed if a polling loop immediately follows it. If the variable
> > being polled indirectly depends on the outstanding store [for example,
> > another CPU may be polling the variable that is pending modification]
> > then there is the potential for deadlock if interrupts are disabled.
> > This deadlock occurs in qspinlock code.
> > 
> > This patch changes the definition of cpu_relax() to smp_mb() for
> > Loongson-3, forcing a flushing of the SFB on SMP systems before the
> > next load takes place. If the Kernel is not compiled for SMP support,
> > this will expand to a barrier() as before.
> > 
> > References: 534be1d5a2da940 (ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  arch/mips/include/asm/processor.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> > index af34afb..a8c4a3a 100644
> > --- a/arch/mips/include/asm/processor.h
> > +++ b/arch/mips/include/asm/processor.h
> > @@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
> >  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
> >  #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
> >  
> > +#ifdef CONFIG_CPU_LOONGSON3
> > +/*
> > + * Loongson-3's SFB (Store-Fill-Buffer) may get starved when stuck in a read
> > + * loop. Since spin loops of any kind should have a cpu_relax() in them, force
> > + * a Store-Fill-Buffer flush from cpu_relax() such that any pending writes will
> > + * become available as expected.
> > + */
> 
> I think "may starve writes" or "may queue writes indefinitely" would be
> clearer than "may get starved".
> 
> > +#define cpu_relax()	smp_mb()
> > +#else
> >  #define cpu_relax()	barrier()
> > +#endif
> >  
> >  /*
> >   * Return_address is a replacement for __builtin_return_address(count)
> > -- 
> > 2.7.0
> 
> Apart from the comment above though this looks better to me.
> 
> Re-copying the LKMM maintainers - are you happy(ish) with this?

This looks much better to me.

							Thanx, Paul
