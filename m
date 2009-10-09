Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 17:46:12 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:58861 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493015AbZJIPqF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 17:46:05 +0200
Received: by bwz4 with SMTP id 4so1694316bwz.0
        for <multiple recipients>; Fri, 09 Oct 2009 08:45:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=dg3rv1gfLfbXliBulB7MZWIp0QdmSIzVUN/LtODUZak=;
        b=Efvuyseqf500H8qdJTJm1tj3SvW+PCxKG+BtZqU5m/YY/STwEv47bnDSgCwbBqyxts
         urJmRZtgwRupSkeeaLSOy4n7KQ0num7OdepHtQ/LHuttge6vPk2hpk556Uhv7ApONq/E
         7Rl7g6Aj4ztDkLZ1h04+6bKKsQ6OcMp0nSz34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=rSXfLwXY+BM7DktltWZ6RllhFUMMFZ7gb2jkZpBtyjM6BH1Mzjl33r5Z6w+O3fWB1+
         j21+xcOgExNkYf846J8BPPs/mdyj2XEH07Vu/q8YtVgtfPmYUFFPI1IOD3I2gNUi7BYU
         nxDfY+ay0ooWMPZw2NWr/SjOIj1dKj0dQsI0g=
Received: by 10.103.126.27 with SMTP id d27mr1190792mun.56.1255103159331;
        Fri, 09 Oct 2009 08:45:59 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id g1sm387580muf.5.2009.10.09.08.45.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:45:57 -0700 (PDT)
Subject: Re: [PATCH] MIPS: add IRQF_TIMER flag for Timer Interrupts
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-pm@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	ralf@linux-mips.org, rjw@sisk.pl, yuasa@linux-mips.org
In-Reply-To: <20091010.001754.229727131.anemo@mba.ocn.ne.jp>
References: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
	 <20091010.001754.229727131.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 09 Oct 2009 23:45:49 +0800
Message-Id: <1255103149.3658.112.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-10-10 at 00:17 +0900, Atsushi Nemoto wrote:
> On Thu,  8 Oct 2009 21:17:54 +0800, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
> > which will help to not disable the Timer IRQ when suspending to ensure
> > resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
> > thread them when enabled PREEMPT_RT.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  arch/mips/jazz/irq.c                |    2 +-
> >  arch/mips/kernel/cevt-gt641xx.c     |    2 +-
> >  arch/mips/kernel/cevt-r4k.c         |    2 +-
> >  arch/mips/kernel/i8253.c            |    2 +-
> >  arch/mips/nxp/pnx8550/common/time.c |    2 +-
> >  arch/mips/sgi-ip27/ip27-timer.c     |    2 +-
> >  arch/mips/sni/time.c                |    2 +-
> >  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> Maybe cevt-bcm1480.c, cevt-ds1287.c, cevt-sb1250.c, cevt-txx9.c and
> i8253.c need same fix?
> 

I got them via "grep timer -ur arch/mips | grep name", so, perhaps there
are also some other timer interrupts missing here.

just get more via "grep Timer -ur arch/mips | grep name", "grep IRQF_
-ur arch/mips/ | grep -v TIMER | grep =", a new patch will be sent out
in the next E-mail.

Regards,
	Wu Zhangjin
