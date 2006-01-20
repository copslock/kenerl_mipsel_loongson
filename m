Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 15:12:59 +0000 (GMT)
Received: from mail.ttnet.net.tr ([212.175.13.129]:62013 "EHLO
	fep02.ttnet.net.tr") by ftp.linux-mips.org with ESMTP
	id S3686579AbWATPMe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 15:12:34 +0000
Received: from boras ([81.214.46.231]) by fep02.ttnet.net.tr with ESMTP
          id <20060120151321.RUXC27637.fep02.ttnet.net.tr@boras>;
          Fri, 20 Jan 2006 17:13:21 +0200
From:	bora.sahin@ttnet.net.tr
To:	Youngduk Goo <ydgoo9@gmail.com>
Subject: Re: IDE Inteface on the AMD AU1200
Date:	Fri, 20 Jan 2006 17:15:51 +0200
User-Agent: KMail/1.7.2
Cc:	linux-mips@linux-mips.org
References: <38dc7fce0601200457t574a293bxbfaf8c7b73d65378@mail.gmail.com> <200601201659.53023.bora.sahin@ttnet.net.tr>
In-Reply-To: <200601201659.53023.bora.sahin@ttnet.net.tr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="Iso-8859-9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601201715.52216.bora.sahin@ttnet.net.tr>
X-NAI-Spam-Rules: 1 Rules triggered
	BAYES_00=-2.5
Return-Path: <bora.sahin@ttnet.net.tr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bora.sahin@ttnet.net.tr
Precedence: bulk
X-list: linux-mips


Hi,

Sory it just pushed my hands mistakenly before I had competed it. Which 
functionality provided with which CPLD register may be wrong. Valids both 
the below one and the others.

Au1200 PCMCIA normally supports one chip. CPLD makes it available two chip.

On Friday 20 January 2006 16:59, bora.sahin@ttnet.net.tr wrote:
> Hi,
>
> > The DBAu1200 evaluation board from AMD use the Xilinx's CPLD,
> > and Ethernet, IDE, BCSR... address line comes out from it.
> > BCSR(Board Configuration & Status Register) in CPLD have many
> > function like Enable/Disable the Interrupt and else.
> > I don't understand exactly why they are used and what they do in the
> > system.
>
> I didnt do much examination just some hours but let me say what I
> thought.
>
>
> BCSR mainly involves with board elements like rotary switch, leds etc.
> It also provides master/slave PCMCIA.  As for IDE, it provides DMA
> capability to the board. Normally Au1200 only supports PIO modes.
>
> The other CPLD, XCS128(CNTL_CPLD) seemed to me that it is a signal
> distribution center. For example, CS[2] is connected to IDE, SMSC and
> daughter card interface. Which one to be signals routed is decided by
> CNTL. Maybe all the chip selects are rerouted by this CPLD. So all the
> buffers(SN74...) I am neither a board designer or know electronics much
> but they are used for consistent signal routing. These are just 2 my
> cents...
>
> They are coupled. It is needed a new design to eliminate some
> functions...
>
> > I just wonder if I don't use this and connect the IDE interface to the
> > static bus of Au1200 directly, I am not sure it is working well or
> > not.
>
> In a new design I dont see any reason why not to be provided that you
> can only use PIO modes.
>
> Thanks...
>
> --
> Bora SAHIN
