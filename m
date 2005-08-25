Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2005 16:54:49 +0100 (BST)
Received: from MAIL.13thfloor.at ([IPv6:::ffff:212.16.62.50]:12489 "EHLO
	mail.13thfloor.at") by linux-mips.org with ESMTP
	id <S8225439AbVHYPyd>; Thu, 25 Aug 2005 16:54:33 +0100
Received: by mail.13thfloor.at (Postfix, from userid 1001)
	id A4DB13FC3F; Thu, 25 Aug 2005 18:00:07 +0200 (CEST)
Date:	Thu, 25 Aug 2005 18:00:07 +0200
From:	Herbert Poetzl <herbert@13thfloor.at>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kishore K <hellokishore@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Preemption patch for 2.4.26 - mips
Message-ID: <20050825160007.GA24413@MAIL.13thfloor.at>
References: <f07e6e050825065756c3ac27@mail.gmail.com> <20050825153219.GB2731@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825153219.GB2731@linux-mips.org>
User-Agent: Mutt/1.5.6i
Return-Path: <herbert@13thfloor.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@13thfloor.at
Precedence: bulk
X-list: linux-mips

On Thu, Aug 25, 2005 at 04:32:19PM +0100, Ralf Baechle wrote:
> On Thu, Aug 25, 2005 at 07:57:48PM +0600, Kishore K wrote:
> 
> > When I try to compile 2.4.26 kernel with the pre-emption patch from
> > (http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/)
> > for malta board based on MIPS 4kc, compilation fails with the
> > following error.
> 
> Straight Kernel.org kernels don't work for MIPS 

any reason why that is so?
is it planned to make at least 2.6.x work for MIPS?
does it make sense to help there?

TIA,
Herbert

> nor do the mentioned patches.

> 
>   Ralf
