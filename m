Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 09:51:25 +0100 (BST)
Received: from p508B4F3A.dip.t-dialin.net ([IPv6:::ffff:80.139.79.58]:51855
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225241AbTFEIvX>; Thu, 5 Jun 2003 09:51:23 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h558pMbY032746;
	Thu, 5 Jun 2003 01:51:22 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h558pMtF032745;
	Thu, 5 Jun 2003 10:51:22 +0200
Date: Thu, 5 Jun 2003 10:51:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030605085122.GB25712@linux-mips.org>
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com> <019201c32b40$2d54cf60$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019201c32b40$2d54cf60$10eca8c0@grendel>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2003 at 10:55:10AM +0200, Kevin D. Kissell wrote:

> I personally think it would be foolish to assume that future MIPS 
> MP systems will not be subject to one or more such constraint.

I'm expecting something like hypertransport-based ccNUMAs to bring up
that problem again.

  Ralf
