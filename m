Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 12:15:05 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34603 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010972AbbG1KPEImNhL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jul 2015 12:15:04 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6SAF3Or024455;
        Tue, 28 Jul 2015 12:15:03 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6SAF2dw024446;
        Tue, 28 Jul 2015 12:15:02 +0200
Date:   Tue, 28 Jul 2015 12:15:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Felix Fietkau <nbd@openwrt.org>
Cc:     linux-mips@linux-mips.org, abrestic@chromium.org
Subject: Re: [PATCH] MIPS: export get_c0_perfcount_int()
Message-ID: <20150728101502.GA24049@linux-mips.org>
References: <1437670792-6755-1-git-send-email-nbd@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437670792-6755-1-git-send-email-nbd@openwrt.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48482
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

On Thu, Jul 23, 2015 at 06:59:52PM +0200, Felix Fietkau wrote:
> Date:   Thu, 23 Jul 2015 18:59:52 +0200
> From: Felix Fietkau <nbd@openwrt.org>
> To: linux-mips@linux-mips.org
> Cc: abrestic@chromium.org, ralf@linux-mips.org
> Subject: [PATCH] MIPS: export get_c0_perfcount_int()
> 
> get_c0_perfcount_int is tested from oprofile code. If oprofile is
> compiled as module, get_c0_perfcount_int needs to be exported, otherwise
> it cannot be resolved.
> 
> Fixes: a669efc4a3b4 ("MIPS: Add hook to get C0 performance counter interrupt")
> Cc: stable@vger.kernel.org # v3.19+

You didn't actually cc this email to stable@vger.kernel.org.

> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> ---
>  arch/mips/ath79/setup.c          | 1 +
>  arch/mips/lantiq/irq.c           | 1 +
>  arch/mips/mti-malta/malta-time.c | 1 +
>  arch/mips/mti-sead3/sead3-time.c | 1 +
>  arch/mips/pistachio/time.c       | 1 +

Pistachio was merged for 4.1 so this patch won't apply to older kernels.
You may also want to submit a separate version for those -stable kernels.

Applied.

  Ralf
