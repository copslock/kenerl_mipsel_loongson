Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 18:39:18 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:52756 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861300AbaGPQjNtY-8i convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jul 2014 18:39:13 +0200
Received: by mail-wg0-f43.google.com with SMTP id l18so1190390wgh.2
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:organization:references
         :user-agent:face:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=+0HprLPQDnOzxemiDScdCdRR+ai+u1DS/91gKqvye+Q=;
        b=FFTmY9F98HwORukUsAhpUhw02ZLAELmrzDi+3rwEOygfDLKaFVkM5i8sBBnPx7/g65
         tk699b+HAoQuJtL2o3u6cn/GEd+zFJZ99hjAlM8bWzk1bqnh4fkAWvfqCCvpqZ2uW0Ut
         G9AGb/s8Nsr+lnREMkV/QdE5BesJVi3Gl+AKMw0bt11B6o5eu02p+Hk1xMCyvP+tXVo9
         DGkm62lbqkYPWlyTjvOrSrCYu1n49xs4ChCm+HIJM8KjNscSx+7toH2Yi+z6TCnGP2eD
         LoES0c1Hf1vCr4dzJSVZzrzO5ZTGvUETFFrl5nXA+r+g2W9clfUcf1u1gchZGK5EwmGy
         +lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to
         :organization:references:user-agent:face:date:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=+0HprLPQDnOzxemiDScdCdRR+ai+u1DS/91gKqvye+Q=;
        b=VeVqqQ5tPlAH3uvk598iEIb8YV6PAMWxCh3/fplDZ0CJ9KYkDVWcUqw8UI7q0awzW9
         RimQnkviv4cJ9D5IcWpHPe2w5mDa/cORB4bqhryQb+IbpW6r5Ieb9wULHJ7/hrj0uckC
         Pawd2H9cONQiLDGGd3G78rnRaSUVhwpLzaguIaHCtBSENBzUHMds+xpZg1VlgofDU4TK
         3ZFHZwKXtte+MXLQe2UMBBNKrNiVFH39wd5rJakCAg6RhVuR9hTKf4zlqtk3kxGTGkeu
         hz0JTn4uKmcA+stHDO15Af6Qs/m991zUvqMl5nTy5LPkh/b2hveunHDoJFfSL3X7PxpG
         9x1Q==
X-Gm-Message-State: ALoCoQkrA87ed05onE+Tz0FrOsq3YFz7zcFqv3g1XsxUjjm9YF26FDXllJO4txMpWQCVd7LtzXJS
X-Received: by 10.194.219.70 with SMTP id pm6mr36841350wjc.53.1405528748404;
        Wed, 16 Jul 2014 09:39:08 -0700 (PDT)
Received: from mpn-glaptop.roam.corp.google.com ([2620:0:105f:311:c05c:b62d:85fd:69b9])
        by mx.google.com with ESMTPSA id r14sm10857313wik.3.2014.07.16.09.39.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 09:39:07 -0700 (PDT)
From:   Michal Nazarewicz <mina86@mina86.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, m.szyprowski@samsung.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] mips: dma: Add cma support
In-Reply-To: <1405525892-60383-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Organization: http://mina86.com/
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-5-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Notmuch/0.17+15~gb65ca8e (http://notmuchmail.org) Emacs/24.4.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP:  50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Hashcash: 1:20:140716:will.deacon@arm.com::e13jxZb8Q7J2Jg1D:0000000000000000000000000000000000000000000Jet
X-Hashcash: 1:20:140716:gregkh@linuxfoundation.org::F54o/oH2DKxpr6Qg:000000000000000000000000000000000000ylm
X-Hashcash: 1:20:140716:x86@kernel.org::WEGSAkmCFHjryemJ:00016T4
X-Hashcash: 1:20:140716:mingo@redhat.com::oCi6raNLKi6B5Jnk:01UzV
X-Hashcash: 1:20:140716:linux-mips@linux-mips.org::vwa8NscyQrYk98Au:0000000000000000000000000000000000001WpT
X-Hashcash: 1:20:140716:linux-arch@vger.kernel.org::7b+2qn4aLkVMgX8f:000000000000000000000000000000000001fez
X-Hashcash: 1:20:140716:linux-arm-kernel@lists.infradead.org::dxgAadrUjyGT6Qdf:00000000000000000000000001akY
X-Hashcash: 1:20:140716:arnd@arndb.de::sJTCjGek4wafp28t:00001uI5
X-Hashcash: 1:20:140716:zubair.kakakhel@imgtec.com::mmD2O/ZVn75dH9Lz:000000000000000000000000000000000002A/5
X-Hashcash: 1:20:140716:linux-kernel@vger.kernel.org::81zN1YRqUv9fezYo:00000000000000000000000000000000026YH
X-Hashcash: 1:20:140716:ralf@linux-mips.org::d/4oUEWrQ/XY1X1G:0000000000000000000000000000000000000000002UIc
X-Hashcash: 1:20:140716:catalin.marinas@arm.com::EOsCJbmp+SeGK0rS:000000000000000000000000000000000000003CEy
X-Hashcash: 1:20:140716:tglx@linutronix.de::6Vtta9BSomCZf8Sk:00000000000000000000000000000000000000000003qPE
X-Hashcash: 1:20:140716:hpa@zytor.com::Q7EM/AHMKsdZmSV6:00005h1y
X-Hashcash: 1:20:140716:m.szyprowski@samsung.com::W/rZCyvdr7j8Zdfg:0000000000000000000000000000000000000Bg7z
Date:   Wed, 16 Jul 2014 18:39:05 +0200
Message-ID: <xa1t7g3db6mu.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <mpn@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41227
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
> Adds cma support to the mips architecture.
>
> cma uses memblock. However, mips uses bootmem.

Does cma_early_percent_memory work correctly then?

> bootmem is informed about any regions reserved by memblock

Alternatively maybe it would make sense to create a new definition of
dma_contiguous_reserve_area that uses bootmem and choose it based on
some CONFIG_CMA_USE_BOOTMEM which would be selected by MIPS.

> dma api is modified to use cma reserved memory regions when available
>
> Tested using cma_test. cma_test is a simple driver that assigns blocks
> of memory from cma reserved sections.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  arch/mips/Kconfig            |  1 +
>  arch/mips/include/asm/Kbuild |  1 +
>  arch/mips/kernel/setup.c     |  9 +++++++++
>  arch/mips/mm/dma-default.c   | 37 +++++++++++++++++++++++++------------
>  4 files changed, 36 insertions(+), 12 deletions(-)
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michał “mina86” Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
