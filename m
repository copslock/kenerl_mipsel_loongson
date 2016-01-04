Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 16:05:09 +0100 (CET)
Received: from e06smtp08.uk.ibm.com ([195.75.94.104]:33294 "EHLO
        e06smtp08.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008363AbcADPE6ty8sJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 16:04:58 +0100
Received: from localhost
        by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <schwidefsky@de.ibm.com>;
        Mon, 4 Jan 2016 15:04:53 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp08.uk.ibm.com (192.168.101.138) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 4 Jan 2016 15:04:47 -0000
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: schwidefsky@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 68006219005C
        for <linux-mips@linux-mips.org>; Mon,  4 Jan 2016 15:04:36 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u04F4kBH49610960
        for <linux-mips@linux-mips.org>; Mon, 4 Jan 2016 15:04:46 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u04F4iRf022936
        for <linux-mips@linux-mips.org>; Mon, 4 Jan 2016 08:04:46 -0700
Received: from mschwide (dyn-9-152-212-43.boeblingen.de.ibm.com [9.152.212.43])
        by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u04F4ijb022909;
        Mon, 4 Jan 2016 08:04:44 -0700
Date:   Mon, 4 Jan 2016 16:03:39 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 06/32] s390: reuse asm-generic/barrier.h
Message-ID: <20160104160339.25101b5d@mschwide>
In-Reply-To: <20160104132042.GW6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
        <1451572003-2440-7-git-send-email-mst@redhat.com>
        <20160104132042.GW6344@twins.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16010415-0033-0000-0000-00000548E4C1
Return-Path: <schwidefsky@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwidefsky@de.ibm.com
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

On Mon, 4 Jan 2016 14:20:42 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Dec 31, 2015 at 09:06:30PM +0200, Michael S. Tsirkin wrote:
> > On s390 read_barrier_depends, smp_read_barrier_depends
> > smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
> > asm-generic variants exactly. Drop the local definitions and pull in
> > asm-generic/barrier.h instead.
> > 
> > This is in preparation to refactoring this code area.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/include/asm/barrier.h | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> > index 7ffd0b1..c358c31 100644
> > --- a/arch/s390/include/asm/barrier.h
> > +++ b/arch/s390/include/asm/barrier.h
> > @@ -30,14 +30,6 @@
> >  #define smp_rmb()			rmb()
> >  #define smp_wmb()			wmb()
> >  
> > -#define read_barrier_depends()		do { } while (0)
> > -#define smp_read_barrier_depends()	do { } while (0)
> > -
> > -#define smp_mb__before_atomic()		smp_mb()
> > -#define smp_mb__after_atomic()		smp_mb()
> 
> As per:
> 
>   lkml.kernel.org/r/20150921112252.3c2937e1@mschwide
> 
> s390 should change this to barrier() instead of smp_mb() and hence
> should not use the generic versions.
 
Yes, we wanted to simplify this. Thanks for the reminder, I'll queue
a patch.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
