Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2003 23:44:23 +0000 (GMT)
Received: from p508B60ED.dip.t-dialin.net ([IPv6:::ffff:80.139.96.237]:5852
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226077AbTKYXoL>; Tue, 25 Nov 2003 23:44:11 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAPNi5A0013504;
	Wed, 26 Nov 2003 00:44:05 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAPNi42Z013503;
	Wed, 26 Nov 2003 00:44:04 +0100
Date: Wed, 26 Nov 2003 00:44:04 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Wolfgang Denk <wd@denx.de>, Colin.Helliwell@Zarlink.Com,
	linux-mips@linux-mips.org
Subject: Re: Compressed kernels
Message-ID: <20031125234404.GG11047@linux-mips.org>
References: <20031120223335.03BFFC5F5F@atlas.denx.de> <3FBD4529.3070201@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBD4529.3070201@embeddededge.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 20, 2003 at 05:50:17PM -0500, Dan Malek wrote:

> Just to keep us busy, there are people that chose options
> other than u-boot :-)  For embedded systems that are really sensitive
> to boot time and amount of flash used, they may only have minimal
> instructions for processor initialization and then jump to the
> compressed kernel image.  I'm not going to discuss boot roms any
> further (yes, I use u-boot every chance I get).

... the lesson I learned about firmware is it's usually not very well
tested because there are only few applications (that is usually
operating systems) running it.  Phear da firmware ...

  Ralf
