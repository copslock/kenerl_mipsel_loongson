Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 13:13:41 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:57874
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225007AbULONNg>; Wed, 15 Dec 2004 13:13:36 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFDDNUZ028250;
	Wed, 15 Dec 2004 14:13:23 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFDDMYT028249;
	Wed, 15 Dec 2004 14:13:22 +0100
Date: Wed, 15 Dec 2004 14:13:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Srividya Ramanathan <navaraga@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: unresolved symbol io_remap_page_range
Message-ID: <20041215131322.GB27935@linux-mips.org>
References: <20041215102923.45711.qmail@web54507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215102923.45711.qmail@web54507.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 15, 2004 at 02:29:22AM -0800, Srividya Ramanathan wrote:

>   i had written and compiled a PCI device driver which
> works well for X86 architecture. The same driver when
> compiled for MIPS architecture gives "unresolved
> symbol io_remap_page_range". Is this API deprecated or
> is there any other alternative API for
> io_remap_page_range()

Au contraire.  The API is that new that your kernel doesn't yet have.  It
was introduced in 2.6.10-rc1.

  Ralf
