Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2003 14:47:32 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:1546
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225466AbTK1Bhx>; Fri, 28 Nov 2003 01:37:53 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Nov 2003 01:38:22 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hAS1c9nd020200;
	Fri, 28 Nov 2003 10:38:10 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 28 Nov 2003 10:41:01 +0900 (JST)
Message-Id: <20031128.104101.48536414.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: please give ieee1394 a chance
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030517.215806.92590717.anemo@mba.ocn.ne.jp>
References: <20030517.215806.92590717.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

It's been a long time since I posted this request.  I believe there is
no reason to omit ieee1394 on mips.  Please add the line to 2.4 tree.
Thank you.

>>>>> On Sat, 17 May 2003 21:58:06 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
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
---
Atsushi Nemoto
