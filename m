Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 14:35:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50596 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992361AbdKNNf0D88s0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 14:35:26 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEDZPb4013136;
        Tue, 14 Nov 2017 14:35:25 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEDZPZH013135;
        Tue, 14 Nov 2017 14:35:25 +0100
Date:   Tue, 14 Nov 2017 14:35:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     jiaxun.yang@flygoat.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] MIPS: Loongson64: Yeeloong add platform driver
 Yeeloong is a laptop with a MIPS Loongson 2F processor, AMD CS5536 chipset,
 and KB3310B controller.
Message-ID: <20171114133524.GE13046@linux-mips.org>
References: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
 <20171112063617.26546-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112063617.26546-3-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60917
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

On Sun, Nov 12, 2017 at 02:36:16PM +0800, jiaxun.yang@flygoat.com wrote:

> +     asm(".set noreorder\n");
> +     /*  input enable */
> +     outl(0x00000800, (gpio_base | 0xA0));
> +     /*  revert the input */
> +     outl(0x00000800, (gpio_base | 0xA4));
> +     /*  event-int enable */
> +     outl(0x00000800, (gpio_base | 0xB8));
> +     asm(".set reorder\n");

I forgot to comment on this .set noreorder thing.  GCC expects gas to be
in reorder mode at the end of every bit of inline assembler, so above
code is at the mercy of GCC.

Not sure what the intent was here, was it to avoid GCC from reordering
the outl() calls?  These are already marked volatlile and should not be
reordered by GCC.  .set (no)reorder on the other hand is a directive
to GAS and GCC won't be influenced at all by it.

Cheers,

  Ralf
