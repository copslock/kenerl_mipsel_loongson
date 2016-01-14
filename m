Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 00:33:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28762 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010191AbcANXduI5HX5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 00:33:50 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 4F42015001C15;
        Thu, 14 Jan 2016 23:33:39 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 14 Jan
 2016 23:33:43 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 14 Jan
 2016 15:33:41 -0800
Message-ID: <56983054.4070807@imgtec.com>
Date:   Thu, 14 Jan 2016 15:33:40 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     <paulmck@linux.vnet.ibm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        <virtualization@lists.linux-foundation.org>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>,
        <linux-ia64@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <x86@kernel.org>, <user-mode-linux-devel@lists.sourceforge.net>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-sh@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <xen-devel@lists.xenproject.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, <ddaney.cavm@gmail.com>,
        <james.hogan@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
References: <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com> <5697F6D2.60409@imgtec.com> <20160114203430.GC3818@linux.vnet.ibm.com> <56980C91.1010403@imgtec.com> <20160114212913.GF3818@linux.vnet.ibm.com> <569814F2.50801@imgtec.com> <20160114225510.GJ3818@linux.vnet.ibm.com>
In-Reply-To: <20160114225510.GJ3818@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 01/14/2016 02:55 PM, Paul E. McKenney wrote:
> OK, so it looks like Will was asking not about WRC+addr+addr, but instead
> about WRC+sync+addr.
(He actually asked twice about this and that too but skip this)

> I am guessing that the manual's "Older instructions which must be globally
> performed when the SYNC instruction completes" provides the equivalent
> of ARM/Power A-cumulativity, which can be thought of as transitivity
> backwards in time.  This leads me to believe that your smp_mb() needs
> to use SYNC rather than SYNC_MB, as was the subject of earlier spirited
> discussion in this thread.

Don't be fooled here by words "ordered" and "completed" - it is HW 
design items and actually written poorly.
Just assume that SYNC_MB is absolutely the same as SYNC for any CPU and 
coherent device (besides performance). The difference can be in 
non-coherent devices because SYNC actually tries to make a barrier for 
them too. In some SoCs it is just the same because there is no need to 
barrier a non-coherent device (device register access usually strictly 
ordered... if there is no bridge in between).

>
> Suppose you have something like this:
> ...
> Does your hardware guarantee that it is not possible for all of r0,
> r1, r2, and r3 to be equal to zero at the end of the test, assuming
> that a, b, c, and d are all initially zero, and the four functions
> above run concurrently?

It is assumed to be so from Arch point of view. HW bugs are possible, of 
course.

> Another (more academic) case is this one, with x and y initially zero:
>
> ...
> Does SYNC_MB() prohibit r1 == 1 && r2 == 0 && r3 == 1 && r4 == 0?

It is assumed to be so from Arch point of view. HW bugs are possible, of 
course.

Note: I am not sure about ANY past MIPS R2 CPU because that stuff is 
implemented some time but nobody made it in Linux kernel (it was used by 
some vendor for non-Linux system). For that reason my patch for 
lightweight SYNCs has an option - implement it or implement a generic 
SYNC. It is possible that some vendor did it in different way but nobody 
knows or test it. But as a minimum - SYNC must be implemented in 
spinlocks/atomics/bitops, in recent P5600 it is proven that read can 
pass write in atomics.

MIPS R6 is a different story, I verified lightweight SYNCs from the 
beginning and it also should use SYNCs.

- Leonid.
