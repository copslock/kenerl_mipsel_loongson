Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 06:18:28 +0100 (BST)
Received: from p508B7EE4.dip.t-dialin.net ([IPv6:::ffff:80.139.126.228]:32408
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225244AbTFDFS0>; Wed, 4 Jun 2003 06:18:26 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h545IMbY008420;
	Tue, 3 Jun 2003 22:18:22 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h545IJHJ008419;
	Wed, 4 Jun 2003 07:18:19 +0200
Date: Wed, 4 Jun 2003 07:18:18 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Single stepping in mips
Message-ID: <20030604051818.GA2365@linux-mips.org>
References: <200306040918.01943.krishnakumar@naturesoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306040918.01943.krishnakumar@naturesoft.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 04, 2003 at 09:18:01AM +0530, Krishnakumar. R wrote:

> How can we single step through an instruction 
> in mips architecture. 
> 
> In intel 386 architecture if we set TF flag
> of the EFLAGS register a trap will be generated
> after every instruction. Is there a way in 
> mips to do the same. 

On most MIPS processors there is no singlestepping feature.  You have to
manual insert a breakpoint into the instruction stream and deal with the
exception.

  Ralf
