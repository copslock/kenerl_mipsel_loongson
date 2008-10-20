Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 15:41:19 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:20105 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21920903AbYJTOlQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 15:41:16 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 09A0C3ECC; Mon, 20 Oct 2008 07:41:13 -0700 (PDT)
Message-ID: <48FC9878.4030306@ru.mvista.com>
Date:	Mon, 20 Oct 2008 18:40:56 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support
References: <20081017.231036.26097587.anemo@mba.ocn.ne.jp>	<48FB7D9E.4030803@ru.mvista.com> <20081020.231450.51866269.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081020.231450.51866269.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>+	struct tx4938ide_platform_info pdata = {
>>>+		.ioport_shift = shift,
>>>+		.gbus_clock = tune ? txx9_gbus_clock : 0,

>>    Any reason not to supply the GBUS clock?

> The EBUS channel might be used for both ATA and ISA or other local bus
> devices.  In that case, the board setup code should initialize best
> timings for all devices and the IDE driver should not overrite it.

    Ah, I forgot about the ATA address space being appeandage to ISA address 
space on TX4939...

>>    I'm afraid you can't just early return from the set_pio_mode() method...

> Do you mean I should use IDE_HFLAG_NO_SET_MODE instead of just
> returning from set_pio_mode?

    No, that's for the smart RAID controllers that program the transfer modes 
themselves. In your case, hwif->port_ops->set_pio_mode() must be NULL -- if 
you're not going to allow the mode programming, that is.

MBR, Sergei
