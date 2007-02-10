Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 10:26:40 +0000 (GMT)
Received: from mail02.hansenet.de ([213.191.73.62]:50107 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20037543AbXBJK0f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Feb 2007 10:26:35 +0000
Received: from [213.39.184.171] (213.39.184.171) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 45CB2B4F000CF39F; Sat, 10 Feb 2007 11:22:44 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 1E3BC479FC;
	Sat, 10 Feb 2007 11:22:43 +0100 (CET)
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] eXcite nand flash driver
Date:	Sat, 10 Feb 2007 11:22:04 +0100
User-Agent: KMail/1.9.6
Cc:	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
References: <200702080157.25432.thomas.koeller@baslerweb.com> <1170949737.3646.29.camel@chaos>
In-Reply-To: <1170949737.3646.29.camel@chaos>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200702101122.05049.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Donnerstag, 8. Februar 2007, Thomas Gleixner wrote:
> > +/* command and control functions */
> > +static void excite_nand_control(struct mtd_info *mtd, int cmd,
> > +				       unsigned int ctrl)
> > +{
> > +	io_reg_t regs =
> > +	    container_of(mtd, struct excite_nand_drvdata, board_mtd)->regs;
> > +	static void __iomem *tgt = NULL;
> > +
> > +	switch (ctrl) {
> > +	case NAND_CTRL_CHANGE | NAND_CTRL_CLE:
> > +		tgt = regs + EXCITE_NANDFLASH_CMD_BYTE;
> > +		break;
> > +	case NAND_CTRL_CHANGE | NAND_CTRL_ALE:
> > +		tgt = regs + EXCITE_NANDFLASH_ADDR_BYTE;
> > +		break;
> > +	case NAND_CTRL_CHANGE | NAND_NCE:
> > +		tgt = regs + EXCITE_NANDFLASH_DATA_BYTE;
> > +		break;
> > +	}
>
> Err, did this ever work ? I doubt it. From nand_base.c:
>
>                 chip->cmd_ctrl(mtd, page_addr, ctrl);
>                 ctrl &= ~NAND_CTRL_CHANGE;
>                 chip->cmd_ctrl(mtd, page_addr >> 8, ctrl);
>
> So I expect an OOPS happens on a regular base.
>

I guess it is the 'static void __iomem *tgt = NULL' part that worries
you? Think about it, that value is never used.

However, I admit it is somewhat unclean, and therefore I am changing
it. Updated patch follows.

tk
