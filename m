Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2010 17:45:28 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:35381 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491935Ab0EKPpV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 May 2010 17:45:21 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id A5E7956421D;
        Wed, 12 May 2010 00:45:15 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Wed, 12 May 2010 00:45:15 +0900 (JST)
Date:   Wed, 12 May 2010 00:45:12 +0900 (JST)
Message-Id: <20100512.004512.39157093.anemo@mba.ocn.ne.jp>
To:     chris@mips.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix abs.[sd] and neg.[sd] emulation for NaN operands
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4BE85256.9010709@mips.com>
References: <20091012215718.30362.67068.stgit@localhost.localdomain>
        <20100510.234946.229279777.anemo@mba.ocn.ne.jp>
        <4BE85256.9010709@mips.com>
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
X-archive-position: 26672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 10 May 2010 11:37:10 -0700, Chris Dearman <chris@mips.com> wrote:
> >>  	if (xc == IEEE754_CLASS_SNAN) {
> >> -		SETCX(IEEE754_INVALID_OPERATION);
> >> -		return ieee754dp_nanxcpt(ieee754dp_indef(), "neg");
> >> +		return ieee754dp_nanxcpt(ieee754dp_indef(), "abs");
> >>  	}
...
> ieee754dp/sp_nanxcpt also sets the invalid exception bit so I think this 
> is duplicated code. I think the same fix should have been applied to 
> ieee754sp_neg/ieee754dp_neg for consistency.

ieee754d/sp_nanxcpt will set the invalid exception bit if its first
argument was a signaling NaN.  And ieee754dp/sp_indef() is a quiet
NaN.

---
Atsushi Nemoto
