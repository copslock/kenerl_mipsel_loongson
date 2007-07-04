Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2007 16:27:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:48855 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022622AbXGDP1c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jul 2007 16:27:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l64FRUlS003112;
	Wed, 4 Jul 2007 17:27:30 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l64FRTia003111;
	Wed, 4 Jul 2007 16:27:29 +0100
Date:	Wed, 4 Jul 2007 16:27:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	sknauert@wesleyan.edu
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: O2 RM7000 Issues
Message-ID: <20070704152729.GA2925@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 02, 2007 at 09:08:43AM -0400, sknauert@wesleyan.edu wrote:
> From: sknauert@wesleyan.edu
> Date: Mon, 2 Jul 2007 09:08:43 -0400 (EDT)
> To: Linux MIPS List <linux-mips@linux-mips.org>
> Subject: Re: O2 RM7000 Issues
> Content-Type: text/plain;charset=UTF-8
> 
> I have one of the 600 Mhz RM7000s, i.e. no tertiary cache since the module
> was originally a 300 Mhz RM5200. However, mine hasn't given any problems
> with Debian or Gentoo.
> 
> What kernel and target are you compiling for? I'm using 2.6.21.3 compiled
> for R5K. All my userspace is compiled for R5K too. I'll compile a new
> kernel for RM7000 and see if I have any issue then poke around to see what
> kernel code gets changed. I'm not 100% sure, but I didn't think it was
> that much so my gut reaction is this might be a gcc issue since the RM7000
> isn't a common processor.

R5000, RM5200 and RM7000 are all MIPS IV processors so have the same
instruction set.  That leaves the usual suspects - pipeline hazards,
cache problems and CPU bugs to research.

  Ralf
