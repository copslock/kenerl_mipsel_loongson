Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 07:21:10 +0100 (BST)
Received: from web60701.mail.yahoo.com ([IPv6:::ffff:216.109.117.224]:11181
	"HELO web60701.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225207AbUC2GVI>; Mon, 29 Mar 2004 07:21:08 +0100
Message-ID: <20040329062101.84127.qmail@web60701.mail.yahoo.com>
Received: from [61.11.17.69] by web60701.mail.yahoo.com via HTTP; Sun, 28 Mar 2004 22:21:01 PST
Date: Sun, 28 Mar 2004 22:21:01 -0800 (PST)
From: Shantanu Gogate <sagogate@yahoo.com>
Subject: Re: mips gcc compile error : unrecognized opcode errors
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Chris Dearman <chris@mips.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.55.0403261134030.3736@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <sagogate@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagogate@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi guys,
Thanks for your replies ! Sure enough, the problem I mentioned about unrecognized opcodes was
caused by screwed up Makefiles(include from standard host includes was erroneously taking place).
I am past that hurdle now but facing a different problem:

1. I started getting some pretty weird unresolved symbol messages, which i figured was happening
because it was not taking in libc.a and libgcc.a. This was happening although I had placed the
libc.a and libgcc.a dir in the libsearch dir using the '-L' flag to gcc. 

2. So I gave the libc.a and libgcc.a path directly on the command prompt and it did build the
binary file but gave warning that 
'cannot find entry symbol __start; defaulting to 0000000000400090'
I guess this is because it cannot find crt1.o or the other crt*.o files ?
So, maybe even though I have got the binary file, it won run properly since it 'defaulted' the
start address to something.

3. My situation is like this : I have got the 'usr' directory from
'glibc-devel-2.2.5-42.1.mips.rpm'  placed in a directory called '/work/GLIBC/' and I have
'sdelinux 5.03eb installed' on my redhat 7.3 host machine. Can you guys tell me how I need to
setup the Makefiles for that app so as to get a clean build ? If this is out of your domain can
you point me to some resources (other than gcc man pages ;) ) which talks about setting up
cross-compile environments ?

Chris:
as for your question about what problems I faced compiling busybox with sdelinux-5.01 (not 5.06 as
u said):
there is some code (i forgot the location now) which uses flexible length arrays in a struct and
there are 2 such arrays declared in a struct one after the other as the last two entries in that
struct. gcc used to bail out here cribbing that 'flexible length array not at end of struct'. 
After going thru a few posts I stumbled upon your reply
(http://www.linux-mips.org/archives/linux-mips/2003-11/msg00015.html) where u said that it was
fixed in updated version of compiler. (i was compiling busybox-1.00-pre4). using 5.03 i did not
face this problem.


thanks in advance,
/shantanu.

--- "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> On Fri, 26 Mar 2004, Shantanu Gogate wrote:
> 
> > I am trying to cross compile a user mode application for mips and I am getting these error
> > messages when trying to do that:
> > 
> > /tmp/ccgvdHuk.s: Assembler messages:
> > /tmp/ccgvdHuk.s:1270: Error: unrecognized opcode `btl $4,0($2)'
> > /tmp/ccgvdHuk.s:1270: Error: unrecognized opcode `setcb $25'
> > /tmp/ccgvdHuk.s:3124: Error: unrecognized opcode `btl $4,0($2)'
> > /tmp/ccgvdHuk.s:3124: Error: unrecognized opcode `setcb $25'
> > /tmp/ccgvdHuk.s:3769: Error: unrecognized opcode `btl $4,0($2)'
> > /tmp/ccgvdHuk.s:3769: Error: unrecognized opcode `setcb $25'
> 
>  These are not MIPS instructions.  Make sure the file is built with a 
> compiler for the MIPS target.  There's likely a bug in your Makefile.
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
