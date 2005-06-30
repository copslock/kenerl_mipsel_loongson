Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 18:20:41 +0100 (BST)
Received: from smtpa1.aruba.it ([IPv6:::ffff:62.149.128.206]:20372 "HELO
	smtpa2.aruba.it") by linux-mips.org with SMTP id <S8226093AbVF3RUW>;
	Thu, 30 Jun 2005 18:20:22 +0100
Received: (qmail 25932 invoked by uid 89); 30 Jun 2005 17:19:59 -0000
Received: by simscan 1.1.0 ppid: 25923, pid: 25927, t: 0.1530s
         scanners: clamav: 0.80/m:29/d:680
Received: from unknown (HELO ?192.168.32.1?) (fabrizio@fazzino.it@82.57.243.132)
  by smtp2.aruba.it with SMTP; 30 Jun 2005 17:19:59 -0000
Message-ID: <42C429C3.2090905@fazzino.it>
Date:	Thu, 30 Jun 2005 19:20:03 +0200
From:	Fabrizio Fazzino <fabrizio@fazzino.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org> <4256B5BE.8070708@fazzino.it> <20050408165717.GA8157@nevyn.them.org>
In-Reply-To: <20050408165717.GA8157@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fabrizio@fazzino.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fabrizio@fazzino.it
Precedence: bulk
X-list: linux-mips

After three months I still have the same problem...

Suppose I want to generate my own opcode, let's say 0xC4000000,
inside a C program. Suppose this value is NOT a constant in
the macro I want to write since it will contain three
variable fields for the rd,rs,rt registers, so I need to calculate
the opcode at least at compilation time (at runtime is NOT
required).

Daniel suggested using .word and writing the function by hand,
but which is the syntax I have to use?

#define myopcode(rs,rt,rd) { \
   int opcode_number = 0xC4000000 | (rs<<21) | (rt<<16) | (rd<<11); \
   char opcode_string[20]; \
   sprintf(opcode_string, ".word 0x%X", opcode_number); \
   asm(opcode_string); \
}

This doesn't work since "argument of 'asm' is not a constant string"...
Furthermore I do NOT have the possibility to link the string library
so I should find another solution.

Is there any common solution to write an instruction "completely
by hand" ?

Many thanks in advance,

	Fabrizio Fazzino



Daniel Jacobowitz wrote:
> On Fri, Apr 08, 2005 at 06:47:58PM +0200, Fabrizio Fazzino wrote:
> 
>>Ralf Baechle wrote:
>>
>>>Fabrizio Fazzino wrote:
>>>
>>>>It works, but I need a way to set the values of the parameters
>>>>at runtime; so I've tried the following macro:
>>>>
>>>>	#define fzmin(rd, rs, rt) asm("lwc1 $rt, rd<<11($rs)");
>>>
>>>Which will leave the assembler entirely unimpressed ;-)
>>
>>I thought that the compiler was able to substitute also the
>>values inside strings... Is there any way to force it to do so?
> 
> You should probably be using .word then, and generating the instruction
> completely by hand.
> 


-- 
============================================
    Fabrizio Fazzino - fabrizio@fazzino.it
      Fazzino.IT - http://www.fazzino.it
============================================
