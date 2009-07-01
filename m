Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 02:37:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41221 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492756AbZGAAhE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 02:37:04 +0200
Date:	Wed, 1 Jul 2009 01:37:04 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus (v2).
In-Reply-To: <20090629193454.GA23430@linux-mips.org>
Message-ID: <alpine.LFD.2.00.0907010132500.23134@eddie.linux-mips.org>
References: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com> <20090629193454.GA23430@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 29 Jun 2009, Ralf Baechle wrote:

> > Some CPUs implement mipsr2, but because they are a super-set of
> > mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
> > this category.  We would still like to use the optimized
> > implementation, so since we have already checked for
> > CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
> > CONFIG_CPU_MIPS64_R2 is sufficient.
> > 
> > Change from v1: Add comments about why the change is safe.
> 
> Thanks, applied.  Though this sort of patch make me thing that maybe we
> rather should have treated the cnMIPS cores differently.

 This is a pure code generation option and it asks for "select 
CPU_MIPS64_R2" under CPU_OCTEON (or whatever option is used for that 
chip).  Or something like "select ISA_MIPS64_R2" actually, as we want to 
keep CPU_foo as the -march=, etc. designator.  IOW it looks like we lack 
ISA supersetting along the lines of how tools handle it.

  Maciej
