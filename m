Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 10:29:51 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48335 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491937AbZFQI3o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Jun 2009 10:29:44 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5H8Rxls015050;
	Wed, 17 Jun 2009 09:27:59 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5H8RxDD015048;
	Wed, 17 Jun 2009 09:27:59 +0100
Date:	Wed, 17 Jun 2009 09:27:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Tim Anderson <tanderson@mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] Synchronise Count registers across multiple cores
Message-ID: <20090617082759.GD13467@linux-mips.org>
References: <20090617000100.GH6346@shomer.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090617000100.GH6346@shomer.az.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 16, 2009 at 05:01:00PM -0700, Tim Anderson wrote:

> This implements the SMP counter synchronization. This is a
> port of linux-mti commit 71fb5e76e8c01bfb04967131ac63a1d2194f8550

And duplicates most of arch/mips/kernel/sync-r4k.c for no obvious reason.

Why?

  Ralf
