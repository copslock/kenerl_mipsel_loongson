Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 14:55:05 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52612 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024676AbXFTNzD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 14:55:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5KDlRYO030654;
	Wed, 20 Jun 2007 14:47:27 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5K8R87X026812;
	Wed, 20 Jun 2007 09:27:08 +0100
Date:	Wed, 20 Jun 2007 09:27:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Message-ID: <20070620082708.GA25270@linux-mips.org>
References: <200706142154.l5ELslhw021385@pasqua.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200706142154.l5ELslhw021385@pasqua.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 14, 2007 at 03:54:47PM -0600, Marc St-Jean wrote:

> Re-posting patch as requested by Ralf. Changes since last post:
> -Minor cleanups as recommended by checkpatch.pl.

Be careful with that script.  Some of it's recommendations are harmful,
for example when it sees an inclusion of <asm/time.h> it will suggest
to use <linux/time.h>.  That's all fine because generally the file under
linux/ will include the asm/ version but there are exception.

But it's great that you discovered it already, it saves me the for both
sides annoying part of dealing out tons of trivialities, first such as
formatting trivialities.  One thing checkpatch.pl doesn't yet complain
about is trailing whitespace such as in the first of the patches you
sent:

Warning: trailing whitespace in line 106 of arch/mips/pmc-sierra/msp71xx/msp_usb.c
Warning: trailing whitespace in line 12 of arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
Warning: trailing whitespace in lines 43,53,63,79 of arch/mips/pmc-sierra/msp71xx/msp_time.c
Warning: trailing whitespace in lines 49,59,62,68,78,84 of arch/mips/pmc-sierra/msp71xx/msp_irq.c
Warning: trailing whitespace in line 84 of arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
Warning: trailing whitespace in line 157 of arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
Warning: trailing whitespace in lines 154,307,537,548,558 of arch/mips/pmc-sierra/msp71xx/msp_prom.c
Warning: trailing whitespace in lines 66,229,238,252 of arch/mips/pmc-sierra/msp71xx/msp_setup.c

No need to resend the patch, I can strip that of trivially

  Ralf
