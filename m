Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 16:25:01 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:42428 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491043Ab0IIOY6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Sep 2010 16:24:58 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id E161F56421D;
        Thu,  9 Sep 2010 23:24:53 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Thu,  9 Sep 2010 23:24:53 +0900 (JST)
Date:   Thu, 09 Sep 2010 23:24:53 +0900 (JST)
Message-Id: <20100909.232453.31646362.anemo@mba.ocn.ne.jp>
To:     cernekee@gmail.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] MIPS: Move FIXADDR_TOP into spaces.h
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <55645e13fcf442f6641b3eb187cab302@localhost>
References: <55645e13fcf442f6641b3eb187cab302@localhost>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 27737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7330

On Tue, 7 Sep 2010 12:59:15 -0700, Kevin Cernekee <cernekee@gmail.com> wrote:
> Memory maps and addressing quirks are normally defined in <spaces.h>.
> There are already three targets that need to override FIXADDR_TOP, and
> others exist.  This will be a cleaner approach than adding lots of
> ifdefs in fixmap.h .

Looks OK for me.  Thanks.

---
Atsushi Nemoto
