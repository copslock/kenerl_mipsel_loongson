Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Aug 2010 08:55:08 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:39592 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490999Ab0H2GzE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Aug 2010 08:55:04 +0200
Received: by pvg12 with SMTP id 12so2006498pvg.36
        for <linux-mips@linux-mips.org>; Sat, 28 Aug 2010 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=df3u72Q3Op4tG4EGSwz9BYebI9o4TP8zLg9Krj8hYwI=;
        b=SzDtKL4VXrVdoztyScizUcgjHueb0evZdJ3WH1h3TTG9OofWm72DRJN7c6LaG8cUig
         VpZSkgGej0QlIVu80nKr3tCxpp/tcUwwd8YOxaLeAKwnqAHYGtqMskCp8Z/suIWW9b/o
         Lr3KNQQyGNBFnWLzNmjFhUr7TbqlLnl4q9T34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pFoCtwvq3rWe++GSiuqcIHGZpbeZ9IiaNlVn7WTk3iUYkKMT6zelr81G7vjFf/9t2v
         SnO/2XP20PIIE/zsTvyrzxrF2LeYlIrONsUDi2arGZTjUQg+BvBK7jAkV1K7E4jIecz4
         8DwsKf389A2SDZum5hlrJukvEr9LVsyJQffcA=
Received: by 10.114.204.7 with SMTP id b7mr3182754wag.124.1283064898496;
        Sat, 28 Aug 2010 23:54:58 -0700 (PDT)
Received: from localhost (KD118154228076.ppp-bb.dion.ne.jp [118.154.228.76])
        by mx.google.com with ESMTPS id s5sm10989995wak.0.2010.08.28.23.54.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 23:54:57 -0700 (PDT)
Date:   Sun, 29 Aug 2010 15:57:40 +0900
From:   Adam Jiang <jiang.adam@gmail.com>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: How is interrupt handling on MIPS SMP?
Message-ID: <20100829065740.GA6600@capricorn-x61>
References: <20100828071842.GB6957@capricorn-x61>
 <AANLkTimDt2pPxaiKP0WUyYgg3xmYSVsc8Cp2neNET_TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimDt2pPxaiKP0WUyYgg3xmYSVsc8Cp2neNET_TA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

> Hi, Adam
> 
> On 8/28/10, Adam Jiang <jiang.adam@gmail.com> wrote:
> > How dose interrupt be handled on SMP build on MIPS architecture? Does
> > mips-linux support SMP?
> >
> 
> $ grep SYS_SUPPORTS_SMP -ur arch/mips/Kconfig | egrep -v "config|depend" | wc -l
> 6
> 
> You can get more information from the book "See MIPS Run Linux" version 2.

Thank you, Wu. I'd like to read the book ASAP.

I have gotten a general image how multi-APIC system distribute IRQs to
each CPU on x86 architecture. For misp, is there a mechanism to do the
same thing?

Another question is about the comments in file

arch/mips/kernel/irq_cpu.c

it is said "8 interrupt sources" things could not be applied to SMP.
What dose this mean? How is MIPS CPU interrupts handled? Could I get a
general information from MIPS programmer manual?

Best regards,
/Adam

> 
> Regards,
> Wu Zhangjin
> 
