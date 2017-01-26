Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 16:58:03 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:35993
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993890AbdAZP54PStfJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2017 16:57:56 +0100
Received: by mail-io0-x244.google.com with SMTP id q20so5317223ioi.3;
        Thu, 26 Jan 2017 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W1E4GW4DiEQrJdWo/ed4Uvv6YbH32E/BsXNJUSWCYS8=;
        b=XfvmZ4IKSylW7T9p4+PJgcVWcYOOR3uSSRNYo1xgb356iFxU1dz5RDQ20g+JAk/vJx
         VUfAuoD2UqsBJK/hhf2W9QndDJQenIiLwYc+vzKkscozDspJI045tD3MMcwx6OOxfdFO
         l67Gj3LtvjQvgNIA+XfHxmvdIDJB76dRgDRulgeKcmNLr6RkmO6cOzBASEICrdeJe+xN
         v8gTwKd++GTZaIUGwOcnyP8hPEcvAU9X+ihQtL86dMDxEMHTKkCb3LL7F1OVKjOCqsS2
         846jyUYYawx2He4UVrWi+rD8Z2tusrZapZj/8VqFwIcqajU9lqHv5xc/6k16JFEtl3l9
         EYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W1E4GW4DiEQrJdWo/ed4Uvv6YbH32E/BsXNJUSWCYS8=;
        b=AE4+/javdzwlR+oT/sAUSqfs8Qw216OrHt9C7bVWagU6pVgxXvxkI1OSzVV6nMdOHH
         p+dCdho7CkAcB76pVHpQyFtnZvZ+0NEd+f3rv5ronqjmd9xFvJ7M7/pK06MRIQGSja6R
         1uyXpHLz2B8AipIW7AvaFmzY7UDHFMBJTJMqOKJnBwmFitOaik8/j167jryJMOXin7ah
         EILZLW2fJcp1eVXf2QMvdL+w2lcXFKUSdtCO3vEoIeKkKwy0+JzI/lwSqMTyn/rLG+d7
         vt8iUzXf7+PCCJEhgziVdGJ+mPsc7Ugkz4dkU8OfG7ZJtUM2kUXCOrbwA8Qqj0knPNrE
         iIdg==
X-Gm-Message-State: AIkVDXIvbu6xsuvvF0pD0bMR7aoJpZnc/eq53JGFIqzQIh3mzKtpOfcZUX54oB/lh4J5E8V79Zwp9kMzYaf+jw==
X-Received: by 10.107.169.202 with SMTP id f71mr3321873ioj.199.1485446270221;
 Thu, 26 Jan 2017 07:57:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.69.41 with HTTP; Thu, 26 Jan 2017 07:57:49 -0800 (PST)
In-Reply-To: <CAEbrdOB4AQx6frAZr=_u4hutzfXS9R5TOtpdJox=9Tmw4WN0sA@mail.gmail.com>
References: <CAEbrdOCo9DeOa=rXYBxCEERNu_Cq=7N+5dDOwLwuZy87D3M6bA@mail.gmail.com>
 <CAKgT0UdBkqsUmp5y2d4fbi4MopW=6rxge_YzAwVvaKCqLj11_Q@mail.gmail.com> <CAEbrdOB4AQx6frAZr=_u4hutzfXS9R5TOtpdJox=9Tmw4WN0sA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 26 Jan 2017 07:57:49 -0800
Message-ID: <CAKgT0UdNMH89JD95f7qmMLe32W3R6pupOOG_mSn=_ZkpUASBJw@mail.gmail.com>
Subject: Re: [Bug fix]mips 64bits checksum error -- csum_tcpudp_nofold
To:     Mark Zhang <bomb.zhang@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        Alexander Duyck <aduyck@mirantis.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexander.duyck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.duyck@gmail.com
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

On Wed, Jan 25, 2017 at 6:33 PM, Mark Zhang <bomb.zhang@gmail.com> wrote:
> Hi Alex,
>
>     Thanks for your reply.
>     I tested your correction. The result is correct.
>     The C language will cause this function(csum_tcpudp_nofold) become
> 176 MIPS instructions. The assemble code is 150 MIPS instruction.
>     If the MIPS CPU is running as 1GHz, C language cause more 60 nano
> seconds during send/receive each tcp/udp packet. I'm not sure whether
> it will cause any negative result if the frequency of CPU was lower.
> MIPS arch is usually used in networking equipments.
>     I think Ralf's correction is better.
>
>     - Mark
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
>  arch/mips/include/asm/checksum.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
> index 5c585c5..08b6ba3 100644
> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -186,7 +186,9 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr,
>         "       daddu   %0, %4          \n"
>         "       dsll32  $1, %0, 0       \n"
>         "       daddu   %0, $1          \n"
> +       "       sltu    $1, %0, $1      \n"
>         "       dsra32  %0, %0, 0       \n"
> +       "       daddu   %0, $1          \n"
>  #endif
>         "       .set    pop"
>         : "=r" (sum)
>

This looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
