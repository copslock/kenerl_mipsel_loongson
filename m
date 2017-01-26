Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 03:33:59 +0100 (CET)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:35005
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993947AbdAZCdwRBDwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2017 03:33:52 +0100
Received: by mail-ua0-x244.google.com with SMTP id 96so20983885uaq.2;
        Wed, 25 Jan 2017 18:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cZxWrEAhI2wWYPas7f/fil5A1qmzVu5U57h+VXCEZ/U=;
        b=ZvAbtjLdz2V5p3E0TRXBb1VuCsjK2HQcBgUKvLOACHJWQyVlzDdzDBZfedUn/caem1
         kEfeYL2I3QDIdcsj9Qxtd6aIn/Y8LQRweyKkQvuaaNmpEAI9GQWN+BDAKlJwxNbuyLOt
         Sg5rIqrhb5L7oomcrxsNeRm9ZNMkeGLH/aRqmlC9ubckp1o1LH3JcCtLE0mtzqh763+v
         yCM9u90oI6/CK/r5h3dJTN74GNp7uVDiK+6fX1EAGbYxXK0Gh/e4gQ6f/ZAJPqb+N3Ne
         5Wp+gK1wFz775rbV5UVcRJOYjVxPQDhTgR3rpLorXUwu31EjQaHTVQvG8B3Jrm8eMWlu
         RwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cZxWrEAhI2wWYPas7f/fil5A1qmzVu5U57h+VXCEZ/U=;
        b=VfrDudVvQ5K7ViyIZnjLbiUlvBkTq93Agt5ZzY+DA0LRSb7MHjgbgpdc1dlFFu8ZAp
         q3tb3s+zFDRYLZaYMWGok//8B8MhoPv4iiAX+D0g3b0dT8wyhqCyQHGrMIFIUEw+qI15
         RbtD6dYZlmmkvAXUnT9xdHnaJmDg9rlZZE1aapfVTnOdr+kI2OuPoBNoLNuOxPh8P1Yi
         km190y3TiEdndNKmKqDqH17ViUfksVzepb8fD+RGM+srLl4XYifeiue+SUbEZCErm8I5
         8Wpe7D3p6TNr3CY5W4CaGFzpNxn+Zfrv03rpSF5JxIy/iPTIayBbsajTNEHB8z1lF+ZQ
         ub7g==
X-Gm-Message-State: AIkVDXIUAeG5Looz9E4Ohj0jrNjcRH7CZoZYgZ2t6ZFYmn/KH5aYHV7kQV4Gyi0sjqTO42OpL91u6t8hwnKaWg==
X-Received: by 10.176.0.143 with SMTP id 15mr255364uaj.22.1485398026521; Wed,
 25 Jan 2017 18:33:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.140.138 with HTTP; Wed, 25 Jan 2017 18:33:46 -0800 (PST)
In-Reply-To: <CAKgT0UdBkqsUmp5y2d4fbi4MopW=6rxge_YzAwVvaKCqLj11_Q@mail.gmail.com>
References: <CAEbrdOCo9DeOa=rXYBxCEERNu_Cq=7N+5dDOwLwuZy87D3M6bA@mail.gmail.com>
 <CAKgT0UdBkqsUmp5y2d4fbi4MopW=6rxge_YzAwVvaKCqLj11_Q@mail.gmail.com>
From:   Mark Zhang <bomb.zhang@gmail.com>
Date:   Thu, 26 Jan 2017 10:33:46 +0800
Message-ID: <CAEbrdOB4AQx6frAZr=_u4hutzfXS9R5TOtpdJox=9Tmw4WN0sA@mail.gmail.com>
Subject: Re: [Bug fix]mips 64bits checksum error -- csum_tcpudp_nofold
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        Alexander Duyck <aduyck@mirantis.com>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bomb.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bomb.zhang@gmail.com
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

Hi Alex,

    Thanks for your reply.
    I tested your correction. The result is correct.
    The C language will cause this function(csum_tcpudp_nofold) become
