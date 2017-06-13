Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 18:13:45 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:33274
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994231AbdFMQNi4U7My (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2017 18:13:38 +0200
Received: by mail-qt0-x244.google.com with SMTP id w1so35521267qtg.0;
        Tue, 13 Jun 2017 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wwzp4pJhR5TfmdtMlSh8RHO6uv80YK1H4TXBu6bZLNs=;
        b=VjJx26ROZGYKkJ/4bTZOAFFiNOgy/koNwzYcvY3GykK4bR8Sx6gL/Y5bzGVgH+rs3Z
         U7jtZRK41k8IKA7dkpxgGgoStvTVBIHRBc7jRmCaU9ia/ycT7qMbPdFJvsNLUcTyD/C/
         yVdGTjng9/WBw6M3kGvhx2fW3lQE4ghKLyvzyGD1yIsP7Ku6hugTDvf4pvMEZur/s9q5
         bdPReY58ok8OfTYbOdczaiSdS7AMhY/MV9ZgZOXeMzo/yV5W7J6AlO3Pky7OeDxXIqhU
         uuO+stHIlS3salisvxBqsn8Nl02CShB4TJUjZK68Kp7GONlh6icFTRXjKoiNPjyzW+H1
         qOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wwzp4pJhR5TfmdtMlSh8RHO6uv80YK1H4TXBu6bZLNs=;
        b=LjjOVtRy8Ey2r1InPL23KiYRy7IDflp+bb3ucVSj0rrLzQc0w1arfFR2jgaEpdc8Lg
         YJwJAsfOCl75fdPWR1xtG7ySTC+CF0xsu6gCgM92IfKPh3dPVvVBtrGrBoLHCeqIBH+7
         M6GGdwpBwxEDb3HCIa3YLV5n5GhKiYt+wXbUGTWWWkjMS87SoH0SNCXGnwWipGGdUw0G
         yU2O6eJAjbHjMdd09zHTAMgrhX0UIOaYCTsvSavpcfUZvFVLTBAOIOpn4SFMMf5/ImSt
         RqTi0oq4SNOD5Lb1UVR1OCqkdTsJRM6R8mtPIJoydaSd3e/nOc1B0N3kc5XQAil+Sbiz
         gm8w==
X-Gm-Message-State: AKS2vOwTmW5J3iJw7AKsSsOMkxUEG3hPE1Yfoo4kTmSajmMpE/xv0mbp
        CvkVMc1nxGhvbcPWpHMms4cBxyQChA==
X-Received: by 10.55.210.193 with SMTP id f184mr935809qkj.76.1497370412928;
 Tue, 13 Jun 2017 09:13:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.180 with HTTP; Tue, 13 Jun 2017 09:13:12 -0700 (PDT)
In-Reply-To: <20170602182003.16269-4-paul.burton@imgtec.com>
References: <20170602182003.16269-1-paul.burton@imgtec.com> <20170602182003.16269-4-paul.burton@imgtec.com>
From:   Rahul Bedarkar <rahulbedarkar89@gmail.com>
Date:   Tue, 13 Jun 2017 21:43:12 +0530
X-Google-Sender-Auth: HMjOyfA8aSIK1Lppkz5-1snlmTk
Message-ID: <CA+NV+V=gUdcu_tRKnyLrSauuge88Bou1CB4Q+n75A48d+MqJyg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] MIPS: DTS: img: Don't attempt to build-in all .dtb files
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <rpal143@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rahulbedarkar89@gmail.com
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

Hi Paul,

On Fri, Jun 2, 2017 at 11:50 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> When building a FIT image we may want the kernel to build multiple .dtb
> files, but we don't want to build them all into the kernel binary as
> object files since they'll instead be included in the FIT image.
>
> Commit daa10170da27 ("MIPS: DTS: img: add device tree for Marduk board")
> however created arch/mips/boot/dts/img/Makefile with a line that builds
> any enabled .dtb files into the kernel. Remove this & build the
> pistachio object specifically, in preparation for adding .dtb targets
> which we don't want to build into the kernel.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
>
> ---
>
> Changes in v4:
> - New patch.
>
> Changes in v3: None
> Changes in v2: None
>
>  arch/mips/boot/dts/img/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

It looks good to me.

Reviewed-by: Rahul Bedarkar <rahulbedarkar89@gmail.com>

> diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
> index 69a65f0f82d2..c178cf56f5b8 100644
> --- a/arch/mips/boot/dts/img/Makefile
> +++ b/arch/mips/boot/dts/img/Makefile
> @@ -1,6 +1,5 @@
>  dtb-$(CONFIG_MACH_PISTACHIO)   += pistachio_marduk.dtb
> -
> -obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))

It was probably copy/paste from other board Makefiles. But If I
understand it correctly, please correct me if I am wrong, linking of
object file of device tree to kernel image is useful if boot loader
doesn't support loading external device tree and in that case kernel
can use inbuilt device tree.

Thanks,
Rahul
