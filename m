Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 18:20:30 +0200 (CEST)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:46726 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861301AbaGPQUZuIc94 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jul 2014 18:20:25 +0200
Received: by mail-wg0-f47.google.com with SMTP id b13so1174871wgh.30
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:organization:references
         :user-agent:face:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=YWhmj0mTzINAKDeOAnNP3xKLaDnTQQEp79rqMHkcSd4=;
        b=S4OnNfYUKq2ZSu8Jy0uVYPufazNzZSZmA2o0hj9vIrQnUOpWwkhJy5vCj0AHNHB1Ho
         L4FwmtmAIAI4NSE3NuldwOKKcHXm49t+nwrpQyllvJobdn6+5MrT0t5QInwaiDdtObxf
         ZUkFcS0z88LAG+xbcuosmjz5wrbGlKHX/c9lJZ/maL125JZt2QooDM7oXlOlL2qqMajT
         HySfpFWmkM/V+KPeUhEFoG4ZhWs4u/I4pXuAod/LuO76zi2xe+QJSQ8rogrP16J9hI2c
         IZfGP5cYZWsHHHdmUfl70NztXCivOT6dTdDglC6DOHiWZvIW2E3m1FCe0oO+K6gsyWhQ
         ks0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to
         :organization:references:user-agent:face:date:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=YWhmj0mTzINAKDeOAnNP3xKLaDnTQQEp79rqMHkcSd4=;
        b=g7s7S+/Yi/P3UsUZ+ivGNt+OBkomXsgpbdspNKjIqz7suhuVx3dDV2M875bwNY1SzP
         nW5rX2bDl17Jf8mXB3Infa18V1xjkh2V2Gq6mD8jNS50ipzWoSs92PKh7HpeMUHIwAvt
         lq3YOntHaTem8iU1WG9im9sn+l67aC310j4ulGYafwSrTQWGe6qVQx9kdPKD2okCTPzn
         yMIpUa/LT07kbRzmLLlZ4LRd+n4NxyoQgLp6kfHWiVDXNZtgzjiSWYs/imdWJzH66o6L
         FC2f7pDiY44v8ZLsJvGjzCd0XQHc6hp3BYpZoYh3+dNOwYl1jrnLSAZMZRMe8AR9Ltyz
         eHSA==
X-Gm-Message-State: ALoCoQmcREz7XNpDYFetySKuZyZNqYaocpPd2KJ9Ha6rShbqWvSfPp5aq40zRBUmEPOU3SinpJYX
X-Received: by 10.194.92.148 with SMTP id cm20mr37898069wjb.57.1405527620275;
        Wed, 16 Jul 2014 09:20:20 -0700 (PDT)
Received: from mpn-glaptop.roam.corp.google.com ([2620:0:105f:311:c05c:b62d:85fd:69b9])
        by mx.google.com with ESMTPSA id fc7sm40677340wjc.37.2014.07.16.09.20.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 09:20:19 -0700 (PDT)
From:   Michal Nazarewicz <mina86@mina86.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, m.szyprowski@samsung.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] asm-generic: Add dma-contiguous.h
In-Reply-To: <1405525892-60383-2-git-send-email-Zubair.Kakakhel@imgtec.com>
Organization: http://mina86.com/
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-2-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Notmuch/0.17+15~gb65ca8e (http://notmuchmail.org) Emacs/24.4.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP:  50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Hashcash: 1:20:140716:will.deacon@arm.com::XPUAp+4K1E9Gkjh8:0000000000000000000000000000000000000000001G3S
X-Hashcash: 1:20:140716:linux-arch@vger.kernel.org::nyC4dyXpioKy3rB7:000000000000000000000000000000000001Jnx
X-Hashcash: 1:20:140716:linux-arm-kernel@lists.infradead.org::TldaW93tH9z1vGC5:00000000000000000000000001kQT
X-Hashcash: 1:20:140716:ralf@linux-mips.org::aGvLYwjYA5sBHnj/:0000000000000000000000000000000000000000001hN+
X-Hashcash: 1:20:140716:linux-kernel@vger.kernel.org::YNisK1HA7JD4USYt:0000000000000000000000000000000002Ph3
X-Hashcash: 1:20:140716:mingo@redhat.com::StDnTQ3fjT3StROd:02XA0
X-Hashcash: 1:20:140716:tglx@linutronix.de::w/eAbXKkZ7QdCh8w:00000000000000000000000000000000000000000002TOD
X-Hashcash: 1:20:140716:linux-mips@linux-mips.org::6aKre8QJ2686EjuY:0000000000000000000000000000000000002/DY
X-Hashcash: 1:20:140716:arnd@arndb.de::m1bIi/Wb9KwALOCM:00003gvU
X-Hashcash: 1:20:140716:hpa@zytor.com::TqGpoq2bVNLA4+wv:00004zkD
X-Hashcash: 1:20:140716:x86@kernel.org::0U+mq/DWLWWkb5aA:0004Beh
X-Hashcash: 1:20:140716:gregkh@linuxfoundation.org::ElKeu3M9nB2UdwN9:000000000000000000000000000000000005cUj
X-Hashcash: 1:20:140716:catalin.marinas@arm.com::t2FyeWMkAUrGilAi:000000000000000000000000000000000000005NPc
X-Hashcash: 1:20:140716:zubair.kakakhel@imgtec.com::gZWMt3d348Bmg+vs:000000000000000000000000000000000005xff
Date:   Wed, 16 Jul 2014 18:20:15 +0200
Message-ID: <xa1tfvi1b7i8.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <mpn@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41224
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
> This header is used by arm64 and x86 individually.
>
> Adding to asm-generic to avoid further code repetition while adding cma
> to mips.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>


> ---
>  include/asm-generic/dma-contiguous.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 include/asm-generic/dma-contiguous.h
>
> diff --git a/include/asm-generic/dma-contiguous.h b/include/asm-generic/dma-contiguous.h
> new file mode 100644
> index 0000000..292c571
> --- /dev/null
> +++ b/include/asm-generic/dma-contiguous.h
> @@ -0,0 +1,9 @@
> +#ifndef _ASM_GENERIC_DMA_CONTIGUOUS_H
> +#define _ASM_GENERIC_DMA_CONTIGUOUS_H
> +
> +#include <linux/types.h>
> +
> +static inline void
> +dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> +
> +#endif
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michał “mina86” Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
