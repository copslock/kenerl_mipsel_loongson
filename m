Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 19:41:47 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.180]:43489 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20039281AbWI2Slp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 19:41:45 +0100
Received: by py-out-1112.google.com with SMTP id i49so80123pyi
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 11:41:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=jtBviq50U77afCkbNi16U022731rWjrKJCwIz3qiXbItv4r/NokZVJNf/v/S54kIqbLbIOzn0xX3n5EmA1AEKqA5+jM/gaZqtGFPYgKxmzbwEEjtnsiLWNBT/2jgn5KLYDcGzC3hecF49Ca+d8JvuYZjnL2gHPIBMFm+o8dQQJ8=
Received: by 10.35.97.1 with SMTP id z1mr966350pyl;
        Fri, 29 Sep 2006 11:41:43 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id 12sm2407604nzn.2006.09.29.11.41.41;
        Fri, 29 Sep 2006 11:41:42 -0700 (PDT)
In-Reply-To: <20060930.033406.104030456.anemo@mba.ocn.ne.jp>
References: <20060930.033406.104030456.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E3B3A030-E8D0-4BC3-8924-E88B3B43E53F@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	girish <girishvg@gmail.com>
Subject: Re: [PATCH] fix size of zones_size and zholes_size array
Date:	Sat, 30 Sep 2006 03:41:39 +0900
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Mailer: Apple Mail (2.749)
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


On Sep 30, 2006, at 3:34 AM, Atsushi Nemoto wrote:

> The commit f06a96844a577c43249fce25809a4fae07407f46 broke mips.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index a624778..2f346d1 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -357,10 +357,10 @@ static int __init page_is_ram(unsigned l
>
>  void __init paging_init(void)
>  {
> -	unsigned long zones_size[] = { 0, };
> +	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
>  	unsigned long max_dma, high, low;
>  #ifndef CONFIG_FLATMEM
> -	unsigned long zholes_size[] = { 0, };
> +	unsigned long zholes_size[MAX_NR_ZONES] = { 0, };
>  	unsigned long i, j, pfn;
>  #endif
>
>

Nemoto~san, this was your patch earlier.

  void __init paging_init(void)
  {
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
  	unsigned long max_dma, high, low;
+#ifdef CONFIG_SPARSEMEM
+	unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
+	unsigned long i, j, pfn;
+#endif
