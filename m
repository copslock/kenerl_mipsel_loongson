Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 15:03:35 +0000 (GMT)
Received: from carisma.slowglass.com ([IPv6:::ffff:195.224.96.167]:46602 "EHLO
	phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225213AbTBJPDe>; Mon, 10 Feb 2003 15:03:34 +0000
Received: from hch by phoenix.infradead.org with local (Exim 4.10)
	id 18iFT1-000625-00; Mon, 10 Feb 2003 15:03:31 +0000
Date: Mon, 10 Feb 2003 15:03:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Vivien Chappelier <vivienc@nerim.net>, linux-mips@linux-mips.org,
	Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
Subject: Re: porting arcboot
Message-ID: <20030210150330.A23150@infradead.org>
References: <Pine.LNX.4.21.0302101533410.1709-100000@melkor> <861y2g2n8r.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <861y2g2n8r.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Mon, Feb 10, 2003 at 04:01:40PM +0100
Return-Path: <hch@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 10, 2003 at 04:01:40PM +0100, Juan Quintela wrote:
> >>>>> "vivien" == Vivien Chappelier <vivienc@nerim.net> writes:
> 
> vivien> Thiemo told me that his R10k I2s PROM only loads 64bit executables.
> vivien> Don't know if the rest of IP22 can laod 64bit executables at all.
> 
> I don't think so, mine (I2) only allows ECOFF, ELF is too young for it
> :p

You probably don't have a R10k I2..
