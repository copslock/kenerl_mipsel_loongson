Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 14:17:09 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:2721 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225737AbUDWNRI>;
	Fri, 23 Apr 2004 14:17:08 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i3NDH6Qc027459
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Apr 2004 15:17:06 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i3NDH697027457;
	Fri, 23 Apr 2004 15:17:06 +0200
Date: Fri, 23 Apr 2004 15:17:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Deucher <agd5f@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: few questions about linux on sgi machines
Message-ID: <20040423131706.GA27375@lst.de>
References: <20040422174916.42579.qmail@web11309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422174916.42579.qmail@web11309.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, Apr 22, 2004 at 10:49:16AM -0700, Alex Deucher wrote:
> What about the PCI slots on o200?  Are they supported?

There's is PCI support but there's some problems, mosty because the
Linux support code isn't as nice as it should and we support only
glogic fibre channels and scsi cards and the SGI ioc3 currently.

Fixing that is in-progress but even then you could have problems with
most standard linux drivers because the pci hardware on all systems
using the bridge ASIC and it's sucessors (xbridge, pic) violate some
ordering contraints in the PCI spec.  The SGI folks doing the SN1/SN2
IA64 port have come up with workaround for xbride and pic but I'm not
sure they're applicable to IP27.
