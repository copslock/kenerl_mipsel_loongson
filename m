Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 15:49:44 +0100 (BST)
Received: from fed1rmmtao10.cox.net ([IPv6:::ffff:68.230.241.29]:52408 "EHLO
	fed1rmmtao10.cox.net") by linux-mips.org with ESMTP
	id <S8225213AbUJVOth>; Fri, 22 Oct 2004 15:49:37 +0100
Received: from opus ([68.107.143.141]) by fed1rmmtao10.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041022144639.DKYI25594.fed1rmmtao10.cox.net@opus>;
          Fri, 22 Oct 2004 10:46:39 -0400
Date: Fri, 22 Oct 2004 07:46:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.9] KSEG/CKSEG fixes
Message-ID: <20041022144639.GE1532@smtp.west.cox.net>
References: <20041021001427.GA25441@smtp.west.cox.net> <20041021070921.GA2297@umax645sx> <20041021144815.GB25441@smtp.west.cox.net> <20041022122146.GB27961@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022122146.GB27961@linux-mips.org>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 22, 2004 at 02:21:46PM +0200, Ralf Baechle wrote:
> On Thu, Oct 21, 2004 at 07:48:15AM -0700, Tom Rini wrote:
> 
> > Would this include abstracting the notion of KSEG1/CKSEG1 into something
> > where one name would get the right var on 32 or 64 ?  If so, is this in
> > CVS now?  If not, wouldn't it make sense to put this in now and convert
> > it when the changes do go in?
> 
> The plan was to use K0BASE / K1BASE and define them as appropriate for
> a platform.  KSEG0 / KSEG1 / KSEG2 would always be 32-bit constants and
> CKSEG0/1/2 always 64-bit.  Somebody recently screwed the latter with a
> checkin.

Ah, that makes sense.  I'll wait for it to show up in HEAD.

-- 
Tom Rini
http://gate.crashing.org/~trini/
