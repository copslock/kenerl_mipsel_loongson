Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2005 08:21:52 +0100 (BST)
Received: from smtpa1.aruba.it ([IPv6:::ffff:62.149.128.206]:30701 "HELO
	smtpa2.aruba.it") by linux-mips.org with SMTP id <S8226376AbVGIHVf>;
	Sat, 9 Jul 2005 08:21:35 +0100
Received: (qmail 21245 invoked by uid 89); 9 Jul 2005 07:22:08 -0000
Received: by simscan 1.1.0 ppid: 21236, pid: 21241, t: 0.1636s
         scanners: clamav: 0.80/m:29/d:680
Received: from unknown (HELO ?192.168.32.1?) (fabrizio@fazzino.it@82.57.252.179)
  by smtp2.aruba.it with SMTP; 9 Jul 2005 07:22:08 -0000
Message-ID: <42CF7B20.5010101@fazzino.it>
Date:	Sat, 09 Jul 2005 09:22:08 +0200
From:	Fabrizio Fazzino <fabrizio@fazzino.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org> <4256B5BE.8070708@fazzino.it> <20050408165717.GA8157@nevyn.them.org> <42C429C3.2090905@fazzino.it> <Pine.LNX.4.61L.0507010927130.30138@blysk.ds.pg.gda.pl> <42C7BE64.7020102@fazzino.it> <Pine.LNX.4.61L.0507041306440.32001@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0507041306440.32001@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fabrizio@fazzino.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fabrizio@fazzino.it
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> Fabrizio Fazzino wrote:
> 
>>By the way, is there any quick way of writing a setreg(reg_num,reg_val)
>>C macro to set the value of a register?

Hi guys,
just to let you know that I solved my problem this way:

    // Set a register to the desired value
    #define setreg(regnum,value) asm("move $" #regnum ", %0" : : "r"(value) : "$" #regnum)

    // Move the content of a register to the desired variable
    #define reg2var(regnum,var) asm("sw $" #regnum ", %0" : "=m"(*var) : : "memory")

>  BTW, how about adding support for opcodes you are interested in to 
> binutils instead?  It would make interfacing them to GCC much easier.

The CPU I'm working on will never "exist"... I'm just simulating it
as VHDL code, so I just needed a quick-and-dirty way of generating
inside my very short test programs the new opcodes added as an extension.

Thanks to all for your precious support!

Cheers and regards,

         Fabrizio


-- 
============================================
    Fabrizio Fazzino - fabrizio@fazzino.it
      Fazzino.IT - http://www.fazzino.it
============================================
