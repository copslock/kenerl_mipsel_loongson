Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 07:57:31 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:30433 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021487AbYEMG52 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 07:57:28 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4D6vKKH027647;
	Tue, 13 May 2008 07:57:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4D6vKdj027646;
	Tue, 13 May 2008 07:57:20 +0100
Date:	Tue, 13 May 2008 07:57:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cobalt drivers/media build failure
Message-ID: <20080513065720.GA22067@linux-mips.org>
References: <20080512171216.GA19598@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080512171216.GA19598@deprecation.cyrius.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2008 at 07:12:16PM +0200, Martin Michlmayr wrote:

> With the Debian config (that enables a lot of modules) I get the
> following build error on Cobalt with 2.6.26-rc1:

At a glance this looks you're building with I2C enabled, something which
the Kconfig stuff should enforce.

  Ralf
