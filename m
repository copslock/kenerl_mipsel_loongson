Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2013 07:24:56 +0200 (CEST)
Received: from mo10.iij4u.or.jp ([210.138.174.78]:36230 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3JAFYws4gse (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Oct 2013 07:24:52 +0200
Received: by mo.iij4u.or.jp (mo10) id r915OenB023394; Tue, 1 Oct 2013 14:24:40 +0900
Received: from delta (sannin29190.nirai.ne.jp [203.160.29.190])
        by mbox.iij4u.or.jp (mbox10) id r915OM8s024418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 1 Oct 2013 14:24:39 +0900
Date:   Tue, 1 Oct 2013 14:24:21 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     yuasa@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 3.12-rc2 - MIPS regression
Message-Id: <20131001142421.6cd0870138caf2fe5600a1ea@linux-mips.org>
In-Reply-To: <20130927231012.GB4572@blackmetal.musicnaut.iki.fi>
References: <CA+55aFxoF75RJfkp0vnm-b9B0h7PGMitrQiLyTt315tKvG-wTQ@mail.gmail.com>
        <20130927231012.GB4572@blackmetal.musicnaut.iki.fi>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

Hi,

On Sat, 28 Sep 2013 02:10:12 +0300
Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Hi,
> 
> 3.12-rc2 breaks the boot (BUG: scheduling while atomic, see logs below)
> on Lemote Mini-PC (MIPS). According to git bisect, this is caused by:
> 
> ff522058bd717506b2fa066fa564657f2b86477e is the first bad commit
> commit ff522058bd717506b2fa066fa564657f2b86477e
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Tue Sep 17 12:44:31 2013 +0200
> 
>     MIPS: Fix accessing to per-cpu data when flushing the cache
> 
> Reverting the commit from v3.12-rc2 makes the board boot fine.

Please try this patch on top of rc2.

MIPS: Fix forgotten preempt_enable() when CPU has inclusive pcaches

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 627883b..2492e60 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -609,6 +609,7 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 			r4k_blast_scache();
 		else
 			blast_scache_range(addr, addr + size);
+		preempt_enable();
 		__sync();
 		return;
 	}
