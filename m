Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 19:34:28 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:36103 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133793AbWCMTeT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Mar 2006 19:34:19 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0646A64D3D; Mon, 13 Mar 2006 19:43:18 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 26EF066EB4; Mon, 13 Mar 2006 19:43:02 +0000 (GMT)
Date:	Mon, 13 Mar 2006 19:43:02 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	djohnson+linuxmips@sw.starentnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: Fix for gettimeofday jumping backwards, then forwards.
Message-ID: <20060313194302.GA32432@deprecation.cyrius.com>
References: <20060219222126.GA14543@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219222126.GA14543@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-19 22:21]:
> From: Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
> [MIPS] Fix for gettimeofday jumping backwards, then forwards.

Dave, this patch leads to the following compilation on SB1 1480:

arch/mips/sibyte/swarm/lib.a(setup.o): In function `swarm_time_init':setup.c:(.init.text+0x2b8): undefined reference to `sb1250_hpt_setup'



>  arch/mips/sibyte/sb1250/time.c       |   77 ++++++++++++++++++++++++++---------
>  arch/mips/sibyte/swarm/setup.c       |    7 +++

> +++ new/arch/mips/sibyte/swarm/setup.c	2006-01-16 16:39:27.000000000 +0000
> @@ -70,6 +70,12 @@
>  	return "SiByte " SIBYTE_BOARD_NAME;
>  }
>  
> +void __init swarm_time_init(void)
> +{
> +	/* Setup HPT */
> +	sb1250_hpt_setup();
> +}
> +
...

-- 
Martin Michlmayr
http://www.cyrius.com/
