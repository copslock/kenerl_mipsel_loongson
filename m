Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2004 14:40:55 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:48521 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225234AbUBHOkz>;
	Sun, 8 Feb 2004 14:40:55 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i18EehQc001289
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Feb 2004 15:40:44 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i18Eehes001287;
	Sun, 8 Feb 2004 15:40:43 +0100
Date: Sun, 8 Feb 2004 15:40:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040208144042.GA1236@lst.de>
References: <20040208143438Z8224987-9616+1909@linux-mips.org> <20040208143617.GC699@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208143617.GC699@holomorphy.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Sun, Feb 08, 2004 at 06:36:17AM -0800, William Lee Irwin III wrote:
> > Log message:
> > 	Use the defintion of kern_addr_valid() from Linus tree instead of my variant.
> > 	This allows blaming wli for this POS instead of me ;)
> 
> Hey! That bitmap was uninitialized (apart from being zeroed) in mainline.

I know.  The comment was reffering to replacing a

/* XXX(hch): better get rid of this thingy, it's rather fragile.. */

with an

/* XXX: FIXME -- wli */
