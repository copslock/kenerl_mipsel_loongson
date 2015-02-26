Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 00:39:37 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007512AbbBZXjfaW1K0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 00:39:35 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38AD22C;
        Thu, 26 Feb 2015 23:39:29 +0000 (UTC)
Date:   Thu, 26 Feb 2015 15:39:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco Gisbert <hecmargi@upv.es>,
        LKML <linux-kernel@vger.kernel.org>,
        ismael Ripoll <iripoll@upv.es>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-Id: <20150226153928.1df44df8a0d885fa71c471ce@linux-foundation.org>
In-Reply-To: <CAGXu5jJ8UM5J58CpBwP=+kHi9td0mKP0SV36HjpckEjxCzm45g@mail.gmail.com>
References: <54EB735F.5030207@upv.es>
        <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
        <20150223205436.15133mg1kpyojyik@webmail.upv.es>
        <20150224073906.GA16422@gmail.com>
        <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
        <CAGXu5jJ8UM5J58CpBwP=+kHi9td0mKP0SV36HjpckEjxCzm45g@mail.gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Thu, 26 Feb 2015 15:34:36 -0800 Kees Cook <keescook@chromium.org> wrote:

> >> That pointless repetition should be avoided.
> >
> > That's surprisingly hard!
> >
> > After renaming mips brk_rnd() to mmap_rnd() I had a shot.  I'm not very
> > confident in the result.  Does that __weak trick even work?
> 
> In theory, it shouldn't be needed since only randomize_et_dyn will
> call mmap_rnd, and only architectures that use randomize_et_dyn will
> call it ... and will define mmap_rnd.

But randomize_et_dyn() is compiled for all architectures.  Or it was,
until I did the CONFIG_ARCH_HAVE_ELF_ASLR thing.

It seems odd that we have this per-arch feature but no Kconfig switch
for it.
