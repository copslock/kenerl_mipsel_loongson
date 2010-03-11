Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:42:04 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:34393 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492047Ab0CKDmA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:42:00 +0100
Received: by ewy24 with SMTP id 24so1849553ewy.27
        for <multiple recipients>; Wed, 10 Mar 2010 19:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/QwW/Sik4jBsqpPDDxfJPhsLwABrgYfVu9jhw/o9j6Q=;
        b=WHd6v6xNZYzPdCgbYETsoQMghJMpmaNyiBx8PQ3cNy4IZFi2NnCwJdP5qX34C/VDNP
         jxLjY93WobhwjhVhAYJO09IdHeaH5Stz2w9udUcPFQ/dJjAdUhR/CI/c712fV7W5AwOk
         5t7+rw6ER4L7U0ThzZlLq0y34tKSlKbRfkm24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=qg1y9Qo1ZE+qSEb57dOD2ibzqxCAqqbZej6XAzLCatyrY+LjcBDciAPlWf+zkJVNSn
         6wHYXXpiD14t2VNJM4zTLGBEw1agBgXz+BZHPCIRAlXIDHPQI9yranhsf8ItGBy82Ts6
         fe3Z4dl4wCLa4hDPIg+nrvgs+Hg6g9KAmmtmM=
Received: by 10.213.100.165 with SMTP id y37mr5754300ebn.71.1268278914418;
        Wed, 10 Mar 2010 19:41:54 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 16sm4430477ewy.7.2010.03.10.19.41.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:41:52 -0800 (PST)
Subject: Re: [PATCH 1/3] Loongson-2F: Flush the branch target history such
 as BTB and RAS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Greg KH <gregkh@suse.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        zhangfx <zhangfx@lemote.com>, yanh <yanh@lemtoe.com>
In-Reply-To: <4B98632E.70806@necel.com>
References: <cover.1268153722.git.wuzhangjin@gmail.com>
         <d513f16856e499e82f0b4e428c97fe06afb5a426.1268153722.git.wuzhangjin@gmail.com>
         <4B98632E.70806@necel.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 11 Mar 2010 11:35:20 +0800
Message-ID: <1268278520.17798.5.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-03-11 at 12:27 +0900, Shinya Kuribayashi wrote:
> Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > As the Chapter 15: "Errata: Issue of Out-of-order in loongson"[1] shows, to
> > workaround the Issue of Loongson-2F，We need to do:
> > 
> > "When switching from user model to kernel model, you should flush the branch
> > target history such as BTB and RAS."
> 
> Just wondered, model or mode?
> 

Hmm, should be mode.

> > This patch did clear BTB(branch target buffer), forbid RAS(row address strobe)
> > via Loongson-2F's 64bit diagnostic register.
> 
> Are you sure that RAS represents "Row Address Strobe", not "Return
> Address Stack?"
> 

Hi, Yanhua(from Lemote), can you help to clear this part?

> By the way, we have a similar local workaround for vr55xx processors
> when switching from kernel mode to user mode.  It's not necessarily
> related to out-of-order issues, but we need to prevent the processor
> from doing instruction prefetch beyond "eret" instruction.
> 
> In the long term, it would be appreciated that the kernel has a set
> of hooks when switching KUX-modes, so that each machine could have
> his own, processor-specific treatmens.
> 

Good idea.

Thanks!

Regards,
	Wu Zhangjin
