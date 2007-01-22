Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2007 13:58:01 +0000 (GMT)
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:24540 "EHLO
	vulpecula.futurs.inria.fr") by ftp.linux-mips.org with ESMTP
	id S28574956AbXAVN5z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Jan 2007 13:57:55 +0000
Received: from [193.51.235.222] (unknown [193.51.235.222])
	by vulpecula.futurs.inria.fr (Postfix) with ESMTP
	id D7E2162409; Mon, 22 Jan 2007 14:54:42 +0100 (CET)
Message-ID: <45B4C2DA.8020906@lifl.fr>
Date:	Mon, 22 Jan 2007 14:57:46 +0100
From:	=?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@lifl.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20070105)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	akpm@osdl.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
References: <20070118160338.GA6343@linux-mips.org>	<20070118135326.c0238873.akpm@osdl.org>	<20070119.121910.96686038.nemoto@toshiba-tops.co.jp> <20070119.125751.104030382.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070119.125751.104030382.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <Eric.Piel@lifl.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Eric.Piel@lifl.fr
Precedence: bulk
X-list: linux-mips

01/19/2007 04:57 AM, Atsushi Nemoto wrote/a écrit:
> On Fri, 19 Jan 2007 12:19:10 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>> OK, here is a revised patch which uses pci= option instead of config
>> parameters.
> 
> Sorry, this patch would cause build failure if setup-bus.c was not
> built into kernel.  Revised again.
> 
> 
> Subject: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
> 
> CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> might result in allocation failure for the reserving itself on some
> platforms (for example typical 32bit MIPS).  Make it (and
> CARDBUS_IO_SIZE too) customizable by "pci=" option for such platforms.
:
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 25d2985..ace7a9a 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1259,6 +1259,12 @@ and is between 256 and 4096 characters. 
>  				This sorting is done to get a device
>  				order compatible with older (<= 2.4) kernels.
>  		nobfsort	Don't sort PCI devices into breadth-first order.
> +		cbiosize=nn[KMG]	A fixed amount of bus space is
> +				reserved for CardBus bridges.
> +				The default value is 256 bytes.
> +		cbmemsize=nn[KMG]	A fixed amount of bus space is
> +				reserved for CardBus bridges.
> +				The default value is 64 megabytes.
Hi, I've got the feeling that those two parameters don't do the same 
things, although they have the same description ;-) Maybe the texts 
could be:
* The fixed amount of bus space which is reserved for the CardBus 
bridges IO window.
* The fixed amount of bus space which is reserved for the CardBus 
bridges memory window.

See you,
Eric
