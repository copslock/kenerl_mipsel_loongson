Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 17:04:16 +0200 (CEST)
Received: from mogw1033.ocn.ad.jp ([153.149.231.39]:60939 "EHLO
        mogw1033.ocn.ad.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993041AbeIFPEMmmlCf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 17:04:12 +0200
Received: from mf-smf-ucb026c2 (mf-smf-ucb026c2.ocn.ad.jp [153.153.66.167])
        by mogw1033.ocn.ad.jp (Postfix) with ESMTP id 868F180023A;
        Fri,  7 Sep 2018 00:04:08 +0900 (JST)
Received: from ntt.pod01.mv-mta-ucb021 ([153.149.142.84])
        by mf-smf-ucb026c2 with ESMTP
        id xvpIfNQqaZVYwxvpIf38J0; Fri, 07 Sep 2018 00:04:08 +0900
Received: from smtp.ocn.ne.jp ([153.149.227.135])
        by ntt.pod01.mv-mta-ucb021 with 
        id YF481y0012vuoep01F489c; Thu, 06 Sep 2018 15:04:08 +0000
Received: from localhost (p935071-ipngn2102funabasi.chiba.ocn.ne.jp [180.56.175.71])
        by smtp.ocn.ne.jp (Postfix) with ESMTPA;
        Fri,  7 Sep 2018 00:04:08 +0900 (JST)
Date:   Fri, 07 Sep 2018 00:04:07 +0900 (JST)
Message-Id: <20180907.000407.1493498061297805737.anemo@mba.ocn.ne.jp>
To:     dingxiang@cmss.chinamobile.com
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: txx9: fix iounmap related issue
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1536207559-31543-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1536207559-31543-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66069
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

On Thu,  6 Sep 2018 12:19:19 +0800, Ding Xiang <dingxiang@cmss.chinamobile.com> wrote:
> if device_register return error, iounmap should be called, also iounmap
> need to call before put_device.
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  arch/mips/txx9/generic/setup.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thank you for fixing this long standing issue.  It looks OK for me.

Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
