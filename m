Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 18:31:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:6067 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022967AbXJ2Sbv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 18:31:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TIViBj014339;
	Mon, 29 Oct 2007 18:31:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TIVRnE014338;
	Mon, 29 Oct 2007 18:31:27 GMT
Date:	Mon, 29 Oct 2007 18:31:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] store sign-extend register values for PTRACE_GETREGS
Message-ID: <20071029183127.GA14270@linux-mips.org>
References: <20070304.024152.96687132.anemo@mba.ocn.ne.jp> <20071026.005302.25909293.anemo@mba.ocn.ne.jp> <20071028193421.GC7661@linux-mips.org> <20071028195211.GA29200@caradoc.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071028195211.GA29200@caradoc.them.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 28, 2007 at 03:52:11PM -0400, Daniel Jacobowitz wrote:

> On Sun, Oct 28, 2007 at 07:34:21PM +0000, Ralf Baechle wrote:
> > On Fri, Oct 26, 2007 at 12:53:02AM +0900, Atsushi Nemoto wrote:
> > 
> > Daniel, do you see any debugger compatibility issues with this patch?
> 
> I don't think so; I'm pretty sure I wrote the code at fault here,
> and I can't remember any reason I would have deliberately made the
> registers unsigned.  Looking at the fix I think I just guessed
> wrong about the type used by __put_user.

Good.  So I just applied it.

  Ralf
