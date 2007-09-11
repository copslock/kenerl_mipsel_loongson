Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 13:20:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53993 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022236AbXIKMUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Sep 2007 13:20:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8BCK5Vx026909;
	Tue, 11 Sep 2007 13:20:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8BCK5CE026908;
	Tue, 11 Sep 2007 13:20:05 +0100
Date:	Tue, 11 Sep 2007 13:20:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Introduced GPI_RM9000 configuration parameter.
Message-ID: <20070911122005.GC24679@linux-mips.org>
References: <200709110235.50359.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709110235.50359.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 11, 2007 at 02:35:49AM +0200, Thomas Koeller wrote:

> GPI_RM9000 indicates the presence of FM9000-style GPI
> (General Purpose Interface) hardware.

Patch itself is ok but there seems to be nothing that depends on GPI_RM9000:

$ git grep -E -w '(CONFIG_|)GPI_RM9000' | cat
arch/mips/configs/excite_defconfig:CONFIG_GPI_RM9000=y
$

I assume you're about to send more patches which depend on this one?

Queued, but on hold for now.  Thanks,

  Ralf
