Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2012 12:48:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49706 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1902756Ab2HOKsO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Aug 2012 12:48:14 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7FAmD6b005462;
        Wed, 15 Aug 2012 12:48:13 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7FAmC14005460;
        Wed, 15 Aug 2012 12:48:12 +0200
Date:   Wed, 15 Aug 2012 12:48:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ath79: don't hardcode the unavailability of the
 DSP ASE
Message-ID: <20120815104812.GB4035@linux-mips.org>
References: <1344971541-22465-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344971541-22465-1-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34177
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
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15580

On Tue, Aug 14, 2012 at 09:12:21PM +0200, Gabor Juhos wrote:

> The ath79 platform code allows to run a single kernel image
> on various SoCs which are based on the 24Kc and 74Kc cores.
> The current code explicitely disables the DSP ASE, but that
> is available in the 74Kc core.
> 
> Remove the override in order to let the kernel to detect the
> availability of the DSP ASE at runtime.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> 
> ---
> This is a replacement of the 'MIPS: ath79: don't override CPU ASE features' 
> patch: https://patchwork.linux-mips.org/patch/4169/
> 
> I don't think that the issue is critical enough to include that in 
> the stable trees.

But it's also trivial.  Anyway, the effect of this "bug" is that the DSP
ASE is not available and apparently this has not yet shown up on anybody's
radar.

Anyway, applied!  Thanks!

  Ralf
