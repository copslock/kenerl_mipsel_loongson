Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2010 05:49:36 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:39742 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491821Ab0HQDtd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Aug 2010 05:49:33 +0200
Received: by qwe4 with SMTP id 4so6244738qwe.36
        for <linux-mips@linux-mips.org>; Mon, 16 Aug 2010 20:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=in5MaGubMXJomI4DnHKVH0Lu8HS19IshMALNimpb0e8=;
        b=r2Tx5L+Tw1wPkfX0gqDHblj9HkU2oPFq11e4j5IQFdfdKeLFBPF02m7aAyzBZqVfwP
         xuhVaYVEbt04SgrUu2d12dBIxeLP94MnhefjAOF1sLz69x2DTHOHM+gl6AipJzO56Phj
         6Vztpsu0I8dO0z1wbZwM7plWKYMHYHa9N+hvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=aSbWuqrUdzXMSocGScZULi3BaFE9FL9B1dAlropkOnvFPUQMP/Za1csFv4kpIE7MKw
         82pC4xlcfSoVAfspnmU2caI/xYHGjnVcBpmCQ73QPzPY9F6vqnvj3Oj9XYhWmjuWR6Q2
         3WMUA1Zj8Y4/LYp8YeYTVKbyKa/4S/H14DctA=
MIME-Version: 1.0
Received: by 10.229.239.3 with SMTP id ku3mr4324812qcb.129.1282016967275; Mon,
 16 Aug 2010 20:49:27 -0700 (PDT)
Received: by 10.229.30.195 with HTTP; Mon, 16 Aug 2010 20:49:27 -0700 (PDT)
In-Reply-To: <AANLkTi=bs4wJqG-3MeFJfr8sGC-s9PG_KksCY5TLo7ra@mail.gmail.com>
References: <AANLkTi=bs4wJqG-3MeFJfr8sGC-s9PG_KksCY5TLo7ra@mail.gmail.com>
Date:   Tue, 17 Aug 2010 11:49:27 +0800
Message-ID: <AANLkTikW2_NNj52goVm-h9yvHZb3e-TktmOY5jDHPpRe@mail.gmail.com>
Subject: Re: [Help] R3000 CPU porting, Oops while run app
From:   arrow zhang <arrow.ebd@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <arrow.ebd@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arrow.ebd@gmail.com
Precedence: bulk
X-list: linux-mips

Dears,

yeah, I have known some reason on it:
* not call "mips_cpu_irq_init" in function "arch_init_irq"
* and did not use "set_irq_chip_and_handler"
* before I only setup the "chip" with code "irq_desc[i].chip =
&irq_type;", but it is for old kernel(2.6.19)

so new code is:
void __init arch_init_irq(void)
{
	int i;

	mips_cpu_irq_init();
	for (i = 0; i < 32; ++i) {
		set_irq_chip_and_handler(i, &irq_type, handle_level_irq);
	}
}
