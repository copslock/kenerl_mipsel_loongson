Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2003 17:45:43 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56050 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225218AbTESQpk>;
	Mon, 19 May 2003 17:45:40 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h4JGjYx01511;
	Mon, 19 May 2003 09:45:34 -0700
Date: Mon, 19 May 2003 09:45:34 -0700
From: Jun Sun <jsun@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
	nemoto@toshiba-tops.co.jp, jsun@mvista.com
Subject: Re: please give ieee1394 a chance
Message-ID: <20030519094534.C32567@mvista.com>
References: <20030517.215806.92590717.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030517.215806.92590717.anemo@mba.ocn.ne.jp>; from anemo@mba.ocn.ne.jp on Sat, May 17, 2003 at 09:58:06PM +0900
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Indeed.  This option should be there.

I have heard people get it working or at least trying to get
it working on MIPS.

Jun

On Sat, May 17, 2003 at 09:58:06PM +0900, Atsushi Nemoto wrote:
> Now ieee1394 drivers (at least ohci1394 and sbp2) will work on mips.
> Please give them a chance.
> 
> diff -u linux-mips-cvs/arch/mips/config-shared.in linux.new/arch/mips/
> --- linux-mips-cvs/arch/mips/config-shared.in	Mon May  5 21:31:50 2003
> +++ linux.new/arch/mips/config-shared.in	Sat May 17 21:50:35 2003
> @@ -876,6 +876,8 @@
>  fi
>  endmenu
>  
> +source drivers/ieee1394/Config.in
> +
>  if [ "$CONFIG_PCI" = "y" ]; then
>     source drivers/message/i2o/Config.in
>  fi
> ---
> Atsushi Nemoto
> 
