Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 11:44:59 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:29210 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465659AbVJEKoo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 11:44:44 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j95AicIq009380;
	Wed, 5 Oct 2005 11:44:38 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j95AicYx009379;
	Wed, 5 Oct 2005 11:44:38 +0100
Date:	Wed, 5 Oct 2005 11:44:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Where is op_model_mipsxx.c ?
Message-ID: <20051005104437.GG2699@linux-mips.org>
References: <4343525A.6080605@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343525A.6080605@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 04, 2005 at 09:11:06PM -0700, David Daney wrote:

> I noticed this in the Makefile for the OProfile directory for mips:
> 
> oprofile-$(CONFIG_CPU_MIPS32_R1)                += op_model_mipsxx.o
> 
> The file op_model_mipsxx.c does not seem to exist.  Which implies to me 
> that someone was working on making it work for MIPS32, but didn't quite 
> finish.
> 
> I want to start hacking on OProfile for a MIPS32 based system and 
> thought it might make a nice starting point.
> 
> If the missing file exists would its author mind making it available to me?

I've got oprofile support for MIPS32 / MIPS64 style counters in the queue.
It still needs some debugging to become actually useful but anyway, I'm
going to check those patches into git in a few minutes.

  Ralf
