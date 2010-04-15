Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2010 19:47:36 +0200 (CEST)
Received: from mail-yx0-f183.google.com ([209.85.210.183]:37240 "EHLO
        mail-yx0-f183.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492068Ab0DORrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Apr 2010 19:47:33 +0200
Received: by yxe13 with SMTP id 13so1032851yxe.0
        for <multiple recipients>; Thu, 15 Apr 2010 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=8oBco9Fc+/M5GnPTsgjek1RSvdpr5yWQ09oomFVSXdM=;
        b=u2PTJNlrUqVBNQwMVKwJDFw1gEQOI5OijIxIEm/bX2Q7n6XMt3B6S+1KBHDwHMNJmj
         hM0+RaeRe2HFT3vM+HhZMZKtFY4FrZV3D/39P7xxF1Y+Ij6zYQ9nR6myYnQO+68VAK+g
         NYoSBezMzzYbsv4jDNhs06+PyJPeGH1EWFv+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ttj11XkB7PH4NqrocZxjLreb3G6v3521t3QrVnFe2u9RerizV2RhBVy9rO5j9TZ9pz
         NK20+DlqfpY+zzZCzy1GGFL8yGDMaaRVg5OhH0XgQ/ZEtzqeXAlK0DrTzgstQCisCHkw
         65vl6kvOWHQDWj8hpmcy7/jaamA1sbjKq5RvU=
Received: by 10.101.136.38 with SMTP id o38mr847413ann.146.1271353645427;
        Thu, 15 Apr 2010 10:47:25 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id b10sm3412201ana.16.2010.04.15.10.47.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 10:47:24 -0700 (PDT)
Subject: Re: [PATCH 3/3] MIPS: implement hardware perf event support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
In-Reply-To: <1271349557.7467.424.camel@fun-lab>
References: <1271349557.7467.424.camel@fun-lab>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 16 Apr 2010 01:47:16 +0800
Message-ID: <1271353636.20625.99.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Deng-Cheng

Thanks very much for your Perf support of MIPS.

On Fri, 2010-04-16 at 00:39 +0800, Deng-Cheng Zhu wrote:
> This patch is the HW perf event support. To enable this feature, we can not
> choose the SMTC kernel; Oprofile should be disabled; kernel performance
> events be selected. Then we can enable it in the Kernel type menu.
> 
> Oprofile for MIPS platforms initializes irq at arch init time. Currently we
> do not change this logic to allow PMU reservation.
> 
> If a platform has EIC, we can use the irq base and perf counter irq
> offset defines for the interrupt controller in mipspmu_get_irq().
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  arch/mips/Kconfig             |    8 +
>  arch/mips/kernel/Makefile     |    2 +
>  arch/mips/kernel/perf_event.c | 1468 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1478 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/kernel/perf_event.c
[...]
> + * Copied from Oprofile -- BEGIN
> + */
[...]
> +/* Copied from Oprofile -- END */
> +

Seems you only copied the contents from
arch/mips/oprofile/op_model_mipsxx.c and handle the mipsxx, what about
rm9000(arch/mips/oprofile/op_model_rm9000.c) and
loongson2(arch/mips/oprofile/op_model_loongson2.c)? 

I think it will not work on rm9000 and loongson2 for their performance
counters are different from mipsxx. so suggest you only enable this for
mipsxxx(refer to arch/mips/oprofile/Makefile) via #ifdef and renaming
the current perf_event.c to perf_event_mipsxx.c.

And to reduce the source code duplication, perhaps we need a solution to
share the source code between Oprofile and Perf, and also among mipsxx,
rm9000 and loongson2.

Thanks & Regards,
	Wu Zhangjin
