Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 18:32:14 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:4296 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039761AbWJXRcL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2006 18:32:11 +0100
Received: from localhost (p3068-ipad26funabasi.chiba.ocn.ne.jp [220.104.89.68])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1F3E9B6BC; Wed, 25 Oct 2006 02:32:03 +0900 (JST)
Date:	Wed, 25 Oct 2006 02:34:28 +0900 (JST)
Message-Id: <20061025.023428.45176894.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	creideiki+linux-mips@ferretporn.se, linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061024155045.GA28355@linux-mips.org>
	<6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
References: <20061024140614.GB27800@linux-mips.org>
	<6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
	<20061024155045.GA28355@linux-mips.org>
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
X-archive-position: 13092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 24 Oct 2006 16:50:45 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > 2. Timekeeping is broken. The clock in /proc/driver/rtc seems correct, but
> > the system clock advances at about 1/16 of real time.
> 
> This one was caused by changeset ebca9aafa9bd5086d9f310205a8e30e225c5a5a6
> which apparently wasn't quite ripe.  You can work around it by
> revoking this changeset for now.  The time damage affects other systems
> as well ...

Now I'm looking my patch again but still can not find any problem...

One question:

>    # zcat /proc/config.gz | grep HZ | grep -v ^#
>    CONFIG_HZ_250=y
>    CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
>    CONFIG_HZ=250

IP27 really supports HZ=250 ?

---
Atsushi Nemoto
