Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 16:05:55 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52431 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039488AbXBGQFu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2007 16:05:50 +0000
Received: from localhost (p4022-ipad202funabasi.chiba.ocn.ne.jp [222.146.75.22])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 95BAF8DD1; Thu,  8 Feb 2007 01:04:30 +0900 (JST)
Date:	Thu, 08 Feb 2007 01:04:30 +0900 (JST)
Message-Id: <20070208.010430.58789357.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/10] Clean up signal code [take #3]
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon,  5 Feb 2007 15:24:18 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Here is the third version of this patchset.
> I ran (on a 32-bits kernel _only_) all LTP signal testcases and
> they all passed. I haven't time to look at what these tests exactly
> do though. 

Thank you for good job.  All looks good for me.
# Though [PATCH 6/10] failed due to recent whitespace cleanup ...

I hope this patchset applied before updating my fp_context patches.
---
Atsushi Nemoto
