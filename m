Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2KErEI30046
	for linux-mips-outgoing; Wed, 20 Mar 2002 06:53:14 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2KErA930043
	for <linux-mips@oss.sgi.com>; Wed, 20 Mar 2002 06:53:11 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 16nhjK-0002VT-00; Wed, 20 Mar 2002 15:10:22 +0000
Subject: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)
To: fxzhang@ict.ac.cn (Zhang Fuxin)
Date: Wed, 20 Mar 2002 15:10:22 +0000 (GMT)
Cc: girishvg@yahoo.com (Girish Gulawani),
   linux-mips@oss.sgi.com (linux-mips@oss.sgi.com)
In-Reply-To: <200203201444.g2KEi6929835@oss.sgi.com> from "Zhang Fuxin" at Mar 20, 2002 10:46:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nhjK-0002VT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> executed. With a x86 emulator we are able to use Riva TNT2,and probably
> more can work. Unfortunately that emulator is an executable from Algor,
> as a kindly help. We can't get more control on it and finally give up.

There is a BIOS emulator for booting video cards included (full source)
in the XFree86 4.x distribution. It seems to work with a fair range of
cards

Alan
