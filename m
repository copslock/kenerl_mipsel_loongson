Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:21:31 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:1811 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133758AbWBTOVW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2006 14:21:22 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id ACE9D64D3D; Mon, 20 Feb 2006 14:28:15 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 16B899011; Mon, 20 Feb 2006 14:28:07 +0000 (GMT)
Date:	Mon, 20 Feb 2006 14:28:07 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060220142807.GM29098@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060219234757.GW10266@deprecation.cyrius.com> <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-02-20 13:33]:
> > -	  If you want to compile this driver as a module ( = code which can be
> > -	  inserted in and removed from the running kernel whenever you want),
> > -	  say M here and read <file:Documentation/modules.txt>.  The module will
> > -	  be called ms02-nv.o.
> > -
>  NAK.

I disagree with you - it's obvious from the name of the config option
(MTD_MS02NV) what the module will be called and people who compile
their own kernels should know.  More importantly, no other description
in this Kconfig file mentions anything like this.  However, since
there seems to be no Kconfig "writing style", I guess it must as well
be added.  But I guess the MTD folks removed it for a reason.

Still NAK, i.e. should I send the following patch to the MTD list, or
ok to remove?


[PATCH] Add information about modules to MTD_MS02NV - sync with linux-mips tree

This synces drivers/mtd/devices/Kconfig with the linux-mips tree by adding
some description about modules to MTD_MS02NV.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

---

--- a/drivers/mtd/devices/Kconfig	2006-02-03 03:07:01.000000000 +0000
+++ b/drivers/mtd/devices/Kconfig	2006-02-19 23:50:11.000000000 +0000
@@ -47,6 +47,11 @@
 	  accelerator.  Say Y here if you have a DECstation 5000/2x0 or a
 	  DECsystem 5900 equipped with such a module.
 
+	  If you want to compile this driver as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module will
+	  be called ms02-nv.o.
+
 config MTD_DATAFLASH
 	tristate "Support for AT45xxx DataFlash"
 	depends on MTD && SPI_MASTER && EXPERIMENTAL


> >  		struct net_device *dev = root_lance_dev;
> >  		struct lance_private *lp = netdev_priv(dev);
> > -
> >  		unregister_netdev(dev);
> >  #ifdef CONFIG_TC
> >  		if (lp->slot >= 0)
> 
>  NAK.

Upated patch sent to netdev.

Thanks.
-- 
Martin Michlmayr
http://www.cyrius.com/
