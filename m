Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2011 01:15:21 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:33756 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491182Ab1EXXPQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2011 01:15:16 +0200
Received: by pwi8 with SMTP id 8so3721022pwi.36
        for <multiple recipients>; Tue, 24 May 2011 16:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:organization:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=YOarLjp8TyVQDEvxSbQslJDsHuVMI5UkoL30+glUgMY=;
        b=sDy1eqzbMFzCAWel+7ei39x/2ytrfc1TQBpAg1p9BrY+f0SmUiyoCM9rOdAFvGKvOP
         xRLPMz36Qf6We/1O9HNmtu7R7wvsY4zJuFgaZi8hEbR6gWr6nkkdgkH2n7GuqxPAvWXK
         fEAzovD45YkkbdPd0z9sfTtcVROs+qmzZr5v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=CdFOS8AHZEH7qxNVuJJIxR8zhQA/L1eU8Rw9g3wfzusQiK4ERU6AagSD0jwvAYYmco
         DYYwWz5zVZhCv85/6KhNmUjslPgYvFPcOXt1XEl6LTZ9WMdA1KWfCOUmbXzToKEBEzCa
         lDgQc+A4n4J54Q3Rp5x2xz2S3EJEcPJ1YZ7tc=
Received: by 10.68.44.130 with SMTP id e2mr3234528pbm.515.1306278908358;
        Tue, 24 May 2011 16:15:08 -0700 (PDT)
Received: from [192.168.0.107] ([182.32.187.185])
        by mx.google.com with ESMTPS id u10sm5281440pbt.69.2011.05.24.16.15.02
        (version=SSLv3 cipher=OTHER);
        Tue, 24 May 2011 16:15:07 -0700 (PDT)
Subject: Re: [PATCH] MIPS:i8259.c remove resume and shutdown to syscore_ops
From:   Wanlong Gao <wanlong.gao@gmail.com>
Reply-To: wanlong.gao@gmail.com
To:     "Rafael J. Wysocki" <rjw@sisk.pl>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Pengfei Zhang <zoppof.zhang@gmail.com>,
        Linux PM mailing list <linux-pm@lists.linux-foundation.org>
In-Reply-To: <201105242059.59770.rjw@sisk.pl>
References: <1306247112.2066.8.camel@Tux>  <201105242059.59770.rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Organization: Linux kernel
Date:   Wed, 25 May 2011 07:14:59 +0800
Message-ID: <1306278899.2135.2.camel@Tux>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 8bit
Return-Path: <wanlong.gao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wanlong.gao@gmail.com
Precedence: bulk
X-list: linux-mips

On 二, 2011-05-24 at 20:59 +0200, Rafael J. Wysocki wrote:
> On Tuesday, May 24, 2011, Wanlong Gao wrote:
> > 
> > > On Tue, May 24, 2011 at 08:19:18PM +0800, Pengfei Zhang wrote:
> > > 
> > > > Remove the resume and shutdown of i8259A from the sysdev_class
> > > > to the syscore_ops since these members had removed from the
> > > > structure sysdev_class.
> > > 
> > > I don't see why one would want to want to first call
> > > register_syscore_ops
> > > then sysdev_class_register and sysdev_register?
> > > 
> > Hi Ralf:
> > If these not moved to syscore_ops, building will get error.
> > 
> > Hi Thomas:
> > Does you mean that we can just remove the sysfs entry now ?
> 
> I had the appended patch in my tree before the merge window started,
> but it conflicted with analogous changes in the MIPS tree, so I had
> dropped it.  Was it a mistake?
> 
> Rafael

Hi Rafael:

On 5/24/11, Ralf Baechle <ralf@linux-mips.org> wrote:
>Re: [PATCH] MIPS: Use struct syscore_ops instead of sysdevs for i8259
> On Fri, May 20, 2011 at 10:41:41PM +0900, Yoichi Yuasa wrote:
>
> Thanks, applied.
>
>   Ralf
It seems already applied some about this?

Thanks

Best regards
Wanlong Gao
