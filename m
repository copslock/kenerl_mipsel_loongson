Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 20:33:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:51133 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037871AbWLFUdK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 20:33:10 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB6KX884010522;
	Wed, 6 Dec 2006 20:33:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB6KWxIG010521;
	Wed, 6 Dec 2006 20:32:59 GMT
Date:	Wed, 6 Dec 2006 20:32:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061206203259.GA10170@linux-mips.org>
References: <20061206.115602.63741871.nemoto@toshiba-tops.co.jp> <20061206.133836.89067271.nemoto@toshiba-tops.co.jp> <4576C2E9.4060900@ru.mvista.com> <20061207.020348.25910403.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207.020348.25910403.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 07, 2006 at 02:03:48AM +0900, Atsushi Nemoto wrote:

> > 8259A PICs and so was capable of handling only 8 IRQs. Dual 8259A was first 
> > used in the AT class machines...
> 
> It has been called "XT-PIC" anyway so I'd like to keep unchanged.

90% of the i8259 code are identical between i386 and MIPS and several
others; maybe it's time to share such code between architectures.

  Ralf
