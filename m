Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 09:34:55 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990519AbdDFHeoPE55T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 09:34:44 +0200
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B0DB87A;
        Thu,  6 Apr 2017 07:34:37 +0000 (UTC)
Date:   Thu, 6 Apr 2017 09:34:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 for-4.9 04/32] MIPS: Lantiq: Fix cascaded IRQ setup
Message-ID: <20170406073426.GG14752@kroah.com>
References: <1491388344-13521-1-git-send-email-amit.pundir@linaro.org>
 <1491388344-13521-5-git-send-email-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491388344-13521-5-git-send-email-amit.pundir@linaro.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Wed, Apr 05, 2017 at 04:01:56PM +0530, Amit Pundir wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> With the IRQ stack changes integrated, the XRX200 devices started
> emitting a constant stream of kernel messages like this:
> 
> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
> 
> This is caused by IP0 getting handled by plat_irq_dispatch() rather than
> its vectored interrupt handler, which is fixed by commit de856416e714
> ("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").
> 
> Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
> by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
> for all MIPS CPU interrupts.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Acked-by: John Crispin <john@phrozen.org>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/15077/
> [james.hogan@imgtec.com: tweaked commit message]
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> 
> (cherry picked from commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd)
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  arch/mips/lantiq/irq.c | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)

Also works for 4.4 and 4.10-stable...

greg k-h
