Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2005 11:36:09 +0100 (BST)
Received: from admin.voldemort.codesourcery.com ([IPv6:::ffff:65.74.133.9]:33731
	"EHLO mail.codesourcery.com") by linux-mips.org with ESMTP
	id <S8225205AbVFNKfy>; Tue, 14 Jun 2005 11:35:54 +0100
Received: (qmail 28295 invoked from network); 14 Jun 2005 10:35:50 -0000
Received: from localhost (127.0.0.1)
  by mail.codesourcery.com with SMTP; 14 Jun 2005 10:35:50 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	Jim Gifford <maillist@jg555.com>
Mail-Followup-To: Jim Gifford <maillist@jg555.com>,Daniel Jacobowitz <dan@debian.org>,  Christoph Hellwig <hch@lst.de>,  "Maciej W. Rozycki" <macro@linux-mips.org>,  Linux MIPS List <linux-mips@linux-mips.org>, richard@codesourcery.com
Cc:	Daniel Jacobowitz <dan@debian.org>, Christoph Hellwig <hch@lst.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building o32 glibc on mips64
References: <42AB3366.8030206@jg555.com>
	<20050613195602.GA3739@nevyn.them.org>
	<Pine.LNX.4.61L.0506132100080.1725@blysk.ds.pg.gda.pl>
	<20050613200820.GA29872@lst.de>
	<20050613205558.GA26829@nevyn.them.org> <42AE8E85.4080708@jg555.com>
Date:	Tue, 14 Jun 2005 11:36:12 +0100
In-Reply-To: <42AE8E85.4080708@jg555.com> (Jim Gifford's message of "Tue, 14
	Jun 2005 01:00:05 -0700")
Message-ID: <87vf4hb4yr.fsf@firetop.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

Jim Gifford <maillist@jg555.com> writes:
> From my understanding it's only supported when using IRIX shared 
> libraries, but the standard MIPS64 still only builds n32 and n64 only, 
> and not the o32 libraries.

No, that's not true (assuming "MIPS64" == mips64-linux-gnu).
What makes you think so?

Richard
