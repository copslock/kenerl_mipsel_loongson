Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 14:31:08 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:19873 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225737AbUDWNbH>;
	Fri, 23 Apr 2004 14:31:07 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i3NDV6Qc027727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Apr 2004 15:31:06 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i3NDV6Lb027725;
	Fri, 23 Apr 2004 15:31:06 +0200
Date: Fri, 23 Apr 2004 15:31:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Deucher <agd5f@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: few questions about linux on sgi machines
Message-ID: <20040423133106.GA27699@lst.de>
References: <20040423131706.GA27375@lst.de> <20040423132901.97621.qmail@web11301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423132901.97621.qmail@web11301.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Fri, Apr 23, 2004 at 06:29:01AM -0700, Alex Deucher wrote:
> I assume IP30 has the same problems since they are similarly
> architected?

I guess it has the same problems as it's using the bridge ASIC, too.

> What about IP32?

It uses a completely different pci subsystem that should be okay.
