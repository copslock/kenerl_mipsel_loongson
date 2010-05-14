Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 06:48:18 +0200 (CEST)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:32826 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490976Ab0ENEsL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 06:48:11 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id 5954C1B4241;
        Fri, 14 May 2010 13:48:05 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Fri, 14 May 2010 13:48:05 +0900 (JST)
Date:   Fri, 14 May 2010 13:48:02 +0900 (JST)
Message-Id: <20100514.134802.232770462.anemo@mba.ocn.ne.jp>
To:     chris@mips.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Restore signalling NaN behaviour for abs.[sd]
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20100512013034.6493.20675.stgit@localhost.localdomain>
References: <20100512.004512.39157093.anemo@mba.ocn.ne.jp>
        <20100512013034.6493.20675.stgit@localhost.localdomain>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 11 May 2010 18:30:34 -0700, Chris Dearman <chris@mips.com> wrote:
> Atsushi Nemoto <anemo@mba.ocn.ne.jp> spotted that this had been
> incorrectly removed in a previous patch
> 
> Signed-off-by: Chris Dearman <chris@mips.com>

Thanks!

Tested-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
