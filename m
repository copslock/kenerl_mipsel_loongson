Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2007 20:22:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41104 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022720AbXGDTWL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jul 2007 20:22:11 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l64JM8tC008052;
	Wed, 4 Jul 2007 21:22:08 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l64JM81T008051;
	Wed, 4 Jul 2007 20:22:08 +0100
Date:	Wed, 4 Jul 2007 20:22:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	sknauert@wesleyan.edu
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: O2 RM7000 Issues
Message-ID: <20070704192208.GA7873@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070704152729.GA2925@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 04, 2007 at 04:27:29PM +0100, Ralf Baechle wrote:

> R5000, RM5200 and RM7000 are all MIPS IV processors so have the same
> instruction set.  That leaves the usual suspects - pipeline hazards,
> cache problems and CPU bugs to research.

Big loud bell began ringing.  The RM7000 fetches and decodes multiple
instructions in one go.  And just like the E9000 cores it does
throw an exception if it doesn't like one of the opcodes even if that
doesn't actually get executed.  The kernel has a workaround for this
PMC-Sierra peculiarity (I call it a bug) but it's only being activated
for E9000 platforms.

  Ralf
