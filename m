Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 05:36:58 +0200 (CEST)
Received: from mail.perches.com ([173.55.12.10]:4328 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491007Ab1G0Dgu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2011 05:36:50 +0200
Received: from [192.168.1.162] (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id 6FCEB24368;
        Tue, 26 Jul 2011 20:36:35 -0700 (PDT)
Subject: Re: MIPS: fix rc32434 pci build error
From:   Joe Perches <joe@perches.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20110727121901.9ef04d00.yuasa@linux-mips.org>
References: <20110727121901.9ef04d00.yuasa@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 26 Jul 2011 20:36:43 -0700
Message-ID: <1311737803.21169.2.camel@Joe-Laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19350

On Wed, 2011-07-27 at 12:19 +0900, Yoichi Yuasa wrote:
> arch/mips/pci/pci-rc32434.c: In function 'rc32434_pci_init':
> arch/mips/pci/pci-rc32434.c:217:16: error: 'rcrc32434_res_pci_io1' undeclared (first use in this function)
> arch/mips/pci/pci-rc32434.c:217:16: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [arch/mips/pci/pci-rc32434.o] Error 1
> This problem is included in the following commit.
>   commit 28f65c11f2ffb3957259dece647a24f8ad2e241b
>   Author: Joe Perches <joe@perches.com>
[]
> diff --git a/arch/mips/pci/pci-rc32434.c b/arch/mips/pci/pci-rc32434.c
[]
>  	io_map_base = ioremap(rc32434_res_pci_io1.start,
> -			      resource_size(&rcrc32434_res_pci_io1));
> +			      resource_size(&rc32434_res_pci_io1));

Sorry 'bout that, not sure how that happened.
