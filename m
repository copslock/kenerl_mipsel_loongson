Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2007 22:28:57 +0000 (GMT)
Received: from mo32.po.2iij.NET ([210.128.50.17]:21065 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20031681AbXKDW2t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Nov 2007 22:28:49 +0000
Received: by mo.po.2iij.net (mo32) id lA4MRTqD015970; Mon, 5 Nov 2007 07:27:29 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id lA4MRNei008200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Nov 2007 07:27:24 +0900
Date:	Mon, 5 Nov 2007 07:27:23 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] iounmap if in vr41xx_pciu_init() pci clock is over
 33MHz
Message-Id: <20071105072723.0f5abee3.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <472DB446.3020804@tiscali.nl>
References: <472DB446.3020804@tiscali.nl>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Sun, 04 Nov 2007 13:00:06 +0100
Roel Kluin <12o3l@tiscali.nl> wrote:

> iounmap if pci clock is over 33MHz
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Acked-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

> ---
> diff --git a/arch/mips/pci/pci-vr41xx.c b/arch/mips/pci/pci-vr41xx.c
> index 240df9e..33c4f68 100644
> --- a/arch/mips/pci/pci-vr41xx.c
> +++ b/arch/mips/pci/pci-vr41xx.c
> @@ -154,6 +154,7 @@ static int __init vr41xx_pciu_init(void)
>  		pciu_write(PCICLKSELREG, QUARTER_VTCLOCK);
>  	else {
>  		printk(KERN_ERR "PCI Clock is over 33MHz.\n");
> +		iounmap(pciu_base);
>  		return -EINVAL;
>  	}
>  
> 
> 
