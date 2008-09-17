Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2008 16:12:05 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:11976 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20245563AbYIQPMA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2008 16:12:00 +0100
Received: from localhost (p3101-ipad302funabasi.chiba.ocn.ne.jp [123.217.141.101])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CF4B8B9BA; Thu, 18 Sep 2008 00:11:53 +0900 (JST)
Date:	Thu, 18 Sep 2008 00:12:10 +0900 (JST)
Message-Id: <20080918.001210.51866849.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48D02C3C.90705@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48D02C3C.90705@ru.mvista.com>
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
X-archive-position: 20519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 17 Sep 2008 01:59:24 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +		unsigned int *table = hwif->dmatable_cpu;
> >   
> 
>    s/unsigned int/__le32/ perhaps?

Yes.  And __le64 would be much better.

> > +		while (1) {
> > +			cpu_to_le64s((u64 *)table);
> >   
> 
>    Wait, PRD is already already in LE format, so this should be 
> le64_to_cpus().

OK.

> > +			if (*table & 0x80000000)
> >   
> 
>    Hum... you don't have to check that with ide_build_dmatable() 
> returning the PRD count...

Indeed.  I'll do it.  Thanks.
