Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5UC0onC019565
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 30 Jun 2002 05:00:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5UC0o5j019564
	for linux-mips-outgoing; Sun, 30 Jun 2002 05:00:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-65.ka.dial.de.ignite.net [62.180.196.65])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5UC0jnC019554
	for <linux-mips@oss.sgi.com>; Sun, 30 Jun 2002 05:00:47 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5UC4QT32460
	for linux-mips@oss.sgi.com; Sun, 30 Jun 2002 14:04:26 +0200
Date: Sun, 30 Jun 2002 14:04:26 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Re: [PATCH] We don't need the Indy watchdog twice
Message-ID: <20020630140426.A32252@dea.linux-mips.net>
References: <20020629183411.GW17216@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020629183411.GW17216@lug-owl.de>; from jbglaw@lug-owl.de on Sat, Jun 29, 2002 at 08:34:11PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 29, 2002 at 08:34:11PM +0200, Jan-Benedict Glaw wrote:

> Please apply this patch. It removes a doubled entry from the list of
> supported watchdog drivers. This applies to linux_2_4 __only__.

I deleted the other config line which obviously was braindead ...

  Ralf
