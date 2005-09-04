Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 00:22:36 +0100 (BST)
Received: from p549F6EE6.dip.t-dialin.net ([IPv6:::ffff:84.159.110.230]:46049
	"EHLO bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225352AbVIDXWQ>; Mon, 5 Sep 2005 00:22:16 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j84NSq16019092;
	Sun, 4 Sep 2005 23:28:52 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j84NSpAs019091;
	Sun, 4 Sep 2005 23:28:51 GMT
Date:	Sun, 4 Sep 2005 23:28:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nicolas Sauzede <nsauzede@online.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: Compiling 2.6.13 CVS on Indy R4K
Message-ID: <20050904232851.GB3024@linux-mips.org>
References: <200509012216.25711.nsauzede@online.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509012216.25711.nsauzede@online.fr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 01, 2005 at 10:16:24PM +0200, Nicolas Sauzede wrote:

> ... fails like this :
> 
> .........
>   CC      arch/mips/kernel/module.o
>   AS      arch/mips/kernel/r4k_fpu.o
>   AS      arch/mips/kernel/r4k_switch.o
>   CC      arch/mips/kernel/irq_cpu.o
> {standard input}: Assembler messages:
> {standard input}:231: Error: unrecognized opcode `ehb '
> {standard input}:257: Error: unrecognized opcode `ehb '
> {standard input}:305: Error: unrecognized opcode `ehb '
> {standard input}:338: Error: unrecognized opcode `ehb '
> make[1]: *** [arch/mips/kernel/irq_cpu.o] Error 1
> make: *** [arch/mips/kernel] Error 2
> 
> Any ideas ??

You need binutils 2.16 to compile a CVS kernel.

  Ralf
