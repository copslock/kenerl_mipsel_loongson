Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 19:43:34 +0200 (CEST)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:35952
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994781AbdEXRn1qtiYg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 19:43:27 +0200
Received: by mail-ua0-x241.google.com with SMTP id i46so12470482uaa.3;
        Wed, 24 May 2017 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SljAe+r5u1zu3WR9SxxiyOCJCd57ySXUsihmh01l8/4=;
        b=KmcoUUEGeYBCtNgJMQMmfntxVPTg6FcjBIdrPQJDc35vjHDK/2CguYS0IpF09KasMf
         /Z90ZBVmSuFBmSxuZgUBHR5ITFXZXdSPXgBqZrevUzqmGyyjuD3sEy9WbONTBSWcx/ud
         4iue1AZFd+L/qK5DWw50c+pw8H7kj8Kku1vfyRhnjx0G/zdegTpForsQwZl3S4RiMc3d
         DYakMAfX8yzAPwzqZGLM9h87vZykoa7fXwltJPE/EZaofnjuzJc0SS0OuK1uvKxynQOx
         Vtg9DpGOgoa5gWs5f5HDwgjHSzuI8kDqzuxLCHcKzjPqc8q6+Dqdo36NX5pDz7aA0QPG
         0QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SljAe+r5u1zu3WR9SxxiyOCJCd57ySXUsihmh01l8/4=;
        b=hHclN327GJsFcDKAyIayqoCknEzRZgZmI2uttOYhHuMd8QAkn/d457V7c1ykdDJWxi
         Ppeb/9/Afny+CRXVj/OoP3vDPXHJqInDK/83gKIDqdwOg5J9nnPBAq+Rd+Omu2ZoNUKE
         eah256F3BgGSgDhKexTKNN37B/36eTIDoaFgSXs7FGqHuy+E2I9v6d9qOLlpPTUTl3QB
         vGeUCYUd01bpM8WIBBSEMHZuj9L8g0NNnSWlss4tPRI8SmGIgEYlNnY4zHECgl/DDuwD
         7S6+SlXVIfOlIrD6IBo2sHM+VU1URPy3RFRjZDrYMA+p/reloIDjB2hF2fG0Xr0TWurC
         aQ5Q==
X-Gm-Message-State: AODbwcDBuNIUhqpOWKsk0Uc8SH/YAN2d1ikYZGy83MY7/g+xUAI6P7QS
        JDR3uJeQ0vjCX9n20KIwOgyQN5PNbw==
X-Received: by 10.176.4.117 with SMTP id 108mr18500716uav.34.1495647802105;
 Wed, 24 May 2017 10:43:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.68.135 with HTTP; Wed, 24 May 2017 10:42:41 -0700 (PDT)
In-Reply-To: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 24 May 2017 19:42:41 +0200
Message-ID: <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: Delete an error message for a failed
 memory allocation in alchemy_pci_probe()
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?B?UmFsZiBCw6RjaGxl?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, May 24, 2017 at 6:42 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 May 2017 18:32:21 +0200
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/mips/pci/pci-alchemy.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
> index e99ca7702d8a..a58c3290bd4e 100644
> --- a/arch/mips/pci/pci-alchemy.c
> +++ b/arch/mips/pci/pci-alchemy.c
> @@ -377,7 +377,6 @@ static int alchemy_pci_probe(struct platform_device *pdev)
>
>         ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>         if (!ctx) {
> -               dev_err(&pdev->dev, "no memory for pcictl context\n");
>                 ret = -ENOMEM;
>                 goto out;
>         }
> --
> 2.13.0

Why are you removing just this one dev_err()?  What issue are you
trying to address?

Manuel
