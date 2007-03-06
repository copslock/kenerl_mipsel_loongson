Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 18:02:19 +0000 (GMT)
Received: from hancock.steeleye.com ([71.30.118.248]:64204 "EHLO
	hancock.sc.steeleye.com") by ftp.linux-mips.org with ESMTP
	id S20021429AbXCFSCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Mar 2007 18:02:15 +0000
Received: from [172.17.6.40] (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id l26I10x10975;
	Tue, 6 Mar 2007 13:01:00 -0500
Subject: Re: [parisc-linux] [PATCH 1/2] Use a weak symbol for the empty
	version of pcibios_add_platform_entries()
From:	James Bottomley <James.Bottomley@SteelEye.com>
To:	Michael Ellerman <michael@ellerman.id.au>
Cc:	Greg Kroah-Hartman <greg@kroah.com>, linux-mips@linux-mips.org,
	dev-etrax@axis.com, linux-ia64@vger.kernel.org, discuss@x86-64.org,
	chris@zankel.net, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, ink@jurassic.park.msu.ru,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, linux-pci@atrey.karlin.mff.cuni.cz,
	parisc-linux@parisc-linux.org, kernel@wantstofly.org,
	rth@twiddle.net
In-Reply-To: <1173193568.89821.610708199943.qpush@concordia>
References: <1173193568.89821.610708199943.qpush@concordia>
Content-Type: text/plain
Date:	Tue, 06 Mar 2007 12:01:00 -0600
Message-Id: <1173204060.3379.28.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-1.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@SteelEye.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@SteelEye.com
Precedence: bulk
X-list: linux-mips

On Tue, 2007-03-06 at 16:06 +0100, Michael Ellerman wrote:
> I'm not sure if this is going to fly, weak symbols work on the compilers I'm
> using, but whether they work for all of the affected architectures I can't say.
> I've cc'ed as many arch maintainers/lists as I could find.

Well, for your use, PCI already uses weak symbols, so it must work on
every architecture that you want to do it on ...

James
