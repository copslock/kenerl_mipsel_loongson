Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 16:14:58 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:45776 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20038622AbXA2QOw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 16:14:52 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1HBZ9e-0000u4-H4; Mon, 29 Jan 2007 11:14:50 -0500
Date:	Mon, 29 Jan 2007 11:14:50 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RFC: Sentosa boot fix
Message-ID: <20070129161450.GA3384@nevyn.them.org>
References: <20070128180807.GA18890@nevyn.them.org> <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com> <20070129155253.GA2070@nevyn.them.org> <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 29, 2007 at 05:06:39PM +0100, Franck Bui-Huu wrote:
> >What Maciej said.  But also: please compare the description of
> >CONFIG_BUILD_ELF64 with the targets that link at that address.
> >Almost every supported target links at that address, except for
> >IP27.  How do any of them work today?
> >
> 
> Surely because none of them define CONFIG_BUILD_ELF64:

Huh - you're right, it must just be living in my local .config since
back when it meant something different.

-- 
Daniel Jacobowitz
CodeSourcery
