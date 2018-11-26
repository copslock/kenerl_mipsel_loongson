Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 19:02:11 +0100 (CET)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:57516 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992786AbeKZSAx4-Zgw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 19:00:53 +0100
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D8CC814E908FE;
        Mon, 26 Nov 2018 10:00:49 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:00:46 -0800 (PST)
Message-Id: <20181126.100046.860156356512347227.davem@davemloft.net>
To:     andrew.murray@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, will.deacon@arm.com,
        mark.rutland@arm.com, benh@kernel.crashing.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, linux-s390@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH v2 16/20] sparc: perf/core: advertise PMU exclusion
 capability
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1543230756-15319-17-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
        <1543230756-15319-17-git-send-email-andrew.murray@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 26 Nov 2018 10:00:50 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67511
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

From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:32 +0000

> The SPARC PMU has the capability to exclude events based on context
>  - let's advertise that we support the PERF_PMU_CAP_EXCLUDE
> capability to ensure that perf doesn't prevent us from handling
> events where any exclusion flags are set.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
