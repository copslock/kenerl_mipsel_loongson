Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g26Kc4X29866
	for linux-mips-outgoing; Wed, 6 Mar 2002 12:38:04 -0800
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g26Kbv929862
	for <linux-mips@oss.sgi.com>; Wed, 6 Mar 2002 12:37:57 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id LAA10148;
	Wed, 6 Mar 2002 11:37:42 -0800 (PST)
Received: from richt.mips.com (richt [192.168.65.186])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA29556;
	Wed, 6 Mar 2002 11:37:44 -0800 (PST)
Received: from mips.com (localhost [127.0.0.1])
	by richt.mips.com (8.9.3/8.9.0) with ESMTP id LAA18469;
	Wed, 6 Mar 2002 11:37:44 -0800 (PST)
Message-ID: <3C867007.FB94B0D@mips.com>
Date: Wed, 06 Mar 2002 11:37:44 -0800
From: "Kevin D. Kissell" <kevink@mips.com>
Organization: MIPS Technologies Inc.
X-Mailer: Mozilla 4.61 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Sanjay Jain <sjain@Sanera.net>
CC: linux-mips@oss.sgi.com
Subject: Re: unhandled kernel  unaligned access
References: <MPEHJBMAKDIKNMNLMJCLIELJCBAA.sjain@sanera.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Which sources are you using?  Up until pretty recently,
there was a bug in unaligned.c which could cause this.
I don't know when it was fixed at SGI, but the fix
is in the 2.4.19-pre2 sources at kernel.org.  The problem
was that the epc value in the exception context was
being advanced to the next instruction prior to the
invocation of search_exception_table(regs->cp0_epc).
The 2.4.19-pre2 code solves the problem by re-ordering
the operations and delaying the advancement of epc.
My own quick-and-dirty hack was simply to use the
unmutilated value which is also available to
emulate_load_store_insn(), changing that one line
to be "fixup = search_exception_table(pc)".  That
seems to work.

			Kevin K.

Sanjay Jain wrote:
> 
> hi all,
> 
> I am running a kernel test program which makes following call.
> 
> getpeername(s, tdat[testno].sockaddr,tdat[testno].salen));
> 
> In one particular case tdat[testno].salen is set to 1 which is a unaligned
> and invalid addr. It results in following oops.
> 
> Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn,
> line
> 373:
> $0 : 00000000 10000024 00000000 00000005
> $4 : 10000d20 00000000 10000d20 00000001
> $8 : ffffffff 8b179e98 801c6da0 00000003
> $12: 00000000 00000002 8b179ecc 8f9875bc
> $16: 8b1954c0 00000001 10000d20 00000001
> $20: 004014e0 10002e08 00000000 0000000d
> $24: 00000001 2ac2db50
> $28: 8b178000 8b179e70 7fff7c70 801c6e2c
> epc    : 00000000801c58d4
> Status : 10009f03
> Cause  : 00800010
> 
> BadAddr: 0000000000000001Process getpeername01 (pid: 9673,
> stackpage=8b178000)
> Stack: 8b179ec8 8eedf5a0 8b1954c0 00000001 801c6e2c 801c6dc4 8022370c
> 8020c788
>        8b179ec8 8eedf5a0 00010060 8eedf5a0 00000005 801c5b08 802c2048
> 8023a65c
>        000001d7 00000400 8b179ec8 00000005 000001d7 8eeb7780 5b343731
> 5d00d538
>        8fd2cd80 ffffffea 8eeb7780 00000000 00000000 00000001 00000003
> 00000003
>        7fff7c58 00000002 801c69b8 00406950 00401190 00000001 7fff7d24
> 00406950
>        8b1954c0 ...
> Call Trace: [<801c6e2c>] [<801c6dc4>] [<8022370c>] [<8020c788>] [<801c5b08>]
> [<
> 8023a65c>]
>  [<801c69b8>] [<8010dce8>]
> 
> Code: 04600003  00402821  8ce20000 <00002821> 00403021  10a00004  00a01021
> 8fb
> f0010  03e00008
> 
> Is this the expected behavior if an unaligned address is passed in a system
> call?
