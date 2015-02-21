Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2015 22:04:04 +0100 (CET)
Received: from mail-qc0-f181.google.com ([209.85.216.181]:38774 "EHLO
        mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006732AbbBUVEDBNxff (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Feb 2015 22:04:03 +0100
Received: by qczc9 with SMTP id c9so5956691qcz.5
        for <linux-mips@linux-mips.org>; Sat, 21 Feb 2015 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=trUspc9Lvl+8dsiKZbGBXHKKLw2RZRixshe/if+kWfw=;
        b=wMbu+4l93C1v5oAnsecJH+eXgdxCsZlrmDyg3ACOLIdlHqOenyPasBS821LnXdxegS
         g4RyrVohnsvmeYVYU6GxacSGpOl/ymQjV68ue5JYoEoTnXzk6HNfZhy5w9/GS5Chd18g
         zhxLis58knskLRLXERVaOajN8czY7fhOiGCvOaMQIF87G53x1qr1bkbjqgIJex2OQU1J
         5qmQS4HOzPCeNSEKWfTfXhLXfcX15ODHepclt7ubv+Frju3RhoWoQJGFDPQqmf6CW/Bu
         fLdE1YHUw1v5q7vCV+L0VvycpqAY/FQUXbjDRzKEZQfnRu2Exev0mEm+U9hQsll5d1U8
         kz3Q==
X-Received: by 10.140.88.80 with SMTP id s74mr8860682qgd.28.1424552637609;
 Sat, 21 Feb 2015 13:03:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.36.210 with HTTP; Sat, 21 Feb 2015 13:03:37 -0800 (PST)
In-Reply-To: <alpine.LFD.2.11.1502200445290.26212@localhost>
References: <alpine.LFD.2.11.1502200445290.26212@localhost>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Sat, 21 Feb 2015 13:03:37 -0800
Message-ID: <CAJiQ=7AF9iw0Xs5A_X19=vwsOPuLwasNoz5m1Z3n+dT6A-Zc8A@mail.gmail.com>
Subject: Re: what is the purpose of the following LE->BE patch to arch/mips/include/asm/io.h?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Fri, Feb 20, 2015 at 1:53 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   was recently handed a MIPS-based dev board (can't name the vendor,
> NDA) that *typically* runs in LE mode but, because of a proprietary
> binary that must be run on the board and was compiled as BE, has to be
> run in BE mode.
>
>   the vendor supplied a yoctoproject layer that seems to work fine
> but, in changing the DEFAULTTUNE to big-endian, the following patch
> had to be applied to the 3.14 kernel tree to the file
> arch/mips/include/asm/io.h in order to get output from the console
> port as the system was booting:
>
> 326c326,333
> <               *__mem = __val;                                         \
> ---
>>       {                                                                               \
>>               if (sizeof(type) == sizeof(u32))                \
>>               {                                                                       \
>>                       *__mem = __cpu_to_le32(__val);  \
>>               }                                                                       \
>>               else                                                            \
>>                       *__mem = __val;                                         \
>>       }                                                                                       \
> 356a364
>>       {                                                                               \
> 357a366,368
>>               if (sizeof(type) == sizeof(u32))        \
>>                       __val = __cpu_to_le32(__val);   \
>>       }                                                                                       \
>
>   without that patch, the initial conclusion was that the board was
> just hanging at boot, but i was told, no, it was booting, there was
> just no output at the console port. applied the patch and, voila.

If it's using the serial8250 driver with a standard 16550A-ish UART,
MMIO accesses via readl()/writel() may be byteswapped on a BE system.

Historically I've dealt with this problem by locally modifying the
serial8250 driver to use the __raw_* variants, but here is a patch
that lets you instruct the driver to use either LE or BE accessors:

http://patchwork.linux-mips.org/patch/8572/
