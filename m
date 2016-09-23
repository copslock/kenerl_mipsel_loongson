Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 18:14:06 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35270 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992240AbcIWQN6KXpJi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 18:13:58 +0200
Received: by mail-wm0-f66.google.com with SMTP id 133so3534302wmq.2
        for <linux-mips@linux-mips.org>; Fri, 23 Sep 2016 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=secretlab-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hhz1IANawLx9VFQ/QDQXvhXuQQinHYky2tJnG88Qhds=;
        b=dzq2h/4wqSwQzAUpK8CzpRexyqas9t7Xx/LxRzcmVmU7B2aNqqy5c3oZ/VgFzXO5oL
         QTLPqZQRdeiJgoModwA0cugj+DhyMuStBGbFfqR8b1OGTCjAFzSoOopvhLb/ToYBR0ff
         pA5o7Y8Hx/0w7GF8444f25JzunOmLXCGi/PGyouxARdSXrCJfdLUr233sHwcrBO4ANPI
         no9aOGZhr5O09Ngpc1fQ0v+1sd+NRBIxeGyUkj8FyrlTy5/g8tBj3cFLCe/unTPbZM0+
         FtSxLK0QqBPYywPx6TOohBqUZ1Uuhk/yO7bsvmq/dN2EKGtHfPsLatHMGEJqOlTV6AVn
         iVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hhz1IANawLx9VFQ/QDQXvhXuQQinHYky2tJnG88Qhds=;
        b=DkAsyMLTbWrPA1vTFuvtsObUn7k9ypxHeceQA+VWLvDvX029LA0Doxt02ndVwca4tL
         PHNA45+LM5f284BT74s46nH361AFNfKAjuBcwbAWD0FXZuiKMCgR2KtUclysnETe+Tj5
         xsC+yhwESZuoMV8GO5C1cjd6tkMzexzW7m2JmQGk+anzBmCrrmaSm7AVo0/Z0EkTRgzS
         9nRiXdU2ycqynPvGcFJz88Vc/2t4Ezy4ZgIawaWxn93pK+7FXFj1ZdHD07qVQEau/qCF
         E4kIOs2sFF9fqnE2TRPKCK+GqsDrg8tx/We8Vok6LeFI3/PcfFVoM4OkRSE5SeiGvkX2
         xvAQ==
X-Gm-Message-State: AA6/9RlkORStfophWScTyZG86df/n0N7nj5BIvnIdFJUaVv1ZgSvGSFSXnk1kNzKPlTa2rxH1quHwlEyL8Kntw==
X-Received: by 10.28.92.82 with SMTP id q79mr3398964wmb.113.1474647232671;
 Fri, 23 Sep 2016 09:13:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.232.75 with HTTP; Fri, 23 Sep 2016 09:13:32 -0700 (PDT)
In-Reply-To: <20160923153827.8263-1-paul.burton@imgtec.com>
References: <20160923153827.8263-1-paul.burton@imgtec.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Fri, 23 Sep 2016 17:13:32 +0100
X-Google-Sender-Auth: AWPt62Fo9LJXQcWt9OVsf2sU2Co
Message-ID: <CACxGe6secYUbnZYCpoZH44nEDAU7chfzjxehxWyyotSQE7fWHg@mail.gmail.com>
Subject: Re: [PATCH] of: Prevent unaligned access in of_alias_scan()
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Sep 23, 2016 at 4:38 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> When allocating a struct alias_prop, of_alias_scan() only requested that
> it be aligned on a 4 byte boundary. The struct contains pointers which
> leads to us attempting 64 bit writes on 64 bit systems, and if the CPU
> doesn't support unaligned memory accesses then this causes problems -
> for example on some MIPS64r2 CPUs including the "mips64r2-generic" QEMU
> emulated CPU it will trigger an address error exception.
>
> Fix this by requesting alignment for the struct alias_prop allocation
> matching that which the compiler expects, using the __alignof__ keyword.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Looks right to me.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  drivers/of/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 3ce6953..448aa40 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2042,7 +2042,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
>                         continue;
>
>                 /* Allocate an alias_prop with enough space for the stem */
> -               ap = dt_alloc(sizeof(*ap) + len + 1, 4);
> +               ap = dt_alloc(sizeof(*ap) + len + 1, __alignof__(*ap));
>                 if (!ap)
>                         continue;
>                 memset(ap, 0, sizeof(*ap) + len + 1);
> --
> 2.10.0
>
