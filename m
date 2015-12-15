Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2015 01:31:36 +0100 (CET)
Received: from mail-io0-f171.google.com ([209.85.223.171]:36562 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008969AbbLOAbexvbCf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Dec 2015 01:31:34 +0100
Received: by mail-io0-f171.google.com with SMTP id o67so2336472iof.3
        for <linux-mips@linux-mips.org>; Mon, 14 Dec 2015 16:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RRIjfgPeVnb7fht+QZeTN16XZ9yBLdtn3jz4Xl8MA10=;
        b=gBesn3FmLQnTPU8v0nmbqXb/epziqsmYHc3d9ir90NT3OtJ5VvxvfjLHLHrLPigaZm
         gZ2oBeC7i13M75f+BoO0REGaeyY8nsfkXAiosRF0AjOu0emgPetWtS1QKGGCV6e77/+R
         H5GHkg8HuHAvLHeOK9VNEVQcvac++CjZIiPBpEXK+bD/Q2ZUn7njdfLrdeRq7l5gVlbA
         FYLKx4IHGwp3q5yNWq9NMfJxVQekrYLWyXrRP74wEEBu7XyOPuQ/pGX/rgWvGtJ6F7ly
         je64aV0bE2FYbT08U/4r39vHMsh/EZhUQtlD7JwiUXqd6r9+Cn21spb+auAwoeBfi/1b
         7Viw==
MIME-Version: 1.0
X-Received: by 10.107.39.193 with SMTP id n184mr32620230ion.14.1450139489092;
 Mon, 14 Dec 2015 16:31:29 -0800 (PST)
Received: by 10.107.167.66 with HTTP; Mon, 14 Dec 2015 16:31:29 -0800 (PST)
In-Reply-To: <1449599222-8967-1-git-send-email-mar.kolya@gmail.com>
References: <1449599222-8967-1-git-send-email-mar.kolya@gmail.com>
Date:   Mon, 14 Dec 2015 19:31:29 -0500
Message-ID: <CALGY4fu3NUAsc-y7zqPx_o=ggea+1yvs_QYV9PyCVOkkgugUrw@mail.gmail.com>
Subject: Re: [PATCH] mips: Fix CPC_BASE_ADDR mask to match datasheet
From:   Nikolay Martynov <mar.kolya@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Nikolay Martynov <mar.kolya@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <mar.kolya@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mar.kolya@gmail.com
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

Hi.

  I just wanted to confirm that this is the right list for this kind
of patches. Please let me know if I should submit it to some other
place.

Thanks!

2015-12-08 13:27 GMT-05:00 Nikolay Martynov <mar.kolya@gmail.com>:
> According to 'MIPS32® interAptivTM Multiprocessing
> System Programmer’s Guide' CPC_BASE_ADDR takes bits [31:15].
>
> This change is tested ith mt7621 which wasn't working without it.
>
> Signed-off-by: Nikolay Martynov <mar.kolya@gmail.com>
> ---
>  arch/mips/include/asm/mips-cm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> index 6516e9d..f942ec2 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -286,8 +286,8 @@ BUILD_CM_Cx_R_(tcid_8_priority,     0x80)
>  #define CM_GCR_GIC_BASE_GICEN_MSK              (_ULCAST_(0x1) << 0)
>
>  /* GCR_CPC_BASE register fields */
> -#define CM_GCR_CPC_BASE_CPCBASE_SHF            17
> -#define CM_GCR_CPC_BASE_CPCBASE_MSK            (_ULCAST_(0x7fff) << 17)
> +#define CM_GCR_CPC_BASE_CPCBASE_SHF            15
> +#define CM_GCR_CPC_BASE_CPCBASE_MSK            (_ULCAST_(0x1ffff) << 15)
>  #define CM_GCR_CPC_BASE_CPCEN_SHF              0
>  #define CM_GCR_CPC_BASE_CPCEN_MSK              (_ULCAST_(0x1) << 0)
>
> --
> 2.6.3
>



-- 
Martynov Nikolay.
Email: mar.kolya@gmail.com
