Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 04:03:16 +0100 (WEST)
Received: from wf-out-1314.google.com ([209.85.200.168]:2833 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022918AbZFEDDE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2009 04:03:04 +0100
Received: by wf-out-1314.google.com with SMTP id 28so486584wfa.21
        for <multiple recipients>; Thu, 04 Jun 2009 20:03:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Uan6n2NW90DtOUoZYPgKYM7eh0GWpRs7gPQc4Mqt3c8=;
        b=ckv9DFiKeGhjymEvTrBGPDlA4pi+UKx3MVrdwymClPNE+QvYNooTg9o6dnEVLzyN8T
         Guq96gK5tnjMTyT1h6195DONtd/mnA8qsAkLgbQtMVU6Lc1WrVrvJkezl2FMUZzCsi2w
         0AO5+U5SkwqPQu5Z2gOVsyxDheO5P+7RyvZbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=gmscSxXM4K5pYjGAyg1P22SIiG8tbP3Nrn4vusAtpzDmHy/oVehv+J1WbfkpsVxxxb
         fWDNLMuWxdWF4Ol1EypEv5dNSZJUFTbn2DPAd5Q++99MPTlctUl3puNCUZusEmxOkohx
         vKeJq5oYTtYfbbULyOVoyv7/ufObkK1i7hQYE=
MIME-Version: 1.0
Received: by 10.142.214.5 with SMTP id m5mr1000744wfg.110.1244170982273; Thu, 
	04 Jun 2009 20:03:02 -0700 (PDT)
In-Reply-To: <20090603153151.GA4009@alpha.franken.de>
References: <20090604001604.9ced2997.yoichi_yuasa@tripeaks.co.jp>
	 <20090603153151.GA4009@alpha.franken.de>
Date:	Fri, 5 Jun 2009 12:03:01 +0900
X-Google-Sender-Auth: 9b773305ea4b29b8
Message-ID: <21eaeb5a0906042003rd106d6gad73e41a5bca2448@mail.gmail.com>
Subject: Re: [PATCH][MIPS] add DMA declare coherent memory support
From:	Yuasa Yoichi <yoichi_yuasa@tripeaks.co.jp>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tripeaks@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

2009/6/4 Thomas Bogendoerfer <tsbogend@alpha.franken.de>:
> On Thu, Jun 04, 2009 at 12:16:04AM +0900, Yoichi Yuasa wrote:
>>
>> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>
> a little bit more description what this is all about would be quite
> helpful. I also see a problem as there is at least one MIPS machine
> (SGI IP28), which doesn't support coherent memory (at least not without
> playing dirty games with the memory controller, which in return makes
> the machine slow).

Some drivers require dma_declare_coherent_memory() (eg.
drivers/usb/host/ohci-sm501.c).
It is used to driver's local memory allocation with dma_alloc_coherent().

Yoichi
