Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2014 02:06:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41133 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822105AbaDAAGUifcjU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2014 02:06:20 +0200
Date:   Tue, 1 Apr 2014 01:06:20 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
cc:     linux-mips@linux-mips.org, blogic@openwrt.org
Subject: Re: [PATCH 2/2] MIPS: fix DECStation build for L1_CACHE_SHIFT
 value
In-Reply-To: <1390327294-2618-2-git-send-email-florian@openwrt.org>
Message-ID: <alpine.LFD.2.11.1404010105130.27402@eddie.linux-mips.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org> <1390327294-2618-2-git-send-email-florian@openwrt.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 21 Jan 2014, Florian Fainelli wrote:

> When support for the DECStation is enabled, it will default to use a
> MIPS R3000 class processor. This will cause an intentional build failure
> to popup because MIPS_L1_CACHE_SHIFT and cpu_dcache_line_size()
> disagree. Fix this by selecting MIPS_L1_CACHE_SHIFT_2 when we build
> targetting a MIPS R3000 CPU to fix that build failure and satisfy all
> requirements.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 This actually boots -- Ralf, please apply.

  Maciej
