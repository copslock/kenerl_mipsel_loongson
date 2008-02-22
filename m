Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Feb 2008 19:02:12 +0000 (GMT)
Received: from NaN.false.org ([208.75.86.248]:42914 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S28578404AbYBVTCK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Feb 2008 19:02:10 +0000
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id D5FD098259;
	Fri, 22 Feb 2008 19:02:08 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id C089C981FC;
	Fri, 22 Feb 2008 19:02:08 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1JSd9s-0002H6-6U; Fri, 22 Feb 2008 14:02:08 -0500
Date:	Fri, 22 Feb 2008 14:02:08 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	robert song <robertsong.linux@gmail.com>, linux-mips@linux-mips.org
Subject: Re: MIPS section alignment of object file
Message-ID: <20080222190208.GA8697@caradoc.them.org>
References: <3e004f8e0802210812k723a11f5ve9fa816d83bb082b@mail.gmail.com> <20080222122926.GB17312@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080222122926.GB17312@linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 22, 2008 at 12:29:26PM +0000, Ralf Baechle wrote:
> The minimum alignment technically required is the largest alignment of
> any type contained in a section.  Due to the possibility of relocatable
> links the assembler can't know what the largest aligment is, so it has
> to make a reasonable guess which would be 8 bytes, the size of a double
> floating point.

That's not really true.  The compiler is responsible for emitting
appropriate .align directives to communicate this.  I don't remember
where the hack in gas came from, but I bet it's required for IRIX.

-- 
Daniel Jacobowitz
CodeSourcery
