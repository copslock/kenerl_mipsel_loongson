Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 15:27:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13006 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573708AbXBMP1S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 15:27:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1DFRHX5005182;
	Tue, 13 Feb 2007 15:27:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1DFRGuA005181;
	Tue, 13 Feb 2007 15:27:16 GMT
Date:	Tue, 13 Feb 2007 15:27:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix irq handling of DECstations
Message-ID: <20070213152716.GA4942@linux-mips.org>
References: <20070212.234826.59032634.anemo@mba.ocn.ne.jp> <20070213022548.GB25323@linux-mips.org> <45D1C21A.9070801@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45D1C21A.9070801@innova-card.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 13, 2007 at 02:50:18PM +0100, Franck Bui-Huu wrote:

> This patch makes these routines a lot more readable whatever
> the value of CONFIG_PREEMPT.

Applied.

   Ralf
