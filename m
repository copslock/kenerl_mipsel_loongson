Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2004 12:22:06 +0000 (GMT)
Received: from p508B763E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.62]:48934
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225489AbUCTMWF>; Sat, 20 Mar 2004 12:22:05 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2KCM3Mk000885;
	Sat, 20 Mar 2004 13:22:03 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2KCM1RY000884;
	Sat, 20 Mar 2004 13:22:01 +0100
Date: Sat, 20 Mar 2004 13:22:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Martin C. Barlow" <mips@martin.barlow.name>
Cc: linux-mips@linux-mips.org
Subject: Re: hwclock and df seg fault
Message-ID: <20040320122201.GA32242@linux-mips.org>
References: <000201c40e62$e9d104f0$6500a8c0@colombia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201c40e62$e9d104f0$6500a8c0@colombia>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 20, 2004 at 09:05:40PM +1100, Martin C. Barlow wrote:

> I have an old SGI indy R4600 and have installed debian testing with
> latest linux-mips cvs kernel. I found two problems with the programs
> hwclock and df. Apart from that appears to work fine. I have included
> their output. I don't know if it is a kernel or package problem. I don't
> know if it as something to do with preemtible kernel which I enabled in
> kernel. If anyone is interested and wants to see kernel .config, fstab
> or anything else I'm happy to oblidge.

Standard flame - what kernel version?

I checked in the last fixes for the preemptible kernel less than two days
ago so if your kernel is older than that it's time to update :-)

  Ralf
