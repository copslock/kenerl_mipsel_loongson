Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Feb 2013 13:56:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36149 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824793Ab3BJM41UemYA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Feb 2013 13:56:27 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r1ACuQ1P014520;
        Sun, 10 Feb 2013 13:56:26 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r1ACuPeo014480;
        Sun, 10 Feb 2013 13:56:25 +0100
Date:   Sun, 10 Feb 2013 13:56:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     folkert <folkert@vanheusden.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: prom start
Message-ID: <20130210125625.GA32552@linux-mips.org>
References: <20130206160508.GR2118@belle.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130206160508.GR2118@belle.intranet.vanheusden.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Feb 06, 2013 at 05:05:10PM +0100, folkert wrote:

> Is this mailing list also meant for generic mips questions? (if not: any
> suggestions for one that is?)
> 
> If so: I'mm experimenting a bit with mips, specifically on SGI hardware
> (Indigo). Now it seems all mips systems have the prom at 0xbfc00000. But
> how does it start? The first 0x3c0 bytes seem to be nonsense. Somewhere
> on the web I found that 0xbfc00884 is the starting point but after
> single stepping 5 instructions, the program counter jumps to 0x00000000
> so I don't think that's the right one either. Also, reading the first 4
> bytes from bfc00000 and using that as a pointer seems to be invalid too:
> 0bf000f0.
> Anyone with insights regarding the booting of the prom on sgi systems?

All MIPS processors start execution at 0xbfc00000 after a hardware reset
or NMI.  0xbfc00884 is not an address that has any specific meaning in
the processor architecture itself.  I think it's being used in the GXemul
documentation just for sake of an example.

If your disassembler defaults to like MIPS I / R3000 it won't disassemble
all instructions for the MIPS III R4000 processor.  I'd expect some
cache initialization code right at 0xbfc00000 and that could would be
affected.

  Ralf
