Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2002 05:14:55 +0200 (CEST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:50193 "HELO
	topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S1123898AbSJCDOz>; Thu, 3 Oct 2002 05:14:55 +0200
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [80.63.7.146]) with SMTP; 3 Oct 2002 03:14:53 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 038B4B46B; Thu,  3 Oct 2002 12:14:38 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA05174; Thu, 3 Oct 2002 12:14:38 +0900 (JST)
Date: Thu, 03 Oct 2002 12:17:05 +0900 (JST)
Message-Id: <20021003.121705.74756199.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: CVS Update@ftp.linux-mips.org: linux
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20020930165347Z1122169-9213+249@linux-mips.org>
References: <20020930165347Z1122169-9213+249@linux-mips.org>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 30 Sep 2002 18:53:47 +0200, ralf@linux-mips.org said:
> Log message:
> 	More cache code cleanup.

This commit contains following change.  It seems 'addr' argument is
not used.  Isn't this a mistake?

> @@ -123,15 +72,14 @@ static inline void protected_flush_icach
>  	__asm__ __volatile__(
>  		".set noreorder\n\t"
>  		".set mips3\n"
> -		"1:\tcache %1,(%0)\n"
> +		"1:\tcache %0,(%1)\n"
>  		"2:\t.set mips0\n\t"
>  		".set reorder\n\t"
>  		".section\t__ex_table,\"a\"\n\t"
>  		STR(PTR)"\t1b,2b\n\t"
>  		".previous"
>  		:
> -		: "r" (addr),
> -		  "i" (Hit_Invalidate_I));
> +		: "i" (Hit_Invalidate_I), "i" (Hit_Invalidate_I));
>  }

---
Atsushi Nemoto
