Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 01:06:50 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007349AbbB0AGtPe0kf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 01:06:49 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38527B0C;
        Fri, 27 Feb 2015 00:06:42 +0000 (UTC)
Date:   Thu, 26 Feb 2015 16:06:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@kernel.org>,
        Hector Marco Gisbert <hecmargi@upv.es>,
        LKML <linux-kernel@vger.kernel.org>,
        ismael Ripoll <iripoll@upv.es>,
        "x86@kernel.org" <x86@kernel.org>,
        <"linux-arm-kernel@lists.infradead.org\" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linuxppc-dev@lists.ozlabs.org"@localhost.localdomain>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-Id: <20150226160641.547657c397ecfee078779217@linux-foundation.org>
In-Reply-To: <CAGXu5jK0YbyL+Z=YrCfkfGbYz6=65Rr_MAXLwrF36gJa2Ce4_w@mail.gmail.com>
References: <54EB735F.5030207@upv.es>
        <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
        <20150223205436.15133mg1kpyojyik@webmail.upv.es>
        <20150224073906.GA16422@gmail.com>
        <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
        <20150227102136.17ef1fe6@canb.auug.org.au>
        <20150226153435.df670671fb10eb9efa0fa845@linux-foundation.org>
        <CAGXu5jK0YbyL+Z=YrCfkfGbYz6=65Rr_MAXLwrF36gJa2Ce4_w@mail.gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46022
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

On Thu, 26 Feb 2015 15:37:37 -0800 Kees Cook <keescook@chromium.org> wrote:

> Agh, no, please let's avoid the CONFIG addition.

That is precisely how we do this.

> Hector mentioned in private mail that he was looking at an alternative
> that adds exec_base to struct mm which would avoid all this insanity.
> 
> Can't we do something like:
> 
> #ifndef mmap_rnd
> # define mmap_rnd 0
> #endif

Sure, and sprinkle

#define mmap_rnd mmap_rnd

in five arch header files where nobody thinks to look.

For better or for worse, we are consolidating such things into arch/*/Kconfig.
