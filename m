Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 17:05:54 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:58109 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038432AbWLARFs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 17:05:48 +0000
Received: from localhost (p7250-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.250])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E7C6CC3E2; Sat,  2 Dec 2006 02:05:44 +0900 (JST)
Date:	Sat, 02 Dec 2006 02:05:44 +0900 (JST)
Message-Id: <20061202.020544.89039198.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Compile __do_IRQ() when really needed
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80612010847g30213daau80c636b9dfc7dce3@mail.gmail.com>
References: <457042FF.2060908@innova-card.com>
	<20061202.004527.52131670.anemo@mba.ocn.ne.jp>
	<cda58cb80612010847g30213daau80c636b9dfc7dce3@mail.gmail.com>
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
X-archive-position: 13313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 1 Dec 2006 17:47:29 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > @@ -468,6 +473,7 @@ config DDB5477
> > >  config MACH_VR41XX
> > >       bool "NEC VR41XX-based machines"
> > >       select SYS_HAS_CPU_VR41XX
> > > +     select GENERIC_HARDIRQS_NO__DO_IRQ
> > >
> > >  config PMC_YOSEMITE
> > >       bool "PMC-Sierra Yosemite eval board"
> >
> > Same here.
> >
> 
> are you sure ? I don't see any traces of i8259 selection.
> Moreover, Yoichi's vr41xx boards seem to have no problem

Oh I was wrong.  I had misread VR41XX as DDB5477...

---
Atsushi Nemoto
