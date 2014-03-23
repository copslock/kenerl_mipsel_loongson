Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Mar 2014 03:16:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51248 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817179AbaCWCQ1VNIWO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Mar 2014 03:16:27 +0100
Date:   Sun, 23 Mar 2014 02:16:27 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        blogic@openwrt.org
Subject: Re: [PATCH 2/2] MIPS: fix DECStation build for L1_CACHE_SHIFT
 value
In-Reply-To: <1390327294-2618-2-git-send-email-florian@openwrt.org>
Message-ID: <alpine.LFD.2.10.1403230203410.21669@eddie.linux-mips.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org> <1390327294-2618-2-git-send-email-florian@openwrt.org>
User-Agent: Alpine 2.10 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39557
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

 Thanks for your contribution.  However I just built a pristine ToT LMO 
kernel for an R3000 DECstation and that went fine, I got no error.  Can 
you provide me with a way to reproduce the problem?

 I am not opposed to your change per se, it may make sense regardless. 
However using a value of MIPS_L1_CACHE_SHIFT that is too high results in 
wasting some memory, but should otherwise be safe I believe, so I'm not 
really convinced adding this config infrastructure is going to pay off.

  Maciej
