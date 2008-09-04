Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2008 15:41:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:40924 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S32721242AbYIDOlV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Sep 2008 15:41:21 +0100
Received: from localhost (p7114-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.114])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C1515AFC7; Thu,  4 Sep 2008 23:41:13 +0900 (JST)
Date:	Thu, 04 Sep 2008 23:41:14 +0900 (JST)
Message-Id: <20080904.234114.07644635.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 4/6] TXx9: Add TX4939 SoC support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48BF0243.30801@ru.mvista.com>
References: <48BE6137.1090008@ru.mvista.com>
	<20080904.010229.108120775.anemo@mba.ocn.ne.jp>
	<48BF0243.30801@ru.mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 04 Sep 2008 01:31:47 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > It seems the drivers/ide in in deep
> > cleanup/refactoring state.  (linux-next contains 100 patches from
> > Bartlomiej!)
> >
> > Do you think a new ide driver will be accepted?
> 
>    Of course it will. But due to much of refactoring that's been 
> happening it will require some work to move it forward from the older 
> version (I guess you have it as well): IDE drivers should now be pretty 
> close to the libata ones functionally.

I have a driver for current mainline and it is based on the driver in
CELF patch archive.  I will try to update the driver against
linux-next tree.

---
Atsushi Nemoto
