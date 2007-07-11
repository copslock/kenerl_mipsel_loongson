Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 21:53:55 +0100 (BST)
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:16540 "HELO
	smtp116.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021858AbXGKUxx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jul 2007 21:53:53 +0100
Received: (qmail 87579 invoked from network); 11 Jul 2007 20:52:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=i7PohNNclTU3aj+uL4neYh2KqCs1/wtok5YY/30haXgJbw4RaDuws9J3hwasYdovKZ0kcNPwC2Z0/xB/s8mRMD7onuj1xM3SSydY2Vm7+S+/KJE8UQpHeV362dX1+JnqNYHWqJ5lYXVUxX4pzX5iyWC4TvmvKvE+4a7laAaxSNQ=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.213.6 with plain)
  by smtp116.sbc.mail.sp1.yahoo.com with SMTP; 11 Jul 2007 20:52:45 -0000
X-YMail-OSG: Db0ehBAVM1me69JoW8VtzC737jYNC7Gx08FOmjjxSrDRthmOrVP2Nsd..83AiIPB66mIoC6r_A--
From:	David Brownell <david-b@pacbell.net>
To:	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Date:	Wed, 11 Jul 2007 13:52:43 -0700
User-Agent: KMail/1.9.6
Cc:	Christoph Hellwig <hch@lst.de>,
	Domen Puncer <domen.puncer@telargo.com>,
	linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tnt.com>,
	linux-mips@linux-mips.org
References: <20070711093113.GE4375@moe.telargo.com> <200707111002.55119.david-b@pacbell.net> <20070711203454.GC2301@flint.arm.linux.org.uk>
In-Reply-To: <20070711203454.GC2301@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707111352.44135.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Wednesday 11 July 2007, Russell King wrote:
> 
> IOW, talk to me and I'll talk back.  Ignore me and I'll ignore them.

Exactly why I cc'd you ... if folk want any more sharable
cross-platform code than just the clk.h interface, I expect
you'll have useful comments.

- Dave
