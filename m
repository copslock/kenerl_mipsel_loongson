Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 10:25:26 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:19871 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225526AbUGHJZV>;
	Thu, 8 Jul 2004 10:25:21 +0100
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i689PFXK028049
	for <linux-mips@linux-mips.org>; Thu, 8 Jul 2004 11:25:15 +0200 (MEST)
X-Received: from dolphin.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i689M4XJ027801
	for <Geert.Uytterhoeven@sonycom.com>;
	Thu, 8 Jul 2004 11:22:04 +0200 (MEST)
X-Received: from ns1.nerdnet.nl ([217.170.15.1] helo=nerdnet.nl ident=root)
	by dolphin.sonytel.be with esmtp (Exim 4.34) id 1BiV6S-0002PF-AM
	for Geert.Uytterhoeven@sonycom.com; Thu, 08 Jul 2004 11:22:04 +0200
X-Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by nerdnet.nl (8.12.11/8.12.11/Debian-5) with SMTP id i689M2NV001813
	for <geert@linux-m68k.org>; Thu, 8 Jul 2004 11:22:03 +0200
X-Received: by mproxy.gmail.com with SMTP id d5so184491rng
	for <geert@linux-m68k.org>; Thu, 08 Jul 2004 02:22:00 -0700 (PDT)
X-Received: by 10.38.9.68 with SMTP id 68mr172039rni;
	Thu, 08 Jul 2004 02:21:59 -0700 (PDT)
Message-ID: <f013fac6040708022160bbe790@mail.gmail.com>
Date: Thu, 8 Jul 2004 14:51:59 +0530
From: Sridhar Adagada <asridhars@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Optimisation
In-Reply-To: <Pine.GSO.4.58.0407081053500.12221@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f013fac60407072338b65f8fd@mail.gmail.com>
	<Pine.GSO.4.58.0407081053500.12221@waterleaf.sonytel.be>
X-Virus-Scanned: clamd / ClamAV version 0.73, clamav-milter version 0.73a
	on nerdnet.nl
X-Virus-Status: Clean
X-Spambayes-Classification: ham; 0.00
ReSent-Date: Thu, 8 Jul 2004 11:25:13 +0200 (MEST)
ReSent-From: Geert Uytterhoeven <geert@sonycom.com>
ReSent-To: Linux/MIPS Development <linux-mips@linux-mips.org>
ReSent-Subject: Re: Optimisation
ReSent-Message-ID: <Pine.GSO.4.58.0407081125130.12221@waterleaf.sonytel.be>
Return-Path: <geert@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@sonycom.com
Precedence: bulk
X-list: linux-mips

Thank you.  For some reason i have been reading ANDI ans ADDI.  But i
am still confused at lines 13, 14 and 15
  13         imax    $8, $6, 0
  14         srl     $10, $8, 3
  15         beq     $10, $0, .L62

Thanks for correcting me

Sri


On Thu, 8 Jul 2004 10:59:58 +0200 (MEST), Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, 8 Jul 2004, Sridhar Adagada wrote:
> > As you can see $6 is the length, my confusion is at the lines 12-14,
> > 19, 20 why is the length added with 65535 and the comparison with 0
> 
> It's not `added with 65535', but `ANDed with 65535'. MIPS32 has 32-bit integer
> operations only. If you want to do 16-bit math, all data has to be masked.
> 
> Anyway, for performance, it's better to do 32-bit math only.
> 
> > short cal_xxx(short *abs, short *coef, short len, short base)
> > {
> >  short i;
> >  short sum = 0;
> >
> >  for (i = 0; i < length; i++)
> >  {
> >    sum += ( (unsigned int)abs[i] * (unsigned int)coef[i] );
> 
> Why cast to unsigned int while sum is a short? Unless you really want to rely
> on sum being a short, you better make it int and do the truncation to short
> after the loop.
> 
> Gr{oetje,eeting}s,
> 
>                                                Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                            -- Linus Torvalds
>
