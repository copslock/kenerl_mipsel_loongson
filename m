Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 15:01:07 +0100 (CET)
Received: from mailout2.samsung.com ([203.254.224.25]:20428 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991550AbdKIOA6k765K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 15:00:58 +0100
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20171109140050epoutp02b7790116b7a776e2b0f5dc2b382cc44b~1b6_qHC5E0074700747epoutp027;
        Thu,  9 Nov 2017 14:00:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20171109140050epoutp02b7790116b7a776e2b0f5dc2b382cc44b~1b6_qHC5E0074700747epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1510236050;
        bh=p/y61J0BJZWMiFSdig27UK9xKqb61FFs0ZMfQOiyRcg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=pZ2oCaDDSIDNzKFqCYJhu6sjRXNc5FTUov6dK+EjgvJ9OEyakrQI2xAG2/qo7xt+1
         HJ3nxojvqab4u33EGDTcRSdQznQIpUdITJGt9yY1zBgfkcBn2LzKfE/W+G8SQvnKKl
         1ntE8GG7nic9M6IhIAT4+qqdi8qXfgyKcPrTnXhI=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20171109140049epcas2p222a1e14c3d276cc9d0ae7ff2c65a202e~1b6_H3nFy2988529885epcas2p26;
        Thu,  9 Nov 2017 14:00:49 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.30.04158.19F540A5; Thu,  9 Nov 2017 23:00:49 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20171109140048epcas2p3b9077f49a91c0cb3b51ec91132731776~1b68910v51649216492epcas2p3E;
        Thu,  9 Nov 2017 14:00:48 +0000 (GMT)
X-AuditID: b6c32a48-905ff7000000103e-19-5a045f91835e
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.2F.03859.09F540A5; Thu,  9 Nov 2017 23:00:48 +0900 (KST)
Received: from amdc3058.localnet ([106.120.53.102]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0OZ500H5ILLB2NA0@mmp1.samsung.com>; Thu, 09 Nov 2017
        23:00:48 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@mips.com>,
        dri-devel@lists.freedesktop.org,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 3/5] Documentation: Add device tree binding for
 Goldfish FB driver
Date:   Thu, 09 Nov 2017 15:00:46 +0100
Message-id: <2050272.eLOeq0HGv7@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1509729730-26621-4-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7bCmhe7EeJYog0nNmha9504yWcz9uILF
        4t3eqSwW84+cY7U43dzPbHHl63s2i8XvfCy2btrLZnF51xw2iwlTJ7FbLL1+kcni1IzpTBZ9
        r48xW3x6cpLF4vDsFewWrXuPsDsIeKyZt4bRY9OqTjaPoyvXMnls//aA1eN+93Emj9dHHrJ4
        3FpzkcXj8ya5AI4oLpuU1JzMstQifbsErowjV5czFfxnqZh2bxdTA+Nsli5GTg4JAROJt/Nm
        M3YxcnEICexglDjUApIAcb4zSiycO5cZpurx0tXsEIndjBJ3V8JUfWWUWLJuDtgsNgEriYnt
        qxhBbBEBc4kJP58ygxQxC2xhkdh35TEbSEJYIFriTcdysCIWAVWJn7u+gjXzCmhKdHw7yg5i
        iwp4SWzZ184EYnMK+Ekc3fcbqkZQ4sfke2A2s4C8xL79U1khbB2Js8fWgT0hITCdXeLjj41A
        mzmAHBeJ7381IV4Qlnh1fAs7hC0t8WzVRkYIezqjxPbfEhC9mxklVu2eAFVkLXH4+EWoBXwS
        HYf/skPM5JXoaBOCKPGQeNiyGKrcUeLAu3awH4UEnjJKnN/IO4FRdhaSs2chOXsWkrMXMDKv
        YhRLLSjOTU8tNiow0StOzC0uzUvXS87P3cQITk5aHjsYD5zzOcQowMGoxMP7YhVzlBBrYllx
        Ze4hRgkOZiURXpG3QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8dduuRQgJpCeWpGanphakFsFk
        mTg4pRoYs7p42E++6fefxdByVfVCWLr95YbNmp8DCwJn9rP8aJ8+ofCxeX3pwqeHtmc837jh
        sZF83valDIuVi1dPenl29YKb8evl1VPaDjy5wZ3/rU9EvVD6uLpznPyT6T+KXyq6yf6YVXl4
        Qa2B0qZ6s48CLXoXzAy2xqmvPFodELJkxqczeRkK/kedlViKMxINtZiLihMBv0qvqkoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t9jAd0J8SxRBj9OSFn0njvJZDH34woW
        i3d7p7JYzD9yjtXidHM/s8WVr+/ZLBa/87HYumkvm8XlXXPYLCZMncRusfT6RSaLUzOmM1n0
        vT7GbPHpyUkWi8OzV7BbtO49wu4g4LFm3hpGj02rOtk8jq5cy+Sx/dsDVo/73ceZPF4fecji
        cWvNRRaPz5vkAjiiuGxSUnMyy1KL9O0SuDKOXF3OVPCfpWLavV1MDYyzWboYOTkkBEwkHi9d
        zd7FyMUhJLCTUeLvvDYWCOcro8SlvuVsIFVsAlYSE9tXMYLYIgLmEhN+PmUGKWIW2MYi8XBS
        O1iRsEC0xK3JbcwgNouAqsTPXV/BVvAKaEp0fDvKDmKLCnhJbNnXzgRicwr4SRzd9xtq20RG
        iYW77jFBNAhK/Jh8D6yZWUBeYt/+qawQtpbE+p3HmSYw8s9CUjYLSdksJGULGJlXMUqmFhTn
        pucWGxUY5aWW6xUn5haX5qXrJefnbmIERtS2w1r9OxgfL4k/xCjAwajEw+uwljlKiDWxrLgy
        9xCjBAezkgivyFugEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2ampBalFMFkm
        Dk6pBkapHCsPX/tbaUs2LbAX9NwY+fif9Y0Vy+qC+R7eToiLvnZDff3fg9z5oa9LZwas47S1
        cG9b919VtGJdu43p/jWNj64KLVn2OXKB1YotOr+cG15f0WGRemxpWHXF7x+bhFNKxgaFxxH1
        zwRkt89a1ivN/2htrODS+/8fbzLp32Ksbzn3OPvd3XJKLMUZiYZazEXFiQDn/qL9pAIAAA==
X-CMS-MailID: 20171109140048epcas2p3b9077f49a91c0cb3b51ec91132731776
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171109140048epcas2p3b9077f49a91c0cb3b51ec91132731776
X-RootMTR: 20171109140048epcas2p3b9077f49a91c0cb3b51ec91132731776
References: <1509729730-26621-1-git-send-email-aleksandar.markovic@rt-rk.com>
        <1509729730-26621-4-git-send-email-aleksandar.markovic@rt-rk.com>
        <CGME20171109140048epcas2p3b9077f49a91c0cb3b51ec91132731776@epcas2p3.samsung.com>
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60805
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

On Friday, November 03, 2017 06:21:36 PM Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
> 
> Add documentation for DT binding of Goldfish FB driver. The compatible
> string used by OS for binding the driver is "google,goldfish-fb".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
