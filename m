Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 16:39:53 +0100 (CET)
Received: from e06smtp05.uk.ibm.com ([195.75.94.101]:53900 "EHLO
        e06smtp05.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009632AbcAEPjwQ7hFe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 16:39:52 +0100
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Tue, 5 Jan 2016 15:39:46 -0000
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 5 Jan 2016 15:39:44 -0000
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: borntraeger@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 69D0817D805D
        for <linux-mips@linux-mips.org>; Tue,  5 Jan 2016 15:40:28 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u05Fdhp061538552
        for <linux-mips@linux-mips.org>; Tue, 5 Jan 2016 15:39:43 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u05FdeMb015056
        for <linux-mips@linux-mips.org>; Tue, 5 Jan 2016 08:39:43 -0700
Received: from oc1450873852.ibm.com (sig-9-79-87-246.de.ibm.com [9.79.87.246])
        by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u05FdbRD014976;
        Tue, 5 Jan 2016 08:39:37 -0700
Subject: Re: [PATCH v2 22/32] s390: define __smp_xxx
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-23-git-send-email-mst@redhat.com>
 <20160104134525.GA6344@twins.programming.kicks-ass.net>
 <20160104221323-mutt-send-email-mst@redhat.com>
 <20160105091319.59ddefc7@mschwide>
 <20160105105335-mutt-send-email-mst@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Andrey Konovalov <andreyknvl@google.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <568BE3B9.8020901@de.ibm.com>
Date:   Tue, 5 Jan 2016 16:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20160105105335-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16010515-0021-0000-0000-0000055A4722
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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

On 01/05/2016 10:30 AM, Michael S. Tsirkin wrote:

> 
> arch/s390/kernel/vdso.c:        smp_mb();
> 
> Looking at
> 	Author: Christian Borntraeger <borntraeger@de.ibm.com>
> 	Date:   Fri Sep 11 16:23:06 2015 +0200
> 
> 	    s390/vdso: use correct memory barrier
> 
> 	    By definition smp_wmb only orders writes against writes. (Finish all
> 	    previous writes, and do not start any future write). To protect the
> 	    vdso init code against early reads on other CPUs, let's use a full
> 	    smp_mb at the end of vdso init. As right now smp_wmb is implemented
> 	    as full serialization, this needs no stable backport, but this change
> 	    will be necessary if we reimplement smp_wmb.
> 
> ok from hypervisor point of view, but it's also strange:
> 1. why isn't this paired with another mb somewhere?
>    this seems to violate barrier pairing rules.
> 2. how does smp_mb protect against early reads on other CPUs?
>    It normally does not: it orders reads from this CPU versus writes
>    from same CPU. But init code does not appear to read anything.
>    Maybe this is some s390 specific trick?
> 
> I could not figure out the above commit.

It was probably me misreading the code. I change a wmb into a full mb here
since I was changing the defintion of wmb to a compiler barrier. I tried to
fixup all users of wmb that really pair with other code. I assumed that there
must be some reader (as there was a wmb before) but I could not figure out
which. So I just played safe here.

But it probably can be removed.

> arch/s390/kvm/kvm-s390.c:       smp_mb();

This can go. If you have a patch, I can carry that via the kvms390 tree,
or I will spin a new patch with you as suggested-by.

Christian
