Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 18:54:12 +0100 (BST)
Received: from smtpa1.aruba.it ([IPv6:::ffff:62.149.128.206]:20386 "HELO
	smtpa1.aruba.it") by linux-mips.org with SMTP id <S8225280AbVDGRx5>;
	Thu, 7 Apr 2005 18:53:57 +0100
Received: (qmail 6992 invoked by uid 511); 7 Apr 2005 17:53:51 -0000
Received: from fabrizio@fazzino.it by smtpa1.aruba.it by uid 503 with qmail-scanner-1.20 
 (avp(2004-04-15).  Clear:RC:0(82.51.107.222):. 
 Processed in 0.047367 secs); 07 Apr 2005 17:53:51 -0000
Received: from unknown (HELO ?192.168.32.1?) (fabrizio@fazzino.it@82.51.107.222)
  by smtpa1.aruba.it with SMTP; 7 Apr 2005 17:53:50 -0000
Message-ID: <425573AD.9010702@fazzino.it>
Date:	Thu, 07 Apr 2005 19:53:49 +0200
From:	Fabrizio Fazzino <fabrizio@fazzino.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Assembly macro with parameters
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fabrizio@fazzino.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fabrizio@fazzino.it
Precedence: bulk
X-list: linux-mips

Hi all,
I'm working to an hardware extension of the MIPS32 instruction set
and I need to convert my new instruction into an existing opcode
to make it possible for the normal GCC to correctly compile the code.

Just to be clear, to obtain my new FZMIN instruction like

	FZMIN $rd, $rs, $rt

I have to convert it into

	LWC1 $rt, rd<<11 ($rs)

that is an existing (in some cases unused) opcode.

I'm currently using hardcoded values for the parameters, so
fzmin(10,8,9) will be transformed into
	asm("lwc1 $9, 10<<11($8)" : : : "$10");

It works, but I need a way to set the values of the parameters
at runtime; so I've tried the following macro:

	#define fzmin(rd, rs, rt) asm("lwc1 $rt, rd<<11($rs)");

As you can imagine I'm not an expert of MIPS Assembly macros:
what I've written does NOT work since the values of rd,rs,rt
are NOT substituted inside the asm string.

Is there any way to do what I need? I would appreciate your
help very much.

Cheers,
	Fabrizio


-- 
============================================
    Fabrizio Fazzino - fabrizio@fazzino.it
      Fazzino.IT - http://www.fazzino.it
============================================
