Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 13:26:17 +0100 (BST)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:16270 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8224827AbTFJM0P>; Tue, 10 Jun 2003 13:26:15 +0100
Received: from [10.1.1.146] (helo=heck)
	by mail.convergence.de with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.14)
	id 19PiCb-0000cL-PP
	for linux-mips@linux-mips.org; Tue, 10 Jun 2003 14:26:13 +0200
Received: from js by heck with local (Exim 3.35 #1 (Debian))
	id 19PiCX-0000JC-00
	for <linux-mips@linux-mips.org>; Tue, 10 Jun 2003 14:26:09 +0200
Date: Tue, 10 Jun 2003 14:26:09 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: Re: Building a stand-alone FS on a very limited flash (newbie  question)
Message-ID: <20030610122609.GC544@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
References: <Pine.GSO.4.44.0306061234410.4045-100000@hydra.mmc.atmel.com> <Pine.GSO.3.96.1030609164009.2806n-100000@delta.ds2.pg.gda.pl> <20030609154408.GA1781@nevyn.them.org> <3EE4C5CF.3050607@galileo.co.il> <20030609165612.GE32450@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609165612.GE32450@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Baruch Chaikin wrote:
> > 
> > I'm using MIPS kernel 2.4.18 with NFS file system mounted on a RedHat 
> > machine. This works fine, but is unsuitable for system deployment. Do 
> > you have hints for me where to start, in order to put the file system on 
> > flash? The platform I'm using is very limited - only one MTD block of 
> > 2.5 MB is available for the file system, out of a 4 MB flash:
> >    0.5 MB is allocated for the firmware code
> >    1.0 MB for the compressed kernel image
> >    2.5 MB for the (compressed?) file system
> > 
> > For example, I've noticed LibC itself is ~5 MB !
> 
> You'll need a smaller libc, dietlibc comes to mind.
> http://www.dietlibc.org/

The diet libc is the first choice when you want it lean and mean.
Best used in combination with Busybox (patch necessary because the
Busybox uses GNU extensions and BSD cruft which the diet libc maintainer
refuses to implement) or embutils (http://fefe.de/).

OTOH, if you want shared library support, stable/working threads or iconv()
you must look elsewhere...


Johannes
