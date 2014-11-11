Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 19:27:50 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013265AbaKKS1t1nBIT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 19:27:49 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XoGAC-0003e5-Lx; Tue, 11 Nov 2014 19:27:36 +0100
Date:   Tue, 11 Nov 2014 19:27:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Qiaowei Ren <qiaowei.ren@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
In-Reply-To: <545BED0B.8000001@intel.com>
Message-ID: <alpine.DEB.2.11.1411111213450.3935@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241451280.5308@nanos> <545BED0B.8000001@intel.com>
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
X-archive-position: 44011
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

On Thu, 6 Nov 2014, Dave Hansen wrote:
> Instead of all of these games with dropping and reacquiring mmap_sem and
> adding other locks, or deferring the work, why don't we just do a
> get_user_pages()?  Something along the lines of:
> 
> while (1) {
> 	ret = cmpxchg(addr)
> 	if (!ret)
> 		break;
> 	if (ret == -EFAULT)
> 		get_user_pages(addr);
> }
> 
> Does anybody see a problem with that?

You want to do that under mmap_sem write held, right? Not a problem per
se, except that you block normal faults for a possibly long time when
the page(s) need to be swapped in.

But yes, this might solve most of the issues at hand. Did not think
about GUP at all :(

Thanks,

	tglx
