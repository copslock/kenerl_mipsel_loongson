Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 04:23:25 +0100 (BST)
Received: from mail019.syd.optusnet.com.au ([IPv6:::ffff:210.49.20.160]:45213
	"EHLO mail019.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8224802AbTF3DXT>; Mon, 30 Jun 2003 04:23:19 +0100
Received: from localhost.karma (c17997.eburwd3.vic.optusnet.com.au [210.49.198.98])
	by mail019.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id h5U3N9J23716;
	Mon, 30 Jun 2003 13:23:09 +1000
Received: from satisfactory (satisfactory [192.168.0.1])
	by localhost.karma (Postfix) with ESMTP
	id 134C71C; Mon, 30 Jun 2003 13:23:00 +1000 (EST)
Received: by satisfactory (Postfix, from userid 500)
	id 3752D47A7F; Mon, 30 Jun 2003 13:28:41 +0000 (UTC)
Date: Mon, 30 Jun 2003 13:28:41 +0000
From: Andrew Clausen <clausen@gnu.org>
To: ilya@theIlya.com
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: ip32 timer setup fix
Message-ID: <20030630132841.GD480@gnu.org>
References: <20030630031338.GK13617@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630031338.GK13617@gateway.total-knowledge.com>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Return-Path: <clausen@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@gnu.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 29, 2003 at 08:13:38PM -0700, ilya@theIlya.com wrote:
> diff -u -r1.4 ip32-setup.c
> --- arch/mips/sgi-ip32/ip32-setup.c	14 Apr 2003 16:33:24 -0000	1.4
> +++ arch/mips/sgi-ip32/ip32-setup.c	30 Jun 2003 03:11:05 -0000
> @@ -94,6 +94,7 @@
>  	rtc_ops = &ip32_rtc_ops;
>  	board_be_init = ip32_be_init;
>  	board_time_init = ip32_time_init;
> +	board_timer_setup = ip32_timer_setup();
>  
>  	crime_init ();
>  }

Without even looking at the code... it looks like those () are wrong.
(Is board_timer_setup a function pointer?)  I could be talking
rubbish of course.

Cheers,
Andrew
