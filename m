Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 15:42:30 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:47142 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994686AbeBTOmRz24iI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 15:42:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 14:42:01 +0000
Received: from [10.20.78.55] (10.20.78.55) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Tue, 20 Feb 2018 06:41:31 -0800
Date:   Tue, 20 Feb 2018 14:41:21 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC v2] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
In-Reply-To: <20180218084723.GA2577@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802201410300.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk> <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk> <20180211075608.GC2222@localhost.localdomain> <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk> <20180215191502.GA2736@localhost.localdomain> <alpine.DEB.2.00.1802151934180.3553@tp.orcam.me.uk>
 <20180218084723.GA2577@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-BESS-ID: 1519137720-321457-25678-17499-3
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190222
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 18 Feb 2018, Fredrik Noring wrote:

> > Substitute `mips:5900' for `mips:isa32r2' to get R5900 disassembly.  If 
> > you want to see raw machine code too, use `disassemble -r', but watch out 
> > for the syntax, which is different.  As you can see the trailing NOPs 
> > required are already there. :)
> 
> Due to trailing zeroes, I suppose. :)

 It's no coincidence and we use it to our advantage that an all-zeros 
pattern is the canonical NOP instruction encoding.

> >  A handler for SIO is needed if SIOInt can be asserted without kernel 
> > control by PS/2 hardware.  Otherwise handlers will only be needed once the 
> > kernel has means to enable the respective exceptions.
> 
> Serial I/O requires soldering for the PS2. Jürgen Urban, Rick Gaiser, and
> others have it and they can more easily debug the early boot stages. The
> proposed PS2 serial driver uses a 20 ms timer and polling instead of SIOInt:
> 
> https://github.com/frno7/linux/blob/ps2-v4.15-n7/drivers/tty/serial/ps2-uart.c

 So it looks like a random SIOInt is not supposed to happen and therefore 
I think a handler is not needed for the initial submission of the port if 
at all.

> I don't have a serial port. My setup consists of ssh over a wireless RT3070*
> USB device. Obviously a great number of things could potentially fail in
> that chain but it is surprisingly reliable. :)

 This has prompted me to look at what PS2 hardware provides and it indeed 
seems lacking in basic I/O connectivity.  What could one expect from a 
game console anyway?

 Do you use the netconsole then too?  Using a USB serial port adapter 
would be an alternative, although not a very powerful one either, because 
you need to have many parts of the OS initialised before you can get to 
such a port.

  Maciej
