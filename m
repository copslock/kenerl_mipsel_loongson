Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2007 15:17:47 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:41608 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28574335AbXAVPRn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2007 15:17:43 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 591293EC9; Mon, 22 Jan 2007 07:17:37 -0800 (PST)
Message-ID: <45B4D592.9050703@ru.mvista.com>
Date:	Mon, 22 Jan 2007 18:17:38 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	Eric.Piel@lifl.fr, akpm@osdl.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
References: <20070119.121910.96686038.nemoto@toshiba-tops.co.jp>	<20070119.125751.104030382.nemoto@toshiba-tops.co.jp>	<45B4C2DA.8020906@lifl.fr> <20070122.233251.74752372.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070122.233251.74752372.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> Subject: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
> 
> CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> might result in allocation failure for the reserving itself on some
> platforms (for example typical 32bit MIPS).  Make it (and
> CARDBUS_IO_SIZE too) customizable by "pci=" option for such platforms.

    Sorry for grammatic nitpicking. :-)

> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 25d2985..dc39989 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1259,6 +1259,12 @@ and is between 256 and 4096 characters.
>  				This sorting is done to get a device
>  				order compatible with older (<= 2.4) kernels.
>  		nobfsort	Don't sort PCI devices into breadth-first order.
> +		cbiosize=nn[KMG]	The fixed amount of bus space which is
> +				reserved for the CardBus bridges IO window.

    It shoyld be "bridge's"...

> +				The default value is 256 bytes.
> +		cbmemsize=nn[KMG]	The fixed amount of bus space which is
> +				reserved for the CardBus bridges memory window.

    Ditto.

> +				The default value is 64 megabytes.
>  

MBR, Sergei
