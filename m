Return-Path: <SRS0=CBLp=R6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78754C43381
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 22:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AC42082F
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 22:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PqKr8lnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfC0W1k (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:27:40 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36082 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0W1j (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 27 Mar 2019 18:27:39 -0400
Received: by mail-vs1-f65.google.com with SMTP id n4so10979337vsm.3
        for <linux-mips@vger.kernel.org>; Wed, 27 Mar 2019 15:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ydU001t3e2zWo6of+Lw+lN3EwVXKWGKpNMT3//N3PJo=;
        b=PqKr8lnf3KT01sE0cqYIx4Fe9xEXa/QnooEkMGnrsMX3rs+GldGm7JF7aKSGnzFml+
         wQVOtzNgyMS0WKe1yOVYAEscghpiNvLz/uNjXpxY9KcLyXiRfRi2MdaLgB+T+DhTitKJ
         Td10d7SnJd8hDE/C00nPcm6Cps2nSppvGyKJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ydU001t3e2zWo6of+Lw+lN3EwVXKWGKpNMT3//N3PJo=;
        b=Kl5LR1NmvG/xk+O7rrTxXZld2wY/tizb6eXx3vN8zqlJ4EJZKTp7kNFB6yDLAXyrKS
         11ZjAj+DrZWdpzjHSP+m5FKv5Fs744hy4Wf2zG+4rnY+SGI21cPyoIFnomEY2L8Q7Wpr
         Nr8KmQw52SAwgg9KOGndvxKWzljlDr002/IZ+iX7NF3DYcPPrff9aJwjul4Fr7MQCOLY
         QMC7XdFhmMLLyxo7pcsMpUx1uLL74Ye44m9J3NSclaXYus+xgDSGZMfYlRruYfEDzCCx
         Dv1RePrlhELNKBUL24Z9yJMwjYWzObAt6RH0fO5dN9fJw/4RqRdCG+ylijbzkVc5a93S
         RL4w==
X-Gm-Message-State: APjAAAX9diRT3OdohlV/7aYExFGwYxYtGcUejnVfuKoL3QHyG+By9PRJ
        m06kPk4yejl6025jdyK4X8qrs7JNngo=
X-Google-Smtp-Source: APXvYqxan8d9Y+RqGgpp2T/GAJLVCfamO59Hp3c3kOy2xFZz9pTMd6IO52Sfh9zMqJSVXxXDfkG7jw==
X-Received: by 2002:a67:ad1a:: with SMTP id t26mr24653547vsl.124.1553725658567;
        Wed, 27 Mar 2019 15:27:38 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id c204sm1485743vkd.14.2019.03.27.15.27.37
        for <linux-mips@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:27:37 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id f22so7261668vso.7
        for <linux-mips@vger.kernel.org>; Wed, 27 Mar 2019 15:27:37 -0700 (PDT)
X-Received: by 2002:a67:ffce:: with SMTP id w14mr24277426vsq.111.1553725657293;
 Wed, 27 Mar 2019 15:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190327150551.12851-1-qiaochong@loongson.cn> <CAD=FV=WAvzz+wXZzoLZvxBhO4P_RjV2op=uiX9dHD2dPdSCruw@mail.gmail.com>
 <727cd934.9e92.169c1422cf2.Coremail.qiaochong@loongson.cn>
In-Reply-To: <727cd934.9e92.169c1422cf2.Coremail.qiaochong@loongson.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Mar 2019 15:27:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhqQh2i1CUfgGHPdUtFWsTznCL_1tNafG+F74oHXM1Ew@mail.gmail.com>
Message-ID: <CAD=FV=UhqQh2i1CUfgGHPdUtFWsTznCL_1tNafG+F74oHXM1Ew@mail.gmail.com>
Subject: Re: Re: [PATCH] MIPS: KGDB: fix kgdb support for SMP platforms.
To:     qiaochong <qiaochong@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-mips <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Wed, Mar 27, 2019 at 3:25 PM qiaochong <qiaochong@loongson.cn> wrote:
>
>
> My name  is QiaoChong=EF=BC=8C which is same to my username.
> Qiao is my family name.
> Thanks a lot.

I guess it will be up to whichever maintainer lands this (maybe
Daniel?) on whether they want you to spin it.  I think folks expect to
see a real name that is capitalized and usually a space between the
family name and the given name.

-Doug
