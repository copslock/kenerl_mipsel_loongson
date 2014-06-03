Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 10:30:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43978 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854763AbaFCIakKVIHz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jun 2014 10:30:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s538UYga021746;
        Tue, 3 Jun 2014 10:30:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s538UVKQ021745;
        Tue, 3 Jun 2014 10:30:31 +0200
Date:   Tue, 3 Jun 2014 10:30:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 09/13] MIPS: Add functions for hypervisor call
Message-ID: <20140603083031.GP17197@linux-mips.org>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1401313936-11867-10-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401313936-11867-10-git-send-email-andreas.herrmann@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, May 28, 2014 at 11:52:12PM +0200, Andreas Herrmann wrote:

> +/*
> + * Hypercalls for KVM.
> + *
> + * Hypercall number is passed in v0.
> + * Return value will be placed in v0.
> + * Up to 3 arguments are passed in a0, a1, and a2.
> + */
> +static inline unsigned long kvm_hypercall0(unsigned long num)
> +{
> +	register unsigned long n asm("v0");
> +	register unsigned long r asm("v0");

Btw, is it safe to put two variables in the same register?

The syscall wrappers that used to be in <asm/unistd.h> were occasionally
hitting problems which eventually forced me to stop forcing variables
into particular registers instead using a MOVE instruction to shove
each variable into the right place.

Of course they were being used from non-PIC and PIC code, kernel and userland
so GCC had a much better chance to do evil than in the hypercall wrapper
case - but it made me paranoid ...

  Ralf
