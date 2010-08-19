Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Aug 2010 17:14:48 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:58998 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491060Ab0HSPOp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Aug 2010 17:14:45 +0200
Received: by qyk35 with SMTP id 35so3437407qyk.15
        for <multiple recipients>; Thu, 19 Aug 2010 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E3kMup3DJ2wSuuoW+7YEU9G8hBm2DOwJj4iEy18Dvaw=;
        b=b+UfviUF04ovJw/DcAzKyRc8rQJ1dH20aepKIkjMRV/rPDLwd7ZsyVDMA0C0qdVCfh
         0DwKauWA4cBVPdIIfMUSD9j5mUWW80QfTtNsVsh9HliaefHklEyWabPguUyrAM50Ilwf
         C/G8swBmnoXg2U78HOwRgUKN4mthSCuGxAxTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ib+3ji6e6RO6x5H+imjKfPqqCK+TgGo6k3HngaJpJsLkf4uUowTp3HKIt8OQHJFWs2
         ZMEZN3XGqvbl6TCnN1c0oeHTnDmVQ2Hoi92kVjzqsA+HrXF+fv2v3zZbcQgcOUiZSLDV
         6jz6ho0wxlFQJ33MEYFkVa8MNT9MDDmfzTisA=
MIME-Version: 1.0
Received: by 10.224.28.134 with SMTP id m6mr6616352qac.150.1282230877431; Thu,
 19 Aug 2010 08:14:37 -0700 (PDT)
Received: by 10.229.30.195 with HTTP; Thu, 19 Aug 2010 08:14:36 -0700 (PDT)
In-Reply-To: <20100817124246.GA14155@linux-mips.org>
References: <AANLkTi=bs4wJqG-3MeFJfr8sGC-s9PG_KksCY5TLo7ra@mail.gmail.com>
        <AANLkTikW2_NNj52goVm-h9yvHZb3e-TktmOY5jDHPpRe@mail.gmail.com>
        <20100817124246.GA14155@linux-mips.org>
Date:   Thu, 19 Aug 2010 23:14:36 +0800
Message-ID: <AANLkTimUCE47tMPtbR0KfxMaeFD=ac618_qGRW3kvHbp@mail.gmail.com>
Subject: Re: [Help] R3000 CPU porting, Oops while run app
From:   arrow zhang <arrow.ebd@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arrow.ebd@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arrow.ebd@gmail.com
Precedence: bulk
X-list: linux-mips

Dear ralf,

> Most systems define MIPS_CPU_IRQ_BASE as 0 so be careful that your
> set_irq_chip_and_handler loop doesn't overwrite any previous setup by
> mips_cpu_irq_init.  If your interrupt controller has 32 interrupts you
> probably want to assign interrupts 0..7 to the CPU interrupts and 8..39
> to the other controller.

thanks for the tips, I take a mistake that it could not be overwrite
Would like your help on my following question, thanks
1, I found that some CPU(e.g. ar7) does not request_irq on TC0_IRQ, do
not deal with the timer interrupt, and do not call function
do_timer(1).
2, But I must request a IRQ to deal with TC0_IRQ and call do_timer(1)
&& update_process_times, (this is porting from vendor released code)
3, How the AR7(or other MIPS SOC) deal with timer interrupt and update
the jiffies ?

thanks
Arrow
