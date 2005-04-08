Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 17:48:22 +0100 (BST)
Received: from smtpa1.aruba.it ([IPv6:::ffff:62.149.128.206]:41417 "HELO
	smtpa1.aruba.it") by linux-mips.org with SMTP id <S8225417AbVDHQsG>;
	Fri, 8 Apr 2005 17:48:06 +0100
Received: (qmail 2205 invoked by uid 511); 8 Apr 2005 16:47:58 -0000
Received: from fabrizio@fazzino.it by smtpa1.aruba.it by uid 503 with qmail-scanner-1.20 
 (avp(2004-04-15).  Clear:RC:0(82.51.96.131):. 
 Processed in 0.014562 secs); 08 Apr 2005 16:47:58 -0000
Received: from unknown (HELO ?192.168.32.1?) (fabrizio@fazzino.it@82.51.96.131)
  by smtpa1.aruba.it with SMTP; 8 Apr 2005 16:47:58 -0000
Message-ID: <4256B5BE.8070708@fazzino.it>
Date:	Fri, 08 Apr 2005 18:47:58 +0200
From:	Fabrizio Fazzino <fabrizio@fazzino.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org>
In-Reply-To: <20050407182549.GA24235@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fabrizio@fazzino.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fabrizio@fazzino.it
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Fabrizio Fazzino wrote:
> 
>>It works, but I need a way to set the values of the parameters
>>at runtime; so I've tried the following macro:
>>
>>	#define fzmin(rd, rs, rt) asm("lwc1 $rt, rd<<11($rs)");
> 
> Which will leave the assembler entirely unimpressed ;-)

I thought that the compiler was able to substitute also the
values inside strings... Is there any way to force it to do so?

> Unless you only have a few instructions and are going for a quick hack
> I really suggest to add proper support for these instructions to binutils.
> Having working support in as, gdb, objdump will make your life so much
> easier.

The processor I'm designing probably will not be implemented in
any way (we just have to simulate the VHDL hardware description),
so we just need a quick-and-dirty way to make the opcode
conversion.

	Fabrizio


-- 
============================================
    Fabrizio Fazzino - fabrizio@fazzino.it
      Fazzino.IT - http://www.fazzino.it
============================================
