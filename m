Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 10:06:26 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:46017 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20024548AbYFKJGX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 10:06:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5B963HE030040;
	Wed, 11 Jun 2008 10:06:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5B961sC030027;
	Wed, 11 Jun 2008 10:06:01 +0100
Date:	Wed, 11 Jun 2008 10:06:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <KevinK@paralogos.com>
Cc:	Brian Foster <brian.foster@innova-card.com>,
	linux-mips@linux-mips.org, Andrew Dyer <adyer@righthandtech.com>
Subject: Re: Adding(?) XI support to MIPS-Linux?
Message-ID: <20080611090601.GB19755@linux-mips.org>
References: <200806091658.10937.brian.foster@innova-card.com> <a537dd660806090837i5ef6c1e2k167aeb97785a136d@mail.gmail.com> <484D856B.5030306@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <484D856B.5030306@paralogos.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 09, 2008 at 09:32:59PM +0200, Kevin D. Kissell wrote:

> That is correct, though there has long been interest in having XI/RI as an 
> option
> for non-SmartMIPS cores and I would not be surprised if sooner or later it
> became more generally available.

Cavium has it in their 64-bit core.  I haven't verified this in the docs
but apparently it is meant to be compatible with the old SmartMIPS ASE
for MIPS32.

  Ralf
