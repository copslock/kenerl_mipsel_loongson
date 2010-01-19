Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 07:42:47 +0100 (CET)
Received: from mail-iw0-f192.google.com ([209.85.223.192]:56504 "EHLO
        mail-iw0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490972Ab0ASGmn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2010 07:42:43 +0100
Received: by iwn30 with SMTP id 30so745046iwn.0
        for <multiple recipients>; Mon, 18 Jan 2010 22:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=xpjDbHRxZlz/7zY+nEWOg+HYNeVX/u1HZzgRz0mkgBs=;
        b=LTrBsj2N+jbAc+BhuSABXhJXaujsp/TtO7StHOAlN2vKgvjUr/ldc8xrpqSqedsGg2
         cc4WwdUz5hAE3yoO/goShMSlo1T9OWE+XQrJk8iOl/FQDMQa7t1BnyaIdINmjyAcmtSK
         CmGUudY1YlRWRQ/9EoQ65pDeJJ0G1Fa0rtSX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=dzkXAAOYCuuZrjl+vNhigBPtjkhpn/p9crRanbXGnpTsa9GhS9bsgvh3SkncIu7cgI
         XWbHca866TK+vn9K8/fbZCF7m9M1vvkF2ieuQabTQ+lzB6sn602zscXL/Xlt5xJ68aqQ
         YfxBQBvdZ6GcPc/vpt4KT8o3haRsj1Ar7U/Eg=
Received: by 10.231.40.216 with SMTP id l24mr2136645ibe.40.1263883355062;
        Mon, 18 Jan 2010 22:42:35 -0800 (PST)
Received: from ?192.168.2.212? ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm5105396iwn.12.2010.01.18.22.42.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Jan 2010 22:42:33 -0800 (PST)
Subject: Re: [PATCH v6] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        David Daney <david.s.daney@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
In-Reply-To: <4B54A3A0.5080101@caviumnetworks.com>
References: <1259319110-16107-1-git-send-email-wuzhangjin@gmail.com>
         <1263801284.11671.50.camel@falcon>  <4B54A3A0.5080101@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 19 Jan 2010 14:42:10 +0800
Message-ID: <1263883330.1840.10.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-archive-position: 25606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12264

On Mon, 2010-01-18 at 10:08 -0800, David Daney wrote:
[...]
> > 
> > And I'm not sure whether the cavium octeon support dynamic cpu
> > frequency,
> 
> Not currently...
> 
> > if yes, it's high resolution version of sched_clock() also
> > should be wrapped with the above macro to ensure it is not broken:
> > 
> > arch/mips/cavium-octeon/csrc-octeon.c
> > 
> 
> ... So this is not applicable.
> 

Yes, just changed the state of this patch in the patchwork of
linux-mips(http://patchwork.linux-mips.org).

Will send a new version later.

Thanks & Regards,
	Wu Zhangjin
