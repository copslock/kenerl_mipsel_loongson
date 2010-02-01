Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 09:58:00 +0100 (CET)
Received: from mail-iw0-f183.google.com ([209.85.223.183]:34447 "EHLO
        mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491929Ab0BAI5z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 09:57:55 +0100
Received: by iwn13 with SMTP id 13so333049iwn.20
        for <multiple recipients>; Mon, 01 Feb 2010 00:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=59ImsTZtIjmUtc5MOMHVgajKTh+tFGxPZgyZ/hFCoY4=;
        b=tHYDmi3w1fWJ/vPXtC39wKoFYgnOdrq6GgJydV5QqtVNxlrlhh7w4FTplMI11MmotP
         GYUnnXAg1uZiYKFw4tF/T+xbNBUgzdmtyRpzP7uDgTZBit/NEWzjF7TW+UcNnBO1Za/H
         uXlLrhUxJO5MUQO1DjJqIyvqivAUuN1l6tKjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=n8Cpi60LANC1qrCwOezUfWXJYjKeFrWe1UMIEuMb0nC4AoJepWJJDnSJN+srTGF60p
         IjOIk7UuQqCeCBsbLM7o5pyANGb6C+l86EUeVsjfvbq6arIb8Fomj57A1zdPkezRv07O
         JMf+QaYrIOoPzoRxH/HDFux4ldL8uiZLdNrgM=
Received: by 10.231.169.67 with SMTP id x3mr3133804iby.76.1265014668736;
        Mon, 01 Feb 2010 00:57:48 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm5255359iwn.14.2010.02.01.00.57.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 00:57:47 -0800 (PST)
Subject: Re: [PATCH] powertv: Fix support for timer interrupts when using
 >64 external IRQs
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     mbizon@freebox.fr
Cc:     David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
In-Reply-To: <1264864218.32192.1.camel@sakura.staff.proxad.net>
References: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net>
         <1264864218.32192.1.camel@sakura.staff.proxad.net>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 01 Feb 2010 16:47:56 +0800
Message-ID: <1265014076.14427.1.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2010-01-30 at 16:10 +0100, Maxime Bizon wrote:
> On Mon, 2009-12-21 at 17:49 -0800, David VomLehn wrote:
> 
> Hi,
> 
> >  	if (cpu_has_mips_r2) {
> > -		cp0_compare_irq = (read_c0_intctl() >> 29) & 7;
> > -		cp0_perfcount_irq = (read_c0_intctl() >> 26) & 7;
> > +		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
> > +		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
> > +		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;
> 
> This patch breaks at least bcm63xx, because cp0_compare_irq_shift is not
> initialized when cpu_has_mips_r2 is false.

Yes, that patch have broken the CEVT_R4K support in the archs whose
cpu_has_mips_r2 is false.

I will send a piece of patch to fix it.

Thanks & Regards,
	Wu Zhangjin
