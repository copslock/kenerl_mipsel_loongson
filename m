Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1F3rk806264
	for linux-mips-outgoing; Thu, 14 Feb 2002 19:53:46 -0800
Received: from dea.linux-mips.net (a1as18-p131.stg.tli.de [195.252.193.131])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1F3rb906261
	for <linux-mips@oss.sgi.com>; Thu, 14 Feb 2002 19:53:37 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1F2nwm23669;
	Fri, 15 Feb 2002 03:49:58 +0100
Date: Fri, 15 Feb 2002 03:49:58 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Adrian.Hulse@taec.toshiba.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Tools issue
Message-ID: <20020215034958.C21011@dea.linux-mips.net>
References: <OF7ACD949C.CF1ABCAF-ON88256B60.00728091@taec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF7ACD949C.CF1ABCAF-ON88256B60.00728091@taec.com>; from Adrian.Hulse@taec.toshiba.com on Thu, Feb 14, 2002 at 01:42:31PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 14, 2002 at 01:42:31PM -0800, Adrian.Hulse@taec.toshiba.com wrote:

> I am experiencing some strange behaviour dependent on the tools I use and I
> was wondering if anyone on this list, has experienced similar problems or
> may know the answer to my problem.
> 
> To date I have been using the following tools from the SGI site to
> successfully compile and boot a 2.4.12 little endian mips kernel :
> 
> binutils-mipsel-linux-2.8.1-2.i386.rpm
> egcs-mipsel-linux-1.1.2-4.i386.rpm
> 
> As an experiment I decided to try the "toolchain-20011020" tools also from
> the SGI site to compile the exact same kernel, but the compile fails with
> the following 2 errors :
> 
> ctfb.c:1158: warning: duplicate `const'
> {standard input}:11123: Error: expression too complex
> {standard input}:11123: Fatal Error: internal Error, line 1980,
> ../../tools-20011020/gas/config/tc-mips.c
> make[3]: ***[ctfb.o] Error 2

Can you post the compiler generated assembler that is causing this
error?

What kernel version is this?

> int-handler.s:59: Error: missing ')'
> int-handler.s:59: Error: illegal operands `lui'
> int-handler.s:60: Error: missing ')'
> int-handler.s:60: Error: illegal operands `sb'
> make[1]: *** [ int-handler.o ] Error 1
> 
> I can get around the first error by just disabling CONFIG_FB_CT in the
> config and recompiling. Note the monta vista toolchain also fails in the
> same file, with I think the same error.
> I can get around the second error by one of two methods :
> a, just comment it out because all it's doing is lighting up an led
> according to the interrupt received
> b, by changing a parenthesised define to non-parenthesised form :
> 
> int-handler.S
> <l59>     lui  t1, %hi(TSDB_LED_ADDR)
> <l60>     sb   t0, %lo(TSDB_LDE_ADDR)(t1)
> 
> Failed define :
> #define   TSDB_LED_ADDR  (KSEG1 + TSDB_LB_PCU_APERTURE + 0x05100020)
> 
> Compilable define :
> #define   TSDB_LED_ADDR  KSEG1 + TSDB_LB_PCU_APERTURE + 0x05100020
> 
> So with the above 2 kludges I can get the kernel to compile, but now when I
> come to boot it, the board it just locks failing somewhere in console_init
> ( currently investigating ).

Binutils 2.8.x are definately buggy; 2.9.5.x on oss are the oldest
version that's sortof working ...

> Anyone else seen anything like this and know of a solution to the problem ?
> Or to paraphrase Dominic Sweetman, maybe i should just stay with the "pick
> your own version folklore" method of picking tools :).

I hope that for binutils we can solve that problem when 2.9.12 gets
released; as for gcc it seems Maciej's 2.95.3 version is already pretty
close to what we want.  C++ users may disagree ;-)  Somewhat longer term
Algorithmics's toolchain should resolve the situation.

  Ralf
