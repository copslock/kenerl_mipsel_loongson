Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 14:47:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49030 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025028AbXIUNrz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 14:47:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8LDlsTj008243;
	Fri, 21 Sep 2007 14:47:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8LDlrRO008242;
	Fri, 21 Sep 2007 14:47:53 +0100
Date:	Fri, 21 Sep 2007 14:47:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sagar Borikar <Sagar_Borikar@pmc-sierra.com>
Cc:	Steve Graham <stgraham2000@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
Message-ID: <20070921134753.GA8090@linux-mips.org>
References: <340C71CD25A7EB49BFA81AE8C839266757076E@BBY1EXM10.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <340C71CD25A7EB49BFA81AE8C839266757076E@BBY1EXM10.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 20, 2007 at 11:27:18PM -0700, Sagar Borikar wrote:

> rm7k_wait_irqoff patch doesn't seem to improve the things for illegal instructions for E9k core.
> But many customers have reported that they do get illegal instruction when ﻿ICACHE_REFILLS_WORKAROUND_WAR is not enabled.

This is due to a very unfortunate design issue in the RM7000 / RM9000.  So
it wasn't done by accident but with full intention but I call it a bug
anyway.  So this also means all revs of these cores are affected and if
the issue is not being hit for a particular workload and where
ICACHE_REFILLS_WORKAROUND_WAR is disabled then that that's by coincidence
not engineering.

  Ralf
