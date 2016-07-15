Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2016 16:19:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57670 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993004AbcGOOThTQlOF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jul 2016 16:19:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u6FEJXpX000965;
        Fri, 15 Jul 2016 16:19:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u6FEJXiA000964;
        Fri, 15 Jul 2016 16:19:33 +0200
Date:   Fri, 15 Jul 2016 16:19:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 01/12] MIPS: Fix definition of KSEGX() for 64-bit
Message-ID: <20160715141932.GD1024@linux-mips.org>
References: <1467975211-12674-2-git-send-email-james.hogan@imgtec.com>
 <1468268620-8600-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468268620-8600-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54338
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

On Mon, Jul 11, 2016 at 09:23:40PM +0100, James Hogan wrote:

> The KSEGX() macro is defined to 32-bit sign extend the address argument
> and logically AND the result with 0xe0000000, with the final result
> usually compared against one of the CKSEG macros. However the literal
> 0xe0000000 is unsigned as the high bit is set, and is therefore
> zero-extended on 64-bit kernels, resulting in the sign extension bits of
> the argument being masked to zero. This results in the odd situation
> where:
> 
>   KSEGX(CKSEG0) != CKSEG0
>   (0xffffffff80000000 & 0x00000000e0000000) != 0xffffffff80000000)
> 
> Fix this by 32-bit sign extending the 0xe0000000 literal using
> _ACAST32_.
> 
> This will help some MIPS KVM code handling 32-bit guest addresses to
> work on 64-bit host kernels, but will also affect a couple of other
> users:
> 
> - KSEGX in dec_kn01_be_backend() on a 64-bit DECstation kernel. Maciej
>   has confirmed this is not a valid combination.
> 
> - The SiByte DMA page ops KSEGX check in clear_page() and copy_page() on
>   64-bit SB1 kernels, which appears not to be designed with 64-bit
>   segments in mind anyway. This would (perhaps unintentionally) have
>   always fallen back to the CPU copy on 64-bit kernels anyway, so we
>   make this explicit by making CONFIG_SIBYTE_DMA_PAGEOPS depend on
>   32BIT, so the change of KSEGX behaviour can't break anything.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
