Received:  by oss.sgi.com id <S553786AbRAaXEt>;
	Wed, 31 Jan 2001 15:04:49 -0800
Received: from rachael.franken.de ([193.175.24.38]:22791 "EHLO
        rachael.franken.de") by oss.sgi.com with ESMTP id <S553772AbRAaXEf>;
	Wed, 31 Jan 2001 15:04:35 -0800
Received: by rachael.franken.de 
	for linux-mips@oss.sgi.com
	id m14O6Ib-0027yoC; Thu, 1 Feb 2001 00:04:25 +0100 (MET)
Received: from dns.franken.de(193.175.24.33), claiming to be "chico.franken.de"
 via SMTP by rachael.franken.de, id smtpdAAAa25864; Thu Feb  1 00:03:32 2001
Received: by chico.franken.de with UUCP 
	for linux-mips@oss.sgi.com
	id m14O6Hk-003350C; Thu, 1 Feb 2001 00:03:32 +0100 (MET)
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA02740;
	Wed, 31 Jan 2001 23:59:30 +0100
Date:   Wed, 31 Jan 2001 23:59:29 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/MIPS Development <linux-mips@oss.sgi.com>,
        Sam Creasey <sammy@oh.verio.com>
Subject: Re: sonic driver for 2.4.0-test10-pre5 (fwd)
Message-ID: <20010131235929.A2675@alpha.franken.de>
References: <Pine.GSO.4.10.10101310812580.27884-100000@escobaria.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.10.10101310812580.27884-100000@escobaria.sonytel.be>; from geert@linux-m68k.org on Wed, Jan 31, 2001 at 08:15:13AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 31, 2001 at 08:15:13AM +0100, Geert Uytterhoeven wrote:
> 
> When cleaning up my patchqueue I noticed this patch also contains some fixes
> (e.g. netif_*() updates) for the Olivetti M700-10 Risc PC sonic driver
> (sonic.c). Probably this driver is in bad shape anyway, since it's not
> mentioned in drivers/net/Makefile?

it's not in the Makefile, because the MIPS part of the driver hasn't been
merged. And I haven't even powered up the M700 for over a year... 

So I'd say forget the M700 part, the last time I looked, there was more code,
which looks non working for it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                 [ Alexander Viro on linux-kernel ]
