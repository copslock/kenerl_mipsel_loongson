Received:  by oss.sgi.com id <S553951AbRCIATV>;
	Thu, 8 Mar 2001 16:19:21 -0800
Received: from u-49-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.49]:64004
        "EHLO u-49-20.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553948AbRCIATQ>; Thu, 8 Mar 2001 16:19:16 -0800
Received: from dea ([193.98.169.28]:27011 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867058AbRCIAS7>;
	Fri, 9 Mar 2001 01:18:59 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f290IrT22672;
	Fri, 9 Mar 2001 01:18:53 +0100
Date:	Fri, 9 Mar 2001 01:18:53 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	<heinold@physik.tu-cottbus.de>, <linux-mips@oss.sgi.com>
Subject: Re: Question concerning Assembler error
Message-ID: <20010309011853.E21844@bacchus.dhis.org>
References: <3AA7B13F.F918E1F8@ti.com> <20010308173003.A17217@physik.tu-cottbus.de> <20010308174044.B11107@bacchus.dhis.org> <01b701c0a7f0$79260ba0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01b701c0a7f0$79260ba0$0deca8c0@Ulysses>; from kevink@mips.com on Thu, Mar 08, 2001 at 05:54:29PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Mar 08, 2001 at 05:54:29PM +0100, Kevin D. Kissell wrote:

> > > Hm sorry cant help with the assembler problem, but which machine
> > > has a 4600 Prozessor and run mipsel on it?
> > 
> > RM200C.
> 
> Actually, It's far more likely that Jeff is working with a
> MIPS 4KC or 5KC CPU core.  -mcpu=r4600 ends up
> being the closest fit to the MIPS32 ISA and pipeline
> among the options available for the Linux-capable
> gcc compilers.

Maybe your answer is right, but then the question is wrong :-)

  Ralf
