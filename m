Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 15:01:41 +0100 (CET)
Received: from mailout3.samsung.com ([203.254.224.33]:55248 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991743AbdKIOBcbVsQK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 15:01:32 +0100
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171109140123epoutp030f1016f00829dba9704ce245d9c86154~1b7dlKlNH3066030660epoutp03r;
        Thu,  9 Nov 2017 14:01:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20171109140123epoutp030f1016f00829dba9704ce245d9c86154~1b7dlKlNH3066030660epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1510236083;
        bh=2h4j4N8bLGV5N01o/r/tl6uJjHeLIDG/vGTae8lpGyw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ObdqFdUATvIthZb2zEMseYVHmjWFqN6r+JwuxEp3YrRFXRQoEyVtBQ4VDP6mb+k7e
         jTaWxcXqY2KKIZdtuGlPIYNytjFtx49HEIyL0ujueWCy1r6JY+z/9znMV51WDoFgq8
         qQ+d7q8V+7S79ggAfKbJD7jm61mA39jJlavYSycs=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20171109140123epcas2p1d743c07ad0703014a89712b821369b10~1b7dGeyyr2909729097epcas2p1d;
        Thu,  9 Nov 2017 14:01:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.40.04158.2BF540A5; Thu,  9 Nov 2017 23:01:22 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20171109140122epcas2p306a513c827cc9705364cfa2753088efb~1b7c46p-21489014890epcas2p34;
        Thu,  9 Nov 2017 14:01:22 +0000 (GMT)
X-AuditID: b6c32a48-905ff7000000103e-57-5a045fb2f0d0
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.3F.03859.2BF540A5; Thu,  9 Nov 2017 23:01:22 +0900 (KST)
Received: from amdc3058.localnet ([106.120.53.102]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0OZ500EAQLM95SD0@mmp1.samsung.com>; Thu, 09 Nov 2017
        23:01:22 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>
Subject: Re: [PATCH v8 4/5] video: goldfishfb: Add support for device tree
 bindings
Date:   Thu, 09 Nov 2017 15:01:20 +0100
Message-id: <2028677.JpbK7Rfe55@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1509729730-26621-5-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmue6meJYog7XTrS3mflzBYvFu71QW
        i9PN/cwWi9/5WGzdtJfN4kTfB1aLy7vmsFlMmDqJ3eLK4U9sFqdmTGey6Ht9jNni05OTLBaH
        Z69gd+D16Nl5htHj6Mq1TB6vjzxk8bi15iKLx+dNcgGsUVw2Kak5mWWpRfp2CVwZ73r+sxT0
        slRc2PKerYFxB3MXIyeHhICJxItVt1i7GLk4hAR2MErM6+xigXC+M0o8OXyMBaZq56dHUInd
        jBKzW3vYIZyvjBIf3s4Dm8UmYCUxsX0VI4gtImAuMeHnU2aQImaBK8wSXftmsoEkhAVCJR7t
        bgdrYBFQlXhzejFQAwcHr4CmxKSTTiBhUQEviS372plAbE4BP4lfTY9ZQWxeAUGJH5PvgV3E
        LCAvsW//VFYIW0fi7LF1jCC7JATes0k8PPGYEeJsF4njLQ2sELawxKvjW9ghbGmJZ6s2QtVM
        Z5TY/lsConkzo8Sq3ROgiqwlDh+/CLWBT6Lj8F92kEMlBHglOtqEIEo8JPY/mAFV7iix884e
        JkioPAWaeesD+wRG2VlIDp+F5PBZSA5fwMi8ilEstaA4Nz212KjARK84Mbe4NC9dLzk/dxMj
        OMVoeexgPHDO5xCjAAejEg/vi1XMUUKsiWXFlbmHGCU4mJVEeEXeAoV4UxIrq1KL8uOLSnNS
        iw8xSnOwKInz1m27FiEkkJ5YkpqdmlqQWgSTZeLglGpgnHzucOn5FZ1CRtFa3NbK+Qe8ejb9
        8C28vnZxYctM54gvK1eH313w8R17z0VmntzbGsIJ0fPSIgMSv0lveeP2qbdodk65vZKebknF
        vg3hMVuaTnnwrnw5d/nT8BkJB1NOR3z12v3sUL1yw6Q3U96oNkzdPu2/wRldhqw8xzlynmb7
        959MSppqpcRSnJFoqMVcVJwIAGy8OvQtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t9jAd1N8SxRBhePa1jM/biCxeLd3qks
        Fqeb+5ktFr/zsdi6aS+bxYm+D6wWl3fNYbOYMHUSu8WVw5/YLE7NmM5k0ff6GLPFpycnWSwO
        z17B7sDr0bPzDKPH0ZVrmTxeH3nI4nFrzUUWj8+b5AJYo7hsUlJzMstSi/TtErgy3vX8Zyno
        Zam4sOU9WwPjDuYuRk4OCQETiZ2fHrGA2EICOxkltjbydDFyAdlfGSWavn5hBUmwCVhJTGxf
        xQhiiwiYS0z4+ZQZpIhZ4BqzxOslJ9lAEsICoRKPdreDTWURUJV4c3oxUAMHB6+ApsSkk04g
        YVEBL4kt+9qZQGxOAT+JX02PWSGWPWWUWDFvJVgvr4CgxI/J98AuYhaQl9i3fyorhK0lsX7n
        caYJjPyzkJTNQlI2C0nZAkbmVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsYgRGx7bBW
        /w7Gx0viDzEKcDAq8fA6rGWOEmJNLCuuzD3EKMHBrCTCK/IWKMSbklhZlVqUH19UmpNafIhR
        moNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoFx07kdXBxLzhkuSQ6xudlmaSP4P7nhpU3I
        //5+jaiXOX0LljkLmvOJey0KUXl80PHuHslp+jEuj2bLCG4qfcV3492RpmfPFx62vno+4W2M
        gzPr40afhXnWM2O25knoPDCw6fe4vuzzHUWJ+9+9H+ScFORin6J7wOCEsM3Ng9IB+b0K3zUn
        KYcosRRnJBpqMRcVJwIAOxBOroQCAAA=
X-CMS-MailID: 20171109140122epcas2p306a513c827cc9705364cfa2753088efb
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171103172320epcas2p2c8f7472bd7f9af088d964b006ca04984
X-RootMTR: 20171103172320epcas2p2c8f7472bd7f9af088d964b006ca04984
References: <1509729730-26621-1-git-send-email-aleksandar.markovic@rt-rk.com>
        <CGME20171103172320epcas2p2c8f7472bd7f9af088d964b006ca04984@epcas2p2.samsung.com>
        <1509729730-26621-5-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60806
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

On Friday, November 03, 2017 06:21:37 PM Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
> 
> Add ability to the Goldfish FB driver to be recognized by OS via DT.
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
