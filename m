Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g266Uco06439
	for linux-mips-outgoing; Tue, 5 Mar 2002 22:30:38 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g266UZ906431
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 22:30:35 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA05002
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 21:30:18 -0800 (PST)
	mail_from (ladislav.michl@hlubocky.del.cz)
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16iTus-0000iR-00; Wed, 06 Mar 2002 06:24:42 +0100
Date: Wed, 6 Mar 2002 06:24:41 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: a.venturi@cineca.it
cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: boot different kernels on the indy ?!
In-Reply-To: <20020305232521.GA31908@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0203060601520.2409-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Mar 2002, Florian Lohoff wrote:

> There is no doc yet - We have been working on a bootloader which makes
> this easier 
>
> Currently you have to put the ecoff kernel image into the volume header.
> If you have a large enough volume header just compile your kernel
> and put the new one into the volume header under a different name.
> The tool to use is "dvhtool"

boot loader is called arcboot and is well documented - arcboot(8)
atleast unstable contains arcboot-0.3 package.

	ladis
