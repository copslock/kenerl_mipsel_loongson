Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 21:40:12 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36314 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493409AbZF2TkE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 21:40:04 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5TJYsCD024431;
	Mon, 29 Jun 2009 20:34:55 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5TJYse1024429;
	Mon, 29 Jun 2009 20:34:54 +0100
Date:	Mon, 29 Jun 2009 20:34:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus (v2).
Message-ID: <20090629193454.GA23430@linux-mips.org>
References: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 29, 2009 at 09:54:15AM -0700, David Daney wrote:

> Some CPUs implement mipsr2, but because they are a super-set of
> mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
> this category.  We would still like to use the optimized
> implementation, so since we have already checked for
> CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
> CONFIG_CPU_MIPS64_R2 is sufficient.
> 
> Change from v1: Add comments about why the change is safe.

Thanks, applied.  Though this sort of patch make me thing that maybe we
rather should have treated the cnMIPS cores differently.

  Ralf
