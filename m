Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 12:26:28 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58167 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492782AbZFPK0V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 12:26:21 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5GAOA5V023030;
	Tue, 16 Jun 2009 11:24:30 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5GANoo6023014;
	Tue, 16 Jun 2009 11:23:50 +0100
Date:	Tue, 16 Jun 2009 11:23:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, wli@holomorphy.com
Subject: Re: [PATCH 5/5] MIPS: Add SYS_SUPPORTS_HUGETLBFS Kconfig variable
	and enable it for some systems.
Message-ID: <20090616102350.GD13622@linux-mips.org>
References: <4A1DDED7.3020306@caviumnetworks.com> <1243471666-27915-5-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243471666-27915-5-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 27, 2009 at 05:47:46PM -0700, David Daney wrote:
> From: David Daney <ddaney@caviumnetworks.com>
> Date: Wed, 27 May 2009 17:47:46 -0700
> To: linux-mips@linux-mips.org, ralf@linux-mips.org
> Cc: wli@holomorphy.com, David Daney <ddaney@caviumnetworks.com>
> Subject: [PATCH 5/5] MIPS: Add SYS_SUPPORTS_HUGETLBFS Kconfig variable and
> 	enable it for some systems.
> 
> Add new kconfig variables SYS_SUPPORTS_HUGETLBFS and
> CPU_SUPPORTS_HUGEPAGES.  They are enabled for systems that are known
> to support huge pages.

Which should be all processors except R2000 / R3000, R6000 and R8000, no?

  Ralf
