Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5GI6dj06380
	for linux-mips-outgoing; Sat, 16 Jun 2001 11:06:39 -0700
Received: from dea.waldorf-gmbh.de (u-169-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.169])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5GI6ZZ06377
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 11:06:36 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5GI6NX23050;
	Sat, 16 Jun 2001 20:06:23 +0200
Date: Sat, 16 Jun 2001 20:06:23 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Klaus Naumann <spock@mgnet.de>
Cc: Linux/MIPS list <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Make serial console more friendly
Message-ID: <20010616200623.A22976@bacchus.dhis.org>
References: <Pine.LNX.4.21.0106161714100.16303-200000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106161714100.16303-200000@spock.mgnet.de>; from spock@mgnet.de on Sat, Jun 16, 2001 at 05:21:18PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 16, 2001 at 05:21:18PM +0200, Klaus Naumann wrote:

> after a long time of being busy and absent from Linux/MIPS
> I got around hacking a bit again.
> Attached is what came out of this. The patch will make it possible
> to use any (supported!) speed for the serial console.
> How to use: Apply against any recent 2.4 cvs kernel, compile. 
> In the PROM command monitor type "setenv dbaud 38400" (now you probably
> need to change the serial setup of your client, i.e. minicom) and boot the
> kernel.
> If you're getting strange chars at the login prompt you need
> to change your getty config.
> 
> Ralf: Can you please check and apply the patch ? Thanks !
> (There are also some small code beautifications in the patch)

Applied.

  Ralf
