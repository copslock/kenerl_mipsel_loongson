Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 08:15:55 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:36058 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20022248AbXHaHPx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Aug 2007 08:15:53 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D7FCE200A1F0;
	Fri, 31 Aug 2007 09:15:21 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25568-02-12; Fri, 31 Aug 2007 09:15:09 +0200 (CEST)
Received: from [192.168.27.65] (6.240.216.81.static.lk.siwnet.net [81.216.240.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id CA83F200A202;
	Fri, 31 Aug 2007 09:15:06 +0200 (CEST)
Message-ID: <46D7BFF1.6000304@27m.se>
Date:	Fri, 31 Aug 2007 09:14:57 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Icedove 1.5.0.12 (X11/20070730)
MIME-Version: 1.0
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Exception while loading kernel
References: <1188030215.13999.14.camel@scarafaggio>	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>	 <1188321514.6882.3.camel@scarafaggio>	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>	 <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>	 <1188377693.7270.1.camel@scarafaggio>	 <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com> <1188539343.18249.2.camel@scarafaggio>
In-Reply-To: <1188539343.18249.2.camel@scarafaggio>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Which version are the toolchain binutils,gcc) you're using?

//Markus

Giuseppe Sacco wrote:
> Il giorno mer, 29/08/2007 alle 06.05 -0400, Ricardo Mendoza ha
> scritto:
>> On 8/29/07, Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
>> wrote:
>>
>>> I already tried the 32bit kernel and I found the same problem.
>>> Are you telling me that I should use 32bit for debugging
>>> instead of 64?
>> No, what I'm telling you to do is to try and build it with
>> CONFIG_BUILD_ELF64 disabled, more explicitly that is under
>> Executable file formats or something like that. About kgdb
>> debugging, what I am telling you is that ip32 has no hook ups
>> coded for it yet, in other words, no support.
>
> I tried recompiling the 2.6.23-rc3 from linux-mips.org with
> CONFIG_BUILD_ELF64=n, but I got a compiler error:
>
> CC [M]  net/sched/em_nbyte.o CC [M]  net/sched/em_u32.o CC [M]
> net/sched/em_meta.o net/sched/em_meta.c: In function
> â��meta_int_loadavg_0â��: net/sched/em_meta.c:127: error:
> PRINT_OPERAND, invalid operand for relocation (const:DI (plus:DI
> (symbol_ref:DI ("avenrun") [flags 0x40] <var_decl 0x2b357f50
> avenrun>) (const_int 4 [0x4]))) net/sched/em_meta.c:127: internal
> compiler error: in print_operand_reloc, at config/mips/mips.c:5579
> Please submit a full bug report, with preprocessed source if
> appropriate. See <URL:http://gcc.gnu.org/bugs.html> for
> instructions. For Debian GNU/Linux specific bug reporting
> instructions, see <URL:file:///usr/share/doc/gcc-4.1/README.Bugs>.
> {standard input}: Assembler messages: {standard input}:2436:
> Warning: end of file not at end of a line; newline inserted
> {standard input}:2547: Warning: missing .end at end of assembly
> Preprocessed source stored into /tmp/cc0KjlCH.out file, please
> attach this to your bugreport. make[3]: *** [net/sched/em_meta.o]
> Error 1 make[2]: *** [net/sched] Error 2 make[1]: *** [net] Error 2
>  make[1]: Leaving directory `/usr/local/src/linux-2.6.23-rc3' make:
> *** [debian/stamp-build-kernel] Error 2
>
> I will try to submit the bug report to gcc.
>
> Bye, Giuseppe
>
>


- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG17/u6I0XmJx2NrwRCEgWAKC/gDbBFTt2o6Vu8eiJr1J7BwOTFgCeODEq
DxydsZElXSV+ubTV8wQWGrc=
=ur/q
-----END PGP SIGNATURE-----
