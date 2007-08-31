Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 06:51:58 +0100 (BST)
Received: from host78-221-dynamic.2-87-r.retail.telecomitalia.it ([87.2.221.78]:61189
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022212AbXHaFv4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Aug 2007 06:51:56 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IQzMz-0008Bh-Pr
	for linux-mips@linux-mips.org; Fri, 31 Aug 2007 07:48:39 +0200
Subject: Re: Exception while loading kernel
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com>
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>
	 <1188321514.6882.3.camel@scarafaggio>
	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
	 <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>
	 <1188377693.7270.1.camel@scarafaggio>
	 <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date:	Fri, 31 Aug 2007 07:49:03 +0200
Message-Id: <1188539343.18249.2.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 8BIT
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mer, 29/08/2007 alle 06.05 -0400, Ricardo Mendoza ha scritto:
> On 8/29/07, Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> wrote:
> 
> > I already tried the 32bit kernel and I found the same problem. Are you
> > telling me that I should use 32bit for debugging instead of 64?
> 
> No, what I'm telling you to do is to try and build it with
> CONFIG_BUILD_ELF64 disabled, more explicitly that is under Executable
> file formats or something like that. About kgdb debugging, what I am
> telling you is that ip32 has no hook ups coded for it yet, in other
> words, no support.

I tried recompiling the 2.6.23-rc3 from linux-mips.org with
CONFIG_BUILD_ELF64=n, but I got a compiler error:

  CC [M]  net/sched/em_nbyte.o
  CC [M]  net/sched/em_u32.o
  CC [M]  net/sched/em_meta.o
net/sched/em_meta.c: In function ‘meta_int_loadavg_0’:
net/sched/em_meta.c:127: error: PRINT_OPERAND, invalid operand for relocation
(const:DI (plus:DI (symbol_ref:DI ("avenrun") [flags 0x40] <var_decl 0x2b357f50 avenrun>)
        (const_int 4 [0x4])))
net/sched/em_meta.c:127: internal compiler error: in print_operand_reloc, at config/mips/mips.c:5579
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
For Debian GNU/Linux specific bug reporting instructions,
see <URL:file:///usr/share/doc/gcc-4.1/README.Bugs>.
{standard input}: Assembler messages:
{standard input}:2436: Warning: end of file not at end of a line; newline inserted
{standard input}:2547: Warning: missing .end at end of assembly
Preprocessed source stored into /tmp/cc0KjlCH.out file, please attach this to your bugreport.
make[3]: *** [net/sched/em_meta.o] Error 1
make[2]: *** [net/sched] Error 2
make[1]: *** [net] Error 2
make[1]: Leaving directory `/usr/local/src/linux-2.6.23-rc3'
make: *** [debian/stamp-build-kernel] Error 2

I will try to submit the bug report to gcc.

Bye,
Giuseppe
