Received:  by oss.sgi.com id <S553790AbRAXP7Q>;
	Wed, 24 Jan 2001 07:59:16 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:5393 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553785AbRAXP7D>;
	Wed, 24 Jan 2001 07:59:03 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6DF617FA; Wed, 24 Jan 2001 16:58:58 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7CED3EE9C; Wed, 24 Jan 2001 16:59:19 +0100 (CET)
Date:   Wed, 24 Jan 2001 16:59:19 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Re: OOps - very obscure
Message-ID: <20010124165919.C15348@paradigm.rfc822.org>
References: <20010124163048.B15348@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010124163048.B15348@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Jan 24, 2001 at 04:30:48PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 04:30:48PM +0100, Florian Lohoff wrote:
> Hi,
> here a short oops while trying to run "find" in a glibc 2.2 root
> on a Indigo2 with a current cvs 2.4.0 kernel.
> 
> Unable to handle kernel paging request at virtual address 00000000, epc == 00000000, ra == 00000000

Decoded this is:

Unable to handle kernel paging request at virtual address 00000000, epc == 00000000, ra == 00000000
$0 : 00000000 1004fc00 fffffff2 00000001
$4 : fffffff2 00000000 00000001 00000000
$8 : 00000000 2abf3a94 8800f4a0 00000004
$12: 8ec09f10 7ffffaf8 8ec09f18 8ec09f18
$16: 8801acf8 00000000 10011510 00000002
$20: 10011510 7ffffdd8 7ffffdcc 00000002
$24: 00000000 2abf3a80
$28: 8ec08000 8ec09ef8 7ffffd10 00000000
epc   : 00000000
Using defaults from ksymoops -t elf32-bigmips -a mips:3000
Status: 1004fc03
Cause : 30000008
Process find (pid: 242, stackpage=8ec08000)
Stack: 10011510 7ffffd10 88028344 00000000 7ffffc80 00402440 2aca4e00 2ac95d10
       00000000 2ac95d10 10011510 00000002 00000001 8800fa88 000007d1 100235b0
       10011510 00000000 00000003 00012000 00000000 1004fc01 00001035 00000000
       000007d1 10011510 00000001 00000000 0000fc00 00000010 00000000 8ec09f0c
       8ec09f10 8ec09f14 8ec09ef8 8ec09efc 2aca4e00 2ac95d10 10011510 00000002
       00000001 ...
Call Trace: [<88028344>] [<8800fa88>]
Code: (Bad address in epc)
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: (Bad address in epc)'
  Garbage: 'ress in epc)'
Warning (Oops_code_values): Code looks like message, not hex digits.  No disassembly attempted.

>>RA;  00000000 Before first symbol
>>PC;  00000000 Before first symbol
Trace; 88028344 <sys_nanosleep+190/24c>
Trace; 8800fa88 <stack_done+1c/38>

I guess the "Garbage" stuff has to be fixed in ksymoops

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
