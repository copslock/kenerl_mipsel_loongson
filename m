Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 18:32:53 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:53773
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226098AbVF3Rci>;
	Thu, 30 Jun 2005 18:32:38 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 30 Jun 2005 10:33:49 -0700
Message-ID: <42C42CA7.3080106@avtrex.com>
Date:	Thu, 30 Jun 2005 10:32:23 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Fabrizio Fazzino <fabrizio@fazzino.it>
CC:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org> <4256B5BE.8070708@fazzino.it> <20050408165717.GA8157@nevyn.them.org> <42C429C3.2090905@fazzino.it>
In-Reply-To: <42C429C3.2090905@fazzino.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2005 17:33:49.0250 (UTC) FILETIME=[E00F6220:01C57D99]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Fabrizio Fazzino wrote:
> After three months I still have the same problem...
> 
> Suppose I want to generate my own opcode, let's say 0xC4000000,
> inside a C program. Suppose this value is NOT a constant in
> the macro I want to write since it will contain three
> variable fields for the rd,rs,rt registers, so I need to calculate
> the opcode at least at compilation time (at runtime is NOT
> required).
> 
> Daniel suggested using .word and writing the function by hand,
> but which is the syntax I have to use?
> 
> #define myopcode(rs,rt,rd) { \
>   int opcode_number = 0xC4000000 | (rs<<21) | (rt<<16) | (rd<<11); \
>   char opcode_string[20]; \
>   sprintf(opcode_string, ".word 0x%X", opcode_number); \
>   asm(opcode_string); \
> }
> 

The arguments to the asm() statement are strings not char*.  They are 
evaluated at compile time not run time.

You will probably have to use the C preprocessor stringification and 
concatination operators ('#' and '##').

David Daney
