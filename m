Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2017 16:38:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8812 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992111AbdBWPh7nUBuR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2017 16:37:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CA09BCDA80E33;
        Thu, 23 Feb 2017 15:37:50 +0000 (GMT)
Received: from [10.20.78.214] (10.20.78.214) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 23 Feb 2017
 15:37:52 +0000
Date:   Thu, 23 Feb 2017 15:37:39 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: End spinlocks with .insn
In-Reply-To: <dea55f438343246636ca4b033cd8cdfef5f45b0d.1487861280.git-series.james.hogan@imgtec.com>
Message-ID: <alpine.DEB.2.00.1702231536580.26999@tp.orcam.me.uk>
References: <dea55f438343246636ca4b033cd8cdfef5f45b0d.1487861280.git-series.james.hogan@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.214]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 23 Feb 2017, James Hogan wrote:

> ---
>  arch/mips/include/asm/spinlock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

  Maciej
