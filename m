Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2006 22:13:26 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:18348 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039009AbWKOWNV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2006 22:13:21 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 3D859E4053;
	Wed, 15 Nov 2006 15:40:44 -0800 (PST)
Subject: Re: Portmap on the Encore M3
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061114191156.GA7299@linux-mips.org>
References: <1163443607.6532.9.camel@sandbar.kenati.com>
	 <20061113233802.GA17130@linux-mips.org>
	 <1163469787.6532.26.camel@sandbar.kenati.com>
	 <20061114130503.GB28579@linux-mips.org>
	 <1163528890.6513.4.camel@sandbar.kenati.com>
	 <20061114191156.GA7299@linux-mips.org>
Content-Type: text/plain
Date:	Wed, 15 Nov 2006 14:24:41 -0800
Message-Id: <1163629481.7321.4.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I m trying to understand exactly how the serial driver works -- and also
the early console initialisation.  I m reading the following websites:

An article called Serial consoles and console drivers by Alassandro
Rubini at http://www.linux.it/~rubini/docs/sercons/sercons.html 

the serial driver Wiki at :
http://www.linux-mips.org/wiki/Serial_Driver_and_Console
and links given on this wiki..

However I havent found a resource that talks about these two processes,
early serial console initialisation and invocation of the serial driver,
in enough detail to give an idea about the processes set into action
when messages are put out to the console..

Can you point me to any other useful links on this issue?

Thank you.
Regards,

Ashlesha.

On Tue, 2006-11-14 at 19:11 +0000, Ralf Baechle wrote:
> On Tue, Nov 14, 2006 at 10:28:10AM -0800, Ashlesha Shintre wrote:
> 
> > > Use CONFIG_SERIAL_AU1X00.
> > 
> > --But I want to use standard 16550 compatible serial port, controlled by
> > the Super I/O Controller on the VIA Southbridge.. The
> > CONFIG_SERIAL_AU1x00 will not be able to drive this port will it?
> 
> Ah, no.  But that's an unusual configuration.  In general Alchemy
> systems only use the on-chip UART which is 8250-ish but just different
> enough that in older Linux versions we used to have a separate
> driver for it.
> 
>   Ralf
