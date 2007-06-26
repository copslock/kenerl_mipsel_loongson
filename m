Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2007 20:55:59 +0100 (BST)
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:7949 "EHLO
	mallaury.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20022141AbXFZTzy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Jun 2007 20:55:54 +0100
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by mallaury.nerim.net (Postfix) with ESMTP id 9B38C4F3DF;
	Tue, 26 Jun 2007 21:55:08 +0200 (CEST)
Date:	Tue, 26 Jun 2007 21:55:32 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	Brian Oostenbrink <Brian_Oostenbrink@pmc-sierra.com>,
	Rod Sillett <Rod_Sillett@pmc-sierra.com>
Subject: Re: [PATCH 8/12] drivers: PMC MSP71xx TWI driver
Message-ID: <20070626215532.3d5eabd4@hyperion.delvare>
In-Reply-To: <46815662.1030900@pmc-sierra.com>
References: <46815662.1030900@pmc-sierra.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Marc,

On Tue, 26 Jun 2007 11:09:38 -0700, Marc St-Jean wrote:
> Jean Delvare wrote:
> > On Fri, 27 Apr 2007 14:08:36 -0600, Marc St-Jean wrote:
> >  > +/*
> >  > + * Helper routine, converts 'pmctwi_cmd' struct to register format
> >  > + */
> >  > +static inline u32 pmcmsptwi_cmd_to_reg(const struct pmcmsptwi_cmd *cmd)
> >  > +{
> >  > +     return (u32)(((cmd->type & 0x3) << 8) |
> >  > +                     (((cmd->write_len - 1) & 0x7) << 4) |
> >  > +                     (((cmd->read_len - 1) & 0x7) << 0));
> >  > +}
> >
> > What if cmd->write_len or cmd->read_len is 0?
> 
> That's checked in pmcmsptwi_xfer_cmd() before calling pmcmsptwi_cmd_to_reg().

Not really. The code in pmcmsptwi_xfer_cmd() doesn't check
cmd->read_len if cmd->type == MSP_TWI_CMD_WRITE, nor cmd->write_len if
cmd->type == MSP_TWI_CMD_READ. So one of them could still be 0 when you
call pmcmsptwi_cmd_to_reg() I _guess_ that the resulting bits in the
cmd register then don't matter, but you may want to double-check.

> > I seem to understand that the hardware simply doesn't support
> > transactions with an arbitrary number of messages. It only supports
> > simple reads, simple writes, and combined write + read. Then your
> > driver shouldn't attempt to hide this limitation. The hardware only
> > supports a subset of the I2C protocol, so be it. Simply return an error
> > if requested to do something the hardware doesn't support.
> > 
> > This will make your code much more simple. And in practice it shouldn't
> > change anything, because all popular I2C (and SMBus) transactions are
> > of one of the 3 supported types.
> 
> I'm concerned about dropping multi-message support and reducing
> functionality. We can't be certain that this is not currently used
> by devices on our customers' boards. They have been using this driver
> on MSP devices for quite a while now.
> The debugging output for "SMBus read" (see 4 comments down) hints that
> it was used in at least one case.

I'm not asking that you drop multi-message support entirely. The chip
supports combined write+read transactions up to 8 bytes per message, so
the driver should still support that. I'm only asking that you don't
try to emulate support for transactions of 3 and more messages, as this
is not correct.

Again, I've _never_ seen any I2C chip requiring transactions of more
than 2 messages, so I'm fairly certain that this won't make a
difference in practice. What your device supports is sufficient for all
the SMBus transaction types (except for the limit to 8 bytes per
message, but there's no way around this), including the one for which
a debugging message was present. In particular, all the transactions
used in the LED driver you posted earlier would be supported just fine.

> >  > +             if (dual) {
> >  > +                     dev_dbg(&adap->dev,
> >  > +                             "SMBus read 0x%02x from reg 0x%02x\n",
> >  > +                             nmsg->buf[0], cmsg->buf[0]);
> > 
> > This message is only correct for an SMBus Read Byte transaction, while
> > there are many other possible combined transactions.
> 
> OK, I've dropped the comment.

FWIW: enabling CONFIG_I2C_DEBUG_CORE will show all the transactions, if
you ever need this kind of information.

> >  > +static int __init pmcmsptwi_init(void)
> >  > +{
> >  > +     pmcmsptwi_algo_data.iobase = ioremap(MSP_TWI_BASE, MSP_TWI_REG_SIZE);
> > 
> > MSP_TWI_BASE is not defined anywhere.
> 
> It is defined in msp_regs.h included at the top. That file is part of
> PATCH 1/12 for the core platform.

Ah, OK. Sorry, I forgot that this was a series and not a single patch.

-- 
Jean Delvare
