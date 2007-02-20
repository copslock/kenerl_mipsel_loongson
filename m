Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 00:06:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40116 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038918AbXBTAGI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Feb 2007 00:06:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1K0689B014766;
	Tue, 20 Feb 2007 00:06:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1K068UG014765;
	Tue, 20 Feb 2007 00:06:08 GMT
Date:	Tue, 20 Feb 2007 00:06:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <tigerand@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Clean up serial console support on Sibyte 1250 duart
Message-ID: <20070220000608.GB14034@linux-mips.org>
References: <20070219234816.GA12092@onstor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070219234816.GA12092@onstor.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 19, 2007 at 03:48:24PM -0800, Andrew Sharp wrote:

Patch looks reasonable at a quick glance.  I'll review it for real
later, just wanted to mention that the drivers/char/ Sibyte serial
driver is really a dead end of the evolution.  The driver should
be replaced with a new driver based on the the new drivers/serial/
infrastructure.

  Ralf
