Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 18:57:58 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:33106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011669AbaJ1R55KzYLR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 18:57:57 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XjB1f-0007q7-Qz; Tue, 28 Oct 2014 18:57:47 +0100
Date:   Tue, 28 Oct 2014 18:57:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Qiaowei Ren <qiaowei.ren@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 05/12] x86, mpx: on-demand kernel allocation of bounds
 tables
In-Reply-To: <544FD5D4.4090404@intel.com>
Message-ID: <alpine.DEB.2.11.1410281851390.5308@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-6-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241257300.5308@nanos> <544FD5D4.4090404@intel.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Tue, 28 Oct 2014, Dave Hansen wrote:

> On 10/24/2014 05:08 AM, Thomas Gleixner wrote:
> > On Sun, 12 Oct 2014, Qiaowei Ren wrote:
> >> +	/*
> >> +	 * Go poke the address of the new bounds table in to the
> >> +	 * bounds directory entry out in userspace memory.  Note:
> >> +	 * we may race with another CPU instantiating the same table.
> >> +	 * In that case the cmpxchg will see an unexpected
> >> +	 * 'actual_old_val'.
> >> +	 */
> >> +	ret = user_atomic_cmpxchg_inatomic(&actual_old_val, bd_entry,
> >> +					   expected_old_val, bt_addr);
> > 
> > This is fully preemptible non-atomic context, right?
> > 
> > So this wants a proper comment, why using
> > user_atomic_cmpxchg_inatomic() is the right thing to do here.
> 
> Hey Thomas,
> 
> How's this for a new comment?  Does this cover the points you think need
> clarified?
> 
> ====
> 
> The kernel has allocated a bounds table and needs to point the
> (userspace-allocated) directory to it.  The directory entry is the
> *only* place we track that this table was allocated, so we essentially
> use it instead of an kernel data structure for synchronization.  A
> copy_to_user()-style function would not give us the atomicity that we need.
> 
> If two threads race to instantiate a table, the cmpxchg ensures we know
> which one lost the race and that the loser frees the table that they
> just allocated.

Yup. That explains the cmpxchg.

The other thing which puzzled me was that it calls
user_atomic_cmpxchg_inatomic() but the context is not atomic at
all. Its fully preemptible and actually we want it to be able to
handle the fault. The implementation does that, just the function
itself suggest something different.
 
Thanks,

	tglx
