Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 12:59:18 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:33445 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225329AbUKIM7O>;
	Tue, 9 Nov 2004 12:59:14 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id iA9CxCla006236
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Nov 2004 13:59:12 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id iA9CxC2O006234;
	Tue, 9 Nov 2004 13:59:12 +0100
Date: Tue, 9 Nov 2004 13:59:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Function / prototype mismatch
Message-ID: <20041109125912.GA6222@lst.de>
References: <200411091328.42360.thomas.koeller@baslerweb.com> <20041109124547.GA5766@lst.de> <20041109125418.GC5652@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109125418.GC5652@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Tue, Nov 09, 2004 at 01:54:18PM +0100, Ralf Baechle wrote:
> On Tue, Nov 09, 2004 at 01:45:47PM +0100, Christoph Hellwig wrote:
> 
> > <hint>
> > might be worse to switch mips to the generic kernel/irq/ code
> > whicg gets this right
> > </hint>
> 
> <hint>
> This has long happened and generic irq code doesn't even cover do_IRQ.

Well, 90% of it as __do_IRQ ;-)
