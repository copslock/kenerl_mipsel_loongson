Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 17:14:54 +0100 (CET)
Received: from mailout3.samsung.com ([203.254.224.33]:40353 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993896AbdCHQOqnAMJD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 17:14:46 +0100
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OMI033A47BQIEA0@mailout3.samsung.com>; Thu,
 09 Mar 2017 01:04:38 +0900 (KST)
Received: from epsmges5p5.samsung.com (unknown [182.195.42.89])
 by     epcas5p1.samsung.com (KnoxPortal)
 with ESMTP id  20170308160438epcas5p1fc9dbd864602381328735d2cd8700f5b~p861-4tj81896218962epcas5p1L;
        Wed,  8 Mar 2017 16:04:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40])
 by     epsmges5p5.samsung.com (EPCPMTA) with SMTP id 05.CD.04904.69B20C85; Thu,
 9      Mar 2017 01:04:38 +0900 (KST)
Received: from epcpsbgm2new.samsung.com
 (u27.gpu120.samsung.co.kr      [203.254.230.27])
 by epcas5p4.samsung.com (KnoxPortal)
 with ESMTP id  20170308160437epcas5p40c3197b4fde85ccf984a362917a7c5a7~p861RtJuJ3114331143epcas5p4l;
        Wed,  8 Mar 2017 16:04:37 +0000 (GMT)
X-AuditID: b6c32a59-f79736d000001328-89-58c02b9637cd
Received: from epmmp2 ( [203.254.227.17]) by epcpsbgm2new.samsung.com   (EPCPMTA)
 with SMTP id 67.8E.06422.59B20C85; Thu,  9 Mar 2017 01:04:37 +0900     (KST)
Received: from amdc3058.localnet ([106.120.53.102])
 by mmp2.samsung.com    (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5  2014)) with ESMTPA id <0OMI00IAG7BOZBB0@mmp2.samsung.com>; Thu,
 09 Mar 2017    01:04:37 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] mips: workpad_defconfig: convert to use libata PATA
 drivers
Date:   Wed, 08 Mar 2017 17:04:35 +0100
Message-id: <1693758.UBeBuiPSKd@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1442245918-27631-17-git-send-email-b.zolnierkie@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7bCmhu407QMRBtteCloc2/GIyeLyrjls
        FhOmTmK3uLRHxYHF4+jKtUwenzfJBTBFcdmkpOZklqUW6dslcGXM/rKWueAHX0XnZvsGxiU8
        XYycHBICJhKTLv5hgrDFJC7cW8/WxcjFISSwlFHix+Xb7BBOO5PEm6OvGGE6/i54DtYhJDCH
        UeLXznyIoq+MEtcf7GAGSbAJWElMbF8F1iAioCbx6ttmVhCbWSBC4u8PkHUcHMICYRKT17qA
        mCwCqhLn72mBVPAKaEpMnniKDcQWFfCS2LKvHayaE8h+/kMYokRQ4sfkeywQA+Ul9u2fCjVc
        R+LssXVQV75nk9jS5QfSKiEgK7HpADNE2EXi1oJ+qHeFJV4d38IOYUtL/F16C6p1OqPE9t8S
        IE9JCGxmlFi1ewJUkbXE4eMXoXbxSfT+fsIEMZ9XoqNNCKLEQ+Jw+0yoOY4SH2YeZYUE1B1G
        iaZVahMY5Wch+WAWkg9mIflgASPzKkax1ILi3PTUYtMCU73ixNzi0rx0veT83E2M4FSgFbmD
        8crMoEOMAhyMSjy8AsIHIoRYE8uKK3MPMUpwMCuJ8DppAoV4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzRhlMjBASSE8sSc1OTS1ILYLJMnFwSjUwarx4smNi4E6NdWYLVFcFzuK7JXdz8baX0c3P
        /s19Ybk3/3tOrLEOk9uS4/Eh69W9s1IEN8yLs5TqU9lYFLjGfYf/G8mGM9cPJ8buv1Z4vPGQ
        mm37z0+OMdu7vFLvMcpKPNgyP3V2ZfjMB4q316vvXeAwXe9wzB+rtcrr3f49ETv1yj6xs18z
        SImlOCPRUIu5qDgRAJW+IvkBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t9jQd2p2gciDNbdkbc4tuMRk8XlXXPY
        LCZMncRucWmPigOLx9GVa5k8Pm+SC2CKcrPJSE1MSS1SSM1Lzk/JzEu3VQoNcdO1UFLIS8xN
        tVWK0PUNCVJSKEvMKQXyjAzQgINzgHuwkr5dglvG7C9rmQt+8FV0brZvYFzC08XIySEhYCLx
        d8FzJghbTOLCvfVsILaQwCxGiYaLtV2MXED2V0aJRU2rGUESbAJWEhPbV4HZIgJqEq++bWYF
        sZkFIiQ+v5zL3MXIwSEsECYxea0LiMkioCpx/p4WSAWvgKbE5ImnwMaLCnhJbNnXzgRSwglk
        P/8hDLGpg1Hi4JHNTBD1ghI/Jt9jgZguL7Fv/1SoTVoS63ceZ5rACHQjQtksJGWzkJQtYGRe
        xSiRWpBcUJyUnmuUl1quV5yYW1yal66XnJ+7iREcH8+kdzAe3uV+iFGAg1GJh1dA+ECEEGti
        WXFl7iFGCQ5mJRHen1pAId6UxMqq1KL8+KLSnNTiQ4ymQP9NZJYSTc4Hxm5eSbyhibmJubGB
        hbmlpYmRkjhv4+xn4UIC6YklqdmpqQWpRTB9TBycUsAYsF2uxKtnqfKGfbvvjKMa85wW+95z
        9NbYyCur9+uXoGA84y3v4rmmdaWmnl7N5fX/rS0V+Pt38E54LLzhx/Z/JUHRVUczaz9PedvM
        fWn3N+tppvz1ybeOvZ8x8aFGrVW/gfT3isjCYwFBRnv2sdSIz20xsJdeUXRln6rLdvWP3Zpd
        jKKcf5RYijMSDbWYi4oTAXTf8MelAgAA
