Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jun 2014 08:57:33 +0200 (CEST)
Received: from linux-libre.fsfla.org ([208.118.235.54]:48596 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816069AbaFAG5OMlVgx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Jun 2014 08:57:14 +0200
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s516v0kF001569;
        Sun, 1 Jun 2014 06:57:02 GMT
Received: from free.home (free.home [172.31.160.1])
        by freie.home (8.14.8/8.14.7) with ESMTP id s516u2HP023336;
        Sun, 1 Jun 2014 03:56:03 -0300
From:   Alexandre Oliva <oliva@gnu.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     "wuzhangjin" <wuzhangjin@gmail.com>,
        "linux-mips" <linux-mips@linux-mips.org>,
        "stable" <stable@vger.kernel.org>
Subject: Re: MIPS: Hibernate: Flush TLB entries in swsusp_arch_resume()
Organization: Free thinker, not speaking for the GNU Project
References: <tencent_03F1BF0862C094496B5D0360@qq.com>
Date:   Sun, 01 Jun 2014 03:55:55 -0300
In-Reply-To: <tencent_03F1BF0862C094496B5D0360@qq.com> (=?utf-8?B?IumZiA==?=
 =?utf-8?B?5Y2O5omNIidz?= message of
        "Sun, 1 Jun 2014 11:06:54 +0800")
Message-ID: <or61klqft0.fsf@free.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <oliva@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliva@gnu.org
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

Thanks for your response,

On Jun  1, 2014, "陈华才" <chenhc@lemote.com> wrote:

> The original code flush both TLB and cache, and I think the original author (Wu Zhangjin) has tested his code. In my patch I only restore the TLB flush, but not the cache flush. Since Loongson-3A maintain cache coherency by hardware, with or without cache flush will both OK. But for Loongson-2F, I guess cache flush is also needed, but I have no Yeelong-2F to test now.

I'm afraid reintroducing the cache flush is not enough to bring the
kernel back to a working state, hibernation wise.  The last oops message
I saw, after the ones that flew by, had __arch_local_irq_restore at the
top of the backtrace, called by some function with resume in its name.

Any other suggestions?


Here's the patch I tried on top of yours, as an alternative to reverting
it, unfortunately without success:

--- arch/mips/power/hibernate.S
+++ arch/mips/power/hibernate.S
@@ -43,6 +43,9 @@
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
+	/* flush caches to make sure context is in memory */
+	PTR_L t0, __flush_cache_all
+	jalr t0
 	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
