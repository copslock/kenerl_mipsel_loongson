Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 18:21:19 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:45393 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861327AbaGPQVCHxbct convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jul 2014 18:21:02 +0200
Received: by mail-wi0-f182.google.com with SMTP id d1so1589536wiv.3
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:organization:references
         :user-agent:face:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=AY1ddBSTya/Z/TLrwX5Fd3/N8l3re18vKOmpKO3RCus=;
        b=RMcsqCSPv8HSqD/hNH0xuwav7eeNeiKzWGY+W8BMgAYhLcPpMuqPh8rkrgXRnLqIBw
         g8OZ6OknVeQGeYPsyPVUUlxEz5Yf2YiMOIMHzi150d52KizDWcJpxpBHY1OFy/S82mWX
         XkTEexhU6CGTNyp4QINYpzxXk6R0zTvT9xuxJREU+GD7c/BRVQytzfEbiylvju1aGkDF
         o8o57k9/q8mTmNF9C/UmjibSsBlkrQ4oqhiQ2Vt4Ei0w7oazMeopeVonti6+Cz9KCbcN
         JpG3RJ3Hm6wtxDanPvXThMNhnX6vsM81nl5+BKNkioE+FyPwwFiSoycA+4BX5H2jeYzB
         1Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to
         :organization:references:user-agent:face:date:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=AY1ddBSTya/Z/TLrwX5Fd3/N8l3re18vKOmpKO3RCus=;
        b=DORNcZniAN7fS8EkkTxXytYSup0V8YwHd2aZvdgb2+dTtvCoInawQUHhcePmwOKCDu
         CiJLAHdvE5fpZ2vL3gC1kkzUDdBA/EWyKFus4H6gFjXry5e66auT9RsHtuYiC7kiZ86C
         h8p7raShrGM1V9rZl6nhLlbhwYevpLWKAtbXKdpLMOCweT/e/gH7FPlJ1hQjKyy5Q/tD
         BVVqbAUiU5IJCGxpOL5BJdHHcepzG18S4Kzu6NBFrSkMUOS4R9qQcM/fDu1rEMSd0G8/
         tF25TYrLJZ5cIR3PXn6C2OwsgmSOeR54wg1rlz7tz72FGC/tOJAjiUWJqnIZcTf/bM/M
         Xlcw==
X-Gm-Message-State: ALoCoQmKfiK8IfEdtJRCPvwNnUGeUIVbnzOWkyFHxcWSICqek3rd7TEetxdsM9iSOcUbswVsW2M6
X-Received: by 10.194.192.201 with SMTP id hi9mr37886069wjc.28.1405527652319;
        Wed, 16 Jul 2014 09:20:52 -0700 (PDT)
Received: from mpn-glaptop.roam.corp.google.com ([2620:0:105f:311:c05c:b62d:85fd:69b9])
        by mx.google.com with ESMTPSA id l8sm40697723wje.15.2014.07.16.09.20.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 09:20:51 -0700 (PDT)
From:   Michal Nazarewicz <mina86@mina86.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, m.szyprowski@samsung.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/4] x86: use generic dma-contiguous.h
In-Reply-To: <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
Organization: http://mina86.com/
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Notmuch/0.17+15~gb65ca8e (http://notmuchmail.org) Emacs/24.4.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP:  50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Hashcash: 1:20:140716:catalin.marinas@arm.com::Palh8q9qT3qX5tU3:0000000000000000000000000000000000000003UC
X-Hashcash: 1:20:140716:linux-arm-kernel@lists.infradead.org::+dGmSykDTGheinxh:00000000000000000000000000Ya3
X-Hashcash: 1:20:140716:mingo@redhat.com::covzxqOaiJfkY0nk:00Xrl
X-Hashcash: 1:20:140716:m.szyprowski@samsung.com::DcZqJ8ZwAuk5Tw3+:00000000000000000000000000000000000000tYO
X-Hashcash: 1:20:140716:ralf@linux-mips.org::nbpXSjE/oPHTJVv7:0000000000000000000000000000000000000000000uS2
X-Hashcash: 1:20:140716:linux-arch@vger.kernel.org::1lBj8CLMj90A/DDM:000000000000000000000000000000000001Od8
X-Hashcash: 1:20:140716:tglx@linutronix.de::MNccQdAtK9pP3xYB:00000000000000000000000000000000000000000001rU4
X-Hashcash: 1:20:140716:zubair.kakakhel@imgtec.com::1jumXx7o1a85FpWx:000000000000000000000000000000000002Yt/
X-Hashcash: 1:20:140716:linux-kernel@vger.kernel.org::2OeEnRiqBIRckkfU:0000000000000000000000000000000002W5q
X-Hashcash: 1:20:140716:gregkh@linuxfoundation.org::kAz30K0sdO+hRPkG:000000000000000000000000000000000002dAb
X-Hashcash: 1:20:140716:x86@kernel.org::lQeAaLaQskcKoivp:0004pW7
X-Hashcash: 1:20:140716:linux-mips@linux-mips.org::hus92bFhNzHWOCxG:0000000000000000000000000000000000005CLw
X-Hashcash: 1:20:140716:arnd@arndb.de::grdNF8pO7zOe+lH2:00007pjZ
X-Hashcash: 1:20:140716:will.deacon@arm.com::rNzoDB0KjD1CHh4k:00000000000000000000000000000000000000000081Tn
X-Hashcash: 1:20:140716:hpa@zytor.com::u+3EVN98WcdAoCU9:0000CZ3U
Date:   Wed, 16 Jul 2014 18:20:49 +0200
Message-ID: <xa1ta989b7ha.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <mpn@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mina86@mina86.com
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

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> wrote:
> dma-contiguous.h is now in asm-generic. Use that to avoid code
> repetition in x86.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

But to be honest, I would fold the three into a single commit.

> ---
>  arch/x86/include/asm/Kbuild           |  1 +
>  arch/x86/include/asm/dma-contiguous.h | 12 ------------
>  2 files changed, 1 insertion(+), 12 deletions(-)
>  delete mode 100644 arch/x86/include/asm/dma-contiguous.h
>
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
> index 3bf000f..d55a210 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -6,6 +6,7 @@ genhdr-y += unistd_x32.h
>  
>  generic-y += clkdev.h
>  generic-y += cputime.h
> +generic-y += dma-contiguous.h
>  generic-y += early_ioremap.h
>  generic-y += mcs_spinlock.h
>  generic-y += scatterlist.h
> diff --git a/arch/x86/include/asm/dma-contiguous.h b/arch/x86/include/asm/dma-contiguous.h
> deleted file mode 100644
> index b4b38ba..0000000
> --- a/arch/x86/include/asm/dma-contiguous.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#ifndef ASMX86_DMA_CONTIGUOUS_H
> -#define ASMX86_DMA_CONTIGUOUS_H
> -
> -#ifdef __KERNEL__
> -
> -#include <linux/types.h>
> -
> -static inline void
> -dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> -
> -#endif
> -#endif
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michał “mina86” Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
