Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB48EqT16686
	for linux-mips-outgoing; Tue, 4 Dec 2001 00:14:52 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB48Elo16683;
	Tue, 4 Dec 2001 00:14:47 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [216.32.174.27]) with SMTP; 4 Dec 2001 07:14:46 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id A84D8B46D; Tue,  4 Dec 2001 16:14:44 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id QAA44223; Tue, 4 Dec 2001 16:14:44 +0900 (JST)
Date: Tue, 04 Dec 2001 16:19:28 +0900 (JST)
Message-Id: <20011204.161928.28780490.nemoto@toshiba-tops.co.jp>
To: brad@ltc.com
Cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: spurious_count cleanup
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011201004526.A22248@dev1.ltc.com>
References: <20011201004526.A22248@dev1.ltc.com>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

BTW, ".set noreorder" in this code seems dangerous while the jump
instruction is not followed by nop...


> --- arch/mips/kernel/entry.S	2001/11/27 01:26:46	1.32
> +++ arch/mips/kernel/entry.S	2001/11/30 18:42:07
> @@ -95,12 +95,12 @@
>  		 * Someone tried to fool us by sending an interrupt but we
>  		 * couldn't find a cause for it.
>  		 */
> -		lui     t1,%hi(spurious_count)
> +		lui     t1,%hi(irq_err_count)
>  		.set	reorder
> -		lw      t0,%lo(spurious_count)(t1)
> +		lw      t0,%lo(irq_err_count)(t1)
>  		.set	noreorder
>  		addiu   t0,1
> -		sw      t0,%lo(spurious_count)(t1)
> +		sw      t0,%lo(irq_err_count)(t1)
>  		j	ret_from_irq
>  		END(spurious_interrupt)
>  
---
Atsushi Nemoto
