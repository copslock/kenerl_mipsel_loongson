Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7JDrtRw010319
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 19 Aug 2002 06:53:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7JDrt73010318
	for linux-mips-outgoing; Mon, 19 Aug 2002 06:53:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-5-cust12.swa.cable.ntl.com [80.5.121.12])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7JDroRw010308
	for <linux-mips@oss.sgi.com>; Mon, 19 Aug 2002 06:53:51 -0700
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.2/8.11.6) with ESMTP id g7JDuPu6019757;
	Mon, 19 Aug 2002 14:56:26 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.2/8.12.2/Submit) id g7JDuOxe019755;
	Mon, 19 Aug 2002 14:56:24 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: CVS Update@oss.sgi.com: linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020819151339.14441F-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1020819151339.14441F-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 14:56:23 +0100
Message-Id: <1029765383.19375.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-08-19 at 14:22, Maciej W. Rozycki wrote:
>  Hmm, does such hardware already exist?  I don't think it's reasonable to
> make some code available to a user in a configuration that will never make
> use of it.  E.g. a plain TURBOchannel box (or one with no I/O bus) won't
> ever see a native ATA device (SCSI to ATA bridges obviously don't count). 
> I'll check if the code builds at all. 

Sure. There are embedded devices with onboard IDE controller logic. I
don't know about in mipsdom but certainly elsewhere.

I'm not aware of turdochannel IDE but there is a homebrew QBUS IDE
project
