Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 14:26:16 +0100 (CET)
Received: from mogw0933.ocn.ad.jp ([153.149.227.39]:51456 "EHLO
        mogw0933.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993397AbcLGN0I5KiHJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 14:26:08 +0100
Received: from mf-smf-ucb009.ocn.ad.jp (mf-smf-ucb009.ocn.ad.jp [153.149.227.69])
        by mogw0933.ocn.ad.jp (Postfix) with ESMTP id 4AAAA60046E;
        Wed,  7 Dec 2016 22:26:03 +0900 (JST)
Received: from mf-smf-ucb009.ocn.ad.jp (mf-smf-ucb009 [153.149.227.69])
        by mf-smf-ucb009.ocn.ad.jp (Postfix) with ESMTP id 2F03E10069E;
        Wed,  7 Dec 2016 22:26:03 +0900 (JST)
Received: from ntt.pod01.mv-mta-ucb021 (mv-mta-ucb021.ocn.ad.jp [153.149.142.84])
        by mf-smf-ucb009.ocn.ad.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id uB7DPn6f057585;
        Wed, 7 Dec 2016 22:26:02 +0900
Received: from smtp.ocn.ne.jp ([153.149.227.134])
        by ntt.pod01.mv-mta-ucb021 with 
        id H1S21u0042ud8JZ011S2Zl; Wed, 07 Dec 2016 13:26:02 +0000
Received: from localhost (p6128-ipngn4301funabasi.chiba.ocn.ne.jp [114.165.169.128])
        by smtp.ocn.ne.jp (Postfix) with ESMTPA;
        Wed,  7 Dec 2016 22:26:02 +0900 (JST)
Date:   Wed, 07 Dec 2016 22:25:54 +0900 (JST)
Message-Id: <20161207.222554.1493938728868200986.anemo@mba.ocn.ne.jp>
To:     geert@linux-m68k.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: TXx9: Modernize printing of kernel messages
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1481101515-13319-1-git-send-email-geert@linux-m68k.org>
References: <1481101515-13319-1-git-send-email-geert@linux-m68k.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.5 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
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

On Wed,  7 Dec 2016 10:05:15 +0100, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>   - Convert from printk() to pr_*(),
>   - Add missing continuations, to fix user-visible breakage,
>   - Drop superfluous casts (u64 has been unsigned long long on all
>     architectures for many years).

Thank you.  Good catch.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
