Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 08:04:08 +0200 (CEST)
Received: from smtp.nokia.com ([192.100.105.134]:34693 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491870AbZGJGEB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2009 08:04:01 +0200
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n6A62mPa011581;
	Fri, 10 Jul 2009 01:03:21 -0500
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by vaebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 09:03:11 +0300
Received: from mgw-da01.ext.nokia.com ([147.243.128.24]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 09:03:10 +0300
Received: from [172.21.42.232] (esdhcp042232.research.nokia.com [172.21.42.232])
	by mgw-da01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n6A633hh001297;
	Fri, 10 Jul 2009 09:03:04 +0300
Subject: Re: mtd related Cobalt build failure with current git
From:	Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	dwmw2@infradead.org, Yoichi Yuasa <yuasa@linux-mips.org>
In-Reply-To: <200907051310.02673.florian@openwrt.org>
References: <20090704213741.GA6438@deprecation.cyrius.com>
	 <200907051310.02673.florian@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:	Fri, 10 Jul 2009 09:03:05 +0300
Message-Id: <1247205785.20721.359.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-1.fc10) 
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2009 06:03:10.0607 (UTC) FILETIME=[1A5A81F0:01CA0124]
X-Nokia-AV: Clean
Return-Path: <dedekind@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind@infradead.org
Precedence: bulk
X-list: linux-mips

On Sun, 2009-07-05 at 13:10 +0200, Florian Fainelli wrote:
> Hi Martin,
> 
> Le Saturday 04 July 2009 23:37:41 Martin Michlmayr, vous avez écrit :
> > I get the following Cobalt build failure with current git:
> >
> >   CC      arch/mips/cobalt/mtd.o
> > cc1: warnings being treated as errors
> > In file included from arch/mips/cobalt/mtd.c:22:
> > include/linux/mtd/partitions.h:50: warning: ‘struct mtd_info’ declared
> > inside parameter list include/linux/mtd/partitions.h:50: warning: its scope
> > is only this definition or declaration, which is probably not what you want
> > include/linux/mtd/partitions.h:51: warning: ‘struct mtd_info’ declared
> > inside parameter list include/linux/mtd/partitions.h:61: warning: ‘struct
> > mtd_info’ declared inside parameter list include/linux/mtd/partitions.h:67:
> > warning: ‘struct mtd_info’ declared inside parameter list make[1]: ***
> > [arch/mips/cobalt/mtd.o] Error 1
> > make: *** [arch/mips/cobalt] Error 2
> >
> > Does anyone know if there's a fix for this already?
> 
> I also had that problem and did the following fix, which still applies to
> the mtd-2.6 tree, master branch.
> --
> From: Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH] Fix arch/mips/cobalt/mtd.c build failure
> 
> This patch fixes a warning in include/linux/mtd/partitions which
> results in the following build failure on MIPS:
>  CC arch/mips/cobalt/mtd.o
> cc1: warnings being treated as errors
> In file included from arch/mips/cobalt/mtd.c:22:
> include/linux/mtd/partitions.h:50: warning: 'struct mtd_info' declared inside parameter list
> include/linux/mtd/partitions.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
> include/linux/mtd/partitions.h:51: warning: 'struct mtd_info' declared inside parameter list
> include/linux/mtd/partitions.h:61: warning: 'struct mtd_info' declared inside parameter list
> include/linux/mtd/partitions.h:67: warning: 'struct mtd_info' declared inside parameter list
> make[1]: *** [arch/mips/cobalt/mtd.o] Error 1
> make: *** [arch/mips/cobalt] Error 2
> 
> Reported-by: Martin Michlmayr <tbm@cyrius.com>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partitions.h
> index af6dcb9..c8eaf44 100644
> --- a/include/linux/mtd/partitions.h
> +++ b/include/linux/mtd/partitions.h
> @@ -10,7 +10,7 @@
>  #define MTD_PARTITIONS_H
>  
>  #include <linux/types.h>
> -
> +#include <linux/mtd/mtd.h>

Can you instead add

a struct mtd_info forward-declaration?

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)
