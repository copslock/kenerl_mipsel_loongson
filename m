Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 02:25:11 +0100 (CET)
Received: from shards.monkeyblade.net ([149.20.54.216]:49442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825973Ab2KFBZJnDgXk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2012 02:25:09 +0100
Received: from localhost (cpe-74-66-230-70.nyc.res.rr.com [74.66.230.70])
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 83A725845C2;
        Mon,  5 Nov 2012 17:25:06 -0800 (PST)
Date:   Mon, 05 Nov 2012 20:25:01 -0500 (EST)
Message-Id: <20121105.202501.1246122770431623794.davem@davemloft.net>
To:     walken@google.com
Cc:     akpm@linux-foundation.org, riel@redhat.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
        ralf@linux-mips.org, lethal@linux-sh.org, cmetcalf@tilera.com,
        x86@kernel.org, wli@holomorphy.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32
 architecture
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1352155633-8648-16-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
        <1352155633-8648-16-git-send-email-walken@google.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 34897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Michel Lespinasse <walken@google.com>
Date: Mon,  5 Nov 2012 14:47:12 -0800

> Update the sparc32 arch_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
> 
> Signed-off-by: Michel Lespinasse <walken@google.com>

Hmmm...

> -	if (flags & MAP_SHARED)
> -		addr = COLOUR_ALIGN(addr);
> -	else
> -		addr = PAGE_ALIGN(addr);

What part of vm_unmapped_area() is going to duplicate this special
aligning logic we need on sparc?
