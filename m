Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 12:32:51 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:2762 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225274AbVBGMce>;
	Mon, 7 Feb 2005 12:32:34 +0000
Received: MO(mo01)id j17CWUPI019467; Mon, 7 Feb 2005 21:32:30 +0900 (JST)
Received: MDO(mdo01) id j17CWTsU011632; Mon, 7 Feb 2005 21:32:30 +0900 (JST)
Received: 4UMRO01 id j17CWSQS010822; Mon, 7 Feb 2005 21:32:28 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date:	Mon, 7 Feb 2005 21:32:27 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yuasa@hh.iij4u.or.jp, ralf@linux-mips.org, nigel@mips.com,
	linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
Message-Id: <20050207213227.29f2d89b.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
	<4203890B.5030305@mips.com>
	<20050204145803.GA5618@linux-mips.org>
	<20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Mon, 07 Feb 2005 19:24:50 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> >>>>> On Fri, 4 Feb 2005 15:58:03 +0100, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> That's not a new feature in the MIPS world; the R10000 family
> ralf> introduced that first and Linux knows how to make use of it.  So
> ralf> now I just need to teach c-r4k.c to check the AR bit on the 24K.
> 
> 20KC Users Manual says it has physically indexed data cache.
> 
> --- linux-mips.org/arch/mips/mm/c-r4k.c	2005-02-07 19:06:54.598390493 +0900
> +++ linux-mips/arch/mips/mm/c-r4k.c	2005-02-07 19:10:38.779771207 +0900
> @@ -1016,6 +1016,8 @@
>  	case CPU_R10000:
>  	case CPU_R12000:
>  		break;
> +	case CPU_20KC:	/* physically indexed */
> +		break;
>  	case CPU_24K:
>  		if (!(read_c0_config7() & (1 << 16)))
>  	default:
> 
> For other MIPS64 core, 5Kc has virtually indexed cache.  How about 25KF?

25Kf also has virtually indexed cache.

Yoichi
