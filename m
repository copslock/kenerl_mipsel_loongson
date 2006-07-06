Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 16:05:46 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:29019 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S3466417AbWGFPFg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Jul 2006 16:05:36 +0100
Received: by ug-out-1314.google.com with SMTP id k3so2155542ugf
        for <linux-mips@linux-mips.org>; Thu, 06 Jul 2006 08:05:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KjATFb+4IkDMblfk2E/xlQIIqIgnf54EL6Ocx+D2nK83XiI05qIyf/Bm0AVvvQYTaxo0nbznSYKgqtKSCXh/WNOzr9QHaY/6jklk4LTbM26Vkt1glLOtWrkdOOzYJI20Dzk8e/MODsXuOKiwKCVYQ1WUtoDNFHJFy+L0XNN7A0Q=
Received: by 10.67.100.17 with SMTP id c17mr825964ugm;
        Thu, 06 Jul 2006 08:05:35 -0700 (PDT)
Received: by 10.67.100.10 with HTTP; Thu, 6 Jul 2006 08:05:35 -0700 (PDT)
Message-ID: <cda58cb80607060805yc656114p53516b904188c20f@mail.gmail.com>
Date:	Thu, 6 Jul 2006 17:05:35 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] do not count pages in holes with sparsemem
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <44AD2537.1030509@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44ABC59C.6070607@innova-card.com>
	 <20060705.231737.59032119.anemo@mba.ocn.ne.jp>
	 <44AD0C2B.7060204@innova-card.com>
	 <20060706.233634.59465089.anemo@mba.ocn.ne.jp>
	 <44AD2537.1030509@innova-card.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/7/6, Franck Bui-Huu <vagabon.xyz@gmail.com>:
> @@ -207,8 +207,10 @@ #ifndef CONFIG_FLATMEM
>                 for (j = 0; j < zones_size[i]; j++, pfn++)
>                         if (!page_is_ram(pfn))
>                                 zholes_size[i]++;
> -#endif
>         free_area_init_node(0, NODE_DATA(0), zones_size, 0, zholes_size);
> +#else
> +       free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, NULL);

which is equivalent to:

       free_area_init(zones_size);

-- 
               Franck
