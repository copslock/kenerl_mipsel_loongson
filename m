Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jul 2005 11:31:15 +0100 (BST)
Received: from smtpa1.aruba.it ([IPv6:::ffff:62.149.128.206]:39657 "HELO
	smtpa1.aruba.it") by linux-mips.org with SMTP id <S8226116AbVGCKa7>;
	Sun, 3 Jul 2005 11:30:59 +0100
Received: (qmail 6786 invoked by uid 89); 3 Jul 2005 10:30:58 -0000
Received: by simscan 1.1.0 ppid: 6778, pid: 6784, t: 0.1984s
         scanners: clamav: 0.80/m:29/d:680
Received: from unknown (HELO ?192.168.32.1?) (fabrizio@fazzino.it@82.57.252.232)
  by smtp1.aruba.it with SMTP; 3 Jul 2005 10:30:57 -0000
Message-ID: <42C7BE64.7020102@fazzino.it>
Date:	Sun, 03 Jul 2005 12:31:00 +0200
From:	Fabrizio Fazzino <fabrizio@fazzino.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org> <4256B5BE.8070708@fazzino.it> <20050408165717.GA8157@nevyn.them.org> <42C429C3.2090905@fazzino.it> <Pine.LNX.4.61L.0507010927130.30138@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0507010927130.30138@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fabrizio@fazzino.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fabrizio@fazzino.it
Precedence: bulk
X-list: linux-mips

Many thanks Maciej and David,
during these days I've learned a lot about stringification, a feature
that I had never used before.

In any case I didn't have to use this feature... I was just missing the
fact that the opcode evaluation didn't have to happen by declaring an
int variable (in this case the value is computed at runtime) but by the
preprocessor, so I solved my problem this way:

#define NEWOPCODE(base,rd,rs,rt) (base|(rs<<21)|(rt<<16)|(rd<<11))
#define myopcode(rd,rs,rt) asm(".long %0" : : "i" (NEWOPCODE(0xC4000000,rd,rs,rt)))

and then I call it simply as myopcode(10,8,9).

By the way, is there any quick way of writing a setreg(reg_num,reg_val)
C macro to set the value of a register?
And another one to read the value like a reg2var(reg_num,&result) to put
the value of a register inside my own C variable?
I have written my own versions for both but they have a 32-case switch
statement inside so they are not so efficient...

In any case thanks a lot for your suggestions, I've put acknowledgments
to macro@linux-mips.org inside my code!

	Fabrizio


David Daney wrote:
> 
> The arguments to the asm() statement are strings not char*.  They are evaluated at compile time not run time.
> 
> You will probably have to use the C preprocessor stringification and concatination operators ('#' and '##').
> 
> David Daney
> 

Maciej W. Rozycki wrote:
> 
>  This is untested, but it should be a reasonable starting point:
> 
> #define myopcode(rs,rt,rd) do { \
> 	int opcode_number = 0xC4000000 | (rs<<21) | (rt<<16) | (rd<<11); \
> 	asm(".word %0" : : "i" (opcode_number)); \
> } while (0)
> 
> But you may want to add code to tell GCC that these registers are used and 
> how, because otherwise you may have little use of your macro.  You'll 
> probably have to investigate the explicit register variable GCC feature 
> and cpp stringification.  It should be straightforward though rather 
> boring, so I'm leaving it as an exercise.
> 
>   Maciej
> 


-- 
============================================
    Fabrizio Fazzino - fabrizio@fazzino.it
      Fazzino.IT - http://www.fazzino.it
============================================
