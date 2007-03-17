Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2007 13:31:59 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:6624 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022286AbXCQNbx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Mar 2007 13:31:53 +0000
Received: from localhost (p4213-ipad32funabasi.chiba.ocn.ne.jp [221.189.136.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C5270B7CB; Sat, 17 Mar 2007 22:30:31 +0900 (JST)
Date:	Sat, 17 Mar 2007 22:30:31 +0900 (JST)
Message-Id: <20070317.223031.93018658.anemo@mba.ocn.ne.jp>
To:	stjeanma@pmc-sierra.com
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200703162132.l2GLWuAv032733@pasqua.pmc-sierra.bc.ca>
References: <200703162132.l2GLWuAv032733@pasqua.pmc-sierra.bc.ca>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 16 Mar 2007 15:32:56 -0600, Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> +static struct irq_chip msp_cic_irq_controller = {
> +	.typename = "MSP_CIC",

The 'typename' is obsolete.  Use 'name'.  Also, using new flow handler
(and GENERIC_HARDIRQS_NO__DO_IRQ in Kconfig) might give you a little
bit better performance.

---
Atsushi Nemoto