176 MIPS instructions. The assemble code is 150 MIPS instruction.
    If the MIPS CPU is running as 1GHz, C language cause more 60 nano
seconds during send/receive each tcp/udp packet. I'm not sure whether
it will cause any negative result if the frequency of CPU was lower.
MIPS arch is usually used in networking equipments.
    I think Ralf's correction is better.

    - Mark

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/checksum.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 5c585c5..08b6ba3 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -186,7 +186,9 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr,
        "       daddu   %0, %4          \n"
        "       dsll32  $1, %0, 0       \n"
        "       daddu   %0, $1          \n"
+       "       sltu    $1, %0, $1      \n"
        "       dsra32  %0, %0, 0       \n"
+       "       daddu   %0, $1          \n"
 #endif
        "       .set    pop"
        : "=r" (sum)


2017-01-26 2:13 GMT+08:00 Alexander Duyck <alexander.duyck@gmail.com>:
> On Tue, Jan 24, 2017 at 8:35 PM, Mark Zhang <bomb.zhang@gmail.com> wrote:
>> If the input parameters as saddr = 0xc0a8fd60,daddr = 0xc0a8fda1,len =
>> 80, proto = 17, sum =0x7eae049d.
>> The correct result should be 1, but original function return 0.
>>
>> Attached the correction patch.
>
> I've copied your patch here:
>
> From 52e265f7fe0acf9a6e9c4346e1fe6fa994aa00b6 Mon Sep 17 00:00:00 2001
> From: qzhang <qin.2.zhang@nsn.com>
> Date: Wed, 25 Jan 2017 12:25:25 +0800
> Subject: [PATCH] Fixed the mips 64bits checksum error -- csum_tcpudp_nofold
>
> ---
>  arch/mips/include/asm/checksum.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
> index 7749daf..0e351c5 100644
> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -184,6 +184,10 @@ static inline __wsum csum_tcpudp_nofold(__be32
> saddr, __be32 daddr,
>   " daddu %0, %2 \n"
>   " daddu %0, %3 \n"
>   " daddu %0, %4 \n"
> + " dsrl32  $1, %0, 0 \n"
> + " dsll32 %0, %0, 0 \n"
> + " dsrl32 %0, %0, 0 \n"
> + " daddu   %0, $1 \n"
>   " dsll32 $1, %0, 0 \n"
>   " daddu %0, $1 \n"
>   " dsra32 %0, %0, 0 \n"
>
> I agree there does appear to be a bug in the code, and my
> understanding of MIPS assembly is limited, but I don't think your
> patch truly fixes it.  From what I can understand it seems like you
> would just be shifting the register called out at %0 past 64 bits
> which would just zero it out.
>
> Below is the snippet you are updating:
>
>     #ifdef CONFIG_64BIT
>             "       daddu   %0, %2          \n"
>             "       daddu   %0, %3          \n"
>             "       daddu   %0, %4          \n"
>             "       dsll32  $1, %0, 0       \n"
>             "       daddu   %0, $1          \n"
>             "       dsra32  %0, %0, 0       \n"
>     #endif
>
> From what I can tell the issue is that the dsll32 really needs to be
> replaced with some sort of rotation type call instead of a shift, but
> it looks like MIPS doesn't have a rotation instruction.  We need to
> add the combination of a shift left by 32, to a shift right 32, and
> then add that value back to the original register.  Then we will get
> the correct result in the upper 32 bits.
>
> I'm not even sure it is necessary to use inline assembler.  You could
> probably just use the inline assembler for the 32b and change the 64b
> approach over to using C.  The code for it would be pretty simple:
>     unsigned long res = (__force unsigned long)sum;
>
>     res += (__force unsigned long)daddr;
>     res += (__force unsigned long)saddr;
> #ifdef __MIPSEL__
>     res += (proto + len) << 8;
> #else
>     res += proto + len;
> #endif
>     res += (res << 32) | (res >> 32);
>
>     return (__force __wsum)(res >> 32);
>
> That would probably be enough to fix the issue and odds are it should
> generate assembly code very similar to what was already there.
>
> - Alex
