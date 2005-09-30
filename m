Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:46:09 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:47642 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465570AbVI3Kmf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:35 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLui005536;
	Fri, 30 Sep 2005 11:42:27 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8U05onK004667;
	Fri, 30 Sep 2005 01:05:50 +0100
Date:	Fri, 30 Sep 2005 01:05:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: RFC: Revise n32 ptrace interface
Message-ID: <20050930000550.GE3983@linux-mips.org>
References: <20050922182601.GA10829@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922182601.GA10829@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 22, 2005 at 02:26:01PM -0400, Daniel Jacobowitz wrote:

> 1.  We need to get at the 64-bit registers.  I considered a number of
> different approaches for this and decided to just implement a 64-bit
> PTRACE_GETREGS instead of messing with PTRACE_PEEKUSR.  It's much simpler
> this way.  I didn't add one for the DSP registers; that can be handled
> separately when someone's working on debug support for them...

I quite deliberately did omit DSP support from 64-bit ptrace(2); there
is currently no MIPS64 processor with DSP support that I know of.

  Ralf
