Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 01:48:08 +0100 (CET)
Received: from e36.co.us.ibm.com ([32.97.110.154]:56571 "EHLO
        e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010460AbcAOAsF2V5TV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 01:48:05 +0100
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Jan 2016 17:47:58 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 14 Jan 2016 17:47:57 -0700
X-IBM-Helo: d03dlp03.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7699119D8041;
        Thu, 14 Jan 2016 17:35:58 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0F0lvWh27984066;
        Thu, 14 Jan 2016 17:47:57 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0F0lqlQ009125;
        Thu, 14 Jan 2016 17:47:56 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0F0lpTa009100;
        Thu, 14 Jan 2016 17:47:52 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9693816C081E; Thu, 14 Jan 2016 16:47:53 -0800 (PST)
Date:   Thu, 14 Jan 2016 16:47:53 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160115004753.GN3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <56983054.4070807@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56983054.4070807@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011500-0021-0000-0000-0000161D515B
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51145
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

On Thu, Jan 14, 2016 at 03:33:40PM -0800, Leonid Yegoshin wrote:
> On 01/14/2016 02:55 PM, Paul E. McKenney wrote:
> >OK, so it looks like Will was asking not about WRC+addr+addr, but instead
> >about WRC+sync+addr.
> (He actually asked twice about this and that too but skip this)

Fair enough!  ;-)

> >I am guessing that the manual's "Older instructions which must be globally
> >performed when the SYNC instruction completes" provides the equivalent
> >of ARM/Power A-cumulativity, which can be thought of as transitivity
> >backwards in time.  This leads me to believe that your smp_mb() needs
> >to use SYNC rather than SYNC_MB, as was the subject of earlier spirited
> >discussion in this thread.
> 
> Don't be fooled here by words "ordered" and "completed" - it is HW
> design items and actually written poorly.
> Just assume that SYNC_MB is absolutely the same as SYNC for any CPU
> and coherent device (besides performance). The difference can be in
> non-coherent devices because SYNC actually tries to make a barrier
> for them too. In some SoCs it is just the same because there is no
> need to barrier a non-coherent device (device register access
> usually strictly ordered... if there is no bridge in between).

So smp_mb() can be SYNC_MB.  However, mb() needs to be SYNC for MMIO
purposes, correct?

> >Suppose you have something like this:
> >...
> >Does your hardware guarantee that it is not possible for all of r0,
> >r1, r2, and r3 to be equal to zero at the end of the test, assuming
> >that a, b, c, and d are all initially zero, and the four functions
> >above run concurrently?
> 
> It is assumed to be so from Arch point of view. HW bugs are
> possible, of course.

Indeed!

> >Another (more academic) case is this one, with x and y initially zero:
> >
> >...
> >Does SYNC_MB() prohibit r1 == 1 && r2 == 0 && r3 == 1 && r4 == 0?
> 
> It is assumed to be so from Arch point of view. HW bugs are
> possible, of course.

Looks to me like smp_mb() can be SYNC_MB, then.

> Note: I am not sure about ANY past MIPS R2 CPU because that stuff is
> implemented some time but nobody made it in Linux kernel (it was
> used by some vendor for non-Linux system). For that reason my patch
> for lightweight SYNCs has an option - implement it or implement a
> generic SYNC. It is possible that some vendor did it in different
> way but nobody knows or test it. But as a minimum - SYNC must be
> implemented in spinlocks/atomics/bitops, in recent P5600 it is
> proven that read can pass write in atomics.
> 
> MIPS R6 is a different story, I verified lightweight SYNCs from the
> beginning and it also should use SYNCs.

So you need to build a different kernel for some types of MIPS systems?
Or do you do boot-time rewriting, like a number of other arches do?

							Thanx, Paul
