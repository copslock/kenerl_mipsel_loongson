Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Nov 2009 12:50:26 +0100 (CET)
Received: from mba.ocn.ne.jp ([122.28.14.163]:61378 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492229AbZKHLuT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Nov 2009 12:50:19 +0100
Received: from localhost (p5082-ipad205funabasi.chiba.ocn.ne.jp [222.146.100.82])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AD6DD6968; Sun,  8 Nov 2009 20:50:07 +0900 (JST)
Date:	Sun, 08 Nov 2009 20:50:07 +0900 (JST)
Message-Id: <20091108.205007.59470244.anemo@mba.ocn.ne.jp>
To:	dmitri.vorobiev@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Make local arrays with CL_SIZE static __initdata
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <90edad820911071016v70e6e68bia8f0c3b6f09ceb3c@mail.gmail.com>
References: <1257614437-8632-1-git-send-email-anemo@mba.ocn.ne.jp>
	<90edad820911071016v70e6e68bia8f0c3b6f09ceb3c@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 7 Nov 2009 20:16:57 +0200, Dmitri Vorobiev <dmitri.vorobiev@gmail.com> wrote:
> > --- a/arch/mips/bcm47xx/prom.c
> > +++ b/arch/mips/bcm47xx/prom.c
> > @@ -100,7 +100,7 @@ static __init void prom_init_console(void)
> >
> >  static __init void prom_init_cmdline(void)
> >  {
> > -       char buf[CL_SIZE];
> > +       static char buf[CL_SIZE] __initdata;
> 
> If this is intended for -queue, this patch won't apply, because
> CL_SIZE was recently removed in favor of using CONFIG_CMDLINE_SIZE
> directly.

Oh I missed your CL_SIZE removal patch.  Anyway I want this patch for
2.6.32 since this is regression.

If the CL_SIZE removal patch was merged for 2.6.32 first, I will
update my patch.  Othersize, your patch needs update, but I suppose we
can do it easily.  Of course Ralf can do it too ;)

---
Atsushi Nemoto