X-MTR:  20000000000000000@CPGS
X-CMS-MailID: 20170308160437epcas5p40c3197b4fde85ccf984a362917a7c5a7
X-Msg-Generator: CA
X-Sender-IP: 203.254.230.27
X-Local-Sender: =?UTF-8?B?QmFydGxvbWllaiBab2xuaWVya2lld2ljehtTUlBPTC1LZXJu?=
        =?UTF-8?B?ZWwgKFRQKRvsgrzshLHsoITsnpAbU2VuaW9yIFNvZnR3YXJlIEVuZ2luZWVy?=
X-Global-Sender: =?UTF-8?B?QmFydGxvbWllaiBab2xuaWVya2lld2ljehtTUlBPTC1LZXJu?=
        =?UTF-8?B?ZWwgKFRQKRtTYW1zdW5nIEVsZWN0cm9uaWNzG1NlbmlvciBTb2Z0d2FyZSBF?=
        =?UTF-8?B?bmdpbmVlcg==?=
X-Sender-Code: =?UTF-8?B?QzEwG0VIURtDMTBDRDAyQ0QwMjczOTI=?=
CMS-TYPE: 105P
X-HopCount: 7
X-CMS-RootMailID: 20170308160437epcas5p40c3197b4fde85ccf984a362917a7c5a7
X-RootMTR: 20170308160437epcas5p40c3197b4fde85ccf984a362917a7c5a7
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-17-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170308160437epcas5p40c3197b4fde85ccf984a362917a7c5a7@epcas5p4.samsung.com>
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: b.zolnierkie@samsung.com
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


Hi Ralf,

When patches converting MIPS defconfigs to libata PATA were
applied this one got lost somehow. Please consider merging
(it applies fine to v4.11-rc1).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On Monday, September 14, 2015 05:51:58 PM Bartlomiej Zolnierkiewicz wrote:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts workpad_defconfig to use libata PATA
> drivers.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> Build tested only.
> If you have affected hardware please test.  Thank you.
> 
>  arch/mips/configs/workpad_defconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/configs/workpad_defconfig b/arch/mips/configs/workpad_defconfig
> index ee4b2be..1b556cd 100644
> --- a/arch/mips/configs/workpad_defconfig
> +++ b/arch/mips/configs/workpad_defconfig
> @@ -28,10 +28,10 @@ CONFIG_IP_MULTICAST=y
>  # CONFIG_IPV6 is not set
>  CONFIG_NETWORK_SECMARK=y
>  CONFIG_BLK_DEV_RAM=m
> -# CONFIG_MISC_DEVICES is not set
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECS=m
> -CONFIG_IDE_GENERIC=y
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_ATA=y
> +CONFIG_PATA_PCMCIA=m
> +CONFIG_PATA_LEGACY=y
>  CONFIG_NETDEVICES=y
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set
