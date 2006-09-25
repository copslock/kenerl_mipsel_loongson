Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 16:41:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:62659 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038551AbWIYPlc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Sep 2006 16:41:32 +0100
Received: from localhost (p6082-ipad03funabasi.chiba.ocn.ne.jp [219.160.86.82])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C014AC1C8; Tue, 26 Sep 2006 00:41:27 +0900 (JST)
Date:	Tue, 26 Sep 2006 00:43:18 +0900 (JST)
Message-Id: <20060926.004318.68160600.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <C13E1C13.6FDC%girishvg@gmail.com>
References: <20060925.002616.126574366.anemo@mba.ocn.ne.jp>
	<C13E1C13.6FDC%girishvg@gmail.com>
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
X-archive-position: 12658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 25 Sep 2006 23:51:46 +0900, girish <girishvg@gmail.com> wrote:
> Here is the patch again, attached as a text file. I don't have idea how
> these macros should be on a 64bit machine, so I just left them as it is.
> Could you please verify these macros again?

Well, I should ask first: Why do you change __pa() and __va() ?

I can not see point of ISMAPPED() testing.  And these macros are used
quite often so they should be as fast as possible.

---
Atsushi Nemoto
