Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 21:37:08 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:50357 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011436AbaJ0UhG4QFpx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 21:37:06 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Xir26-0001ZH-R0; Mon, 27 Oct 2014 21:36:54 +0100
Date:   Mon, 27 Oct 2014 21:36:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Ren, Qiaowei" <qiaowei.ren@intel.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v9 09/12] x86, mpx: decode MPX instruction to get bound
 violation information
In-Reply-To: <9E0BE1322F2F2246BD820DA9FC397ADE0180ED16@shsmsx102.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.11.1410272135420.5308@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-10-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241408360.5308@nanos> <9E0BE1322F2F2246BD820DA9FC397ADE0180ED16@shsmsx102.ccr.corp.intel.com>
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
X-archive-position: 43604
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

On Mon, 27 Oct 2014, Ren, Qiaowei wrote:
> On 2014-10-24, Thomas Gleixner wrote:
> > On Sun, 12 Oct 2014, Qiaowei Ren wrote:
> > 
> >> This patch sets bound violation fields of siginfo struct in #BR
> >> exception handler by decoding the user instruction and constructing
> >> the faulting pointer.
> >> 
> >> This patch does't use the generic decoder, and implements a limited
> >> special-purpose decoder to decode MPX instructions, simply because
> >> the generic decoder is very heavyweight not just in terms of
> >> performance but in terms of interface -- because it has to.
> > 
> > My question still stands why using the existing decoder is an issue.
> > Performance is a complete non issue in case of a bounds violation and
> > the interface argument is just silly, really.
> > 
> 
> As hpa said, we only need to decode several mpx instructions
> including BNDCL/BNDCU, and general decoder looks like a little
> heavy. Peter, what do you think about it?

You're repeating yourself. Care to read the discussion about this from
the last round of review again?

Thanks,

	tglx
