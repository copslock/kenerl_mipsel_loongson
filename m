Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 21:08:44 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:1473 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225262AbVAVVIi>; Sat, 22 Jan 2005 21:08:38 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1CsSUm-0005EQ-LT; Sat, 22 Jan 2005 15:08:36 -0600
Message-ID: <41F2C244.1090701@realitydiluted.com>
Date:	Sat, 22 Jan 2005 15:14:44 -0600
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To:	Manish Lachwani <mlachwani@mvista.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Support for backplane on TX4927 based board
References: <20050122172338.GA23536@prometheus.mvista.com>
In-Reply-To: <20050122172338.GA23536@prometheus.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:
> 
> Attached patch implements support for backplane on TX4927 based board. Please review and/or apply
>
> Index: linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
> ===================================================================
> --- linux-2.6.10.orig/arch/mips/tx4927/common/tx4927_setup.c
> +++ linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
> @@ -129,8 +129,6 @@
>  	return;
>  }
>  
> -indent: Standard input:25: Error:Unexpected end of file
> -
>  void
>  dump_cp0(char *key)
>  {

Looks like the last part of your patch is missing. Pleae resend and I will
go ahead and apply your other big endian patch for TX4927 PCI. Thanks.

-Steve
