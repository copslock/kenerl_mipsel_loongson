Received:  by oss.sgi.com id <S42275AbQIYVGr>;
	Mon, 25 Sep 2000 14:06:47 -0700
Received: from smtp.algor.co.uk ([62.254.210.199]:31718 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S42201AbQIYVGV>;
	Mon, 25 Sep 2000 14:06:21 -0700
Received: from gladsmuir.algor.co.uk (dom@gladsmuir.algor.co.uk [192.168.5.75])
	by kenton.algor.co.uk (8.9.3/8.8.8) with ESMTP id WAA21144;
	Mon, 25 Sep 2000 22:05:45 +0100 (GMT/BST)
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.8.5/8.8.5) id WAA01137;
	Mon, 25 Sep 2000 22:16:33 +0100 (GMT/BST)
Date:   Mon, 25 Sep 2000 22:16:33 +0100 (GMT/BST)
Message-Id: <200009252116.WAA01137@gladsmuir.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
In-Reply-To: <39CF9DFC.F30B302B@mvista.com>
References: <39CF9DFC.F30B302B@mvista.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Jun Sun (jsun@mvista.com) writes:

> The USB sub-system uses "unaligned.h" file to access unaligned data. 
> All the unaligned data access functions depend on "uld" and "usw"
> instructions, which are not available on many CPUs.

You won't find the instruction 'uld' in *any* MIPS CPU.

uld is an assembler macro-instruction translating into a 

  ldl
  ldr

pair (the instructions are called load-double-left and
load-double-right).  The exact translation depends on whether you're
running big-endian or little-endian... but the 32-bit version on a
big-endian CPU is that 

  ulw $1, <address>

is assembled as

  lwl $1, <address>
  lwr $1, <address+3>

The way that the load-left and load-right work together is kind of
tricky to get your head round.  

So far as I know, all 64-bit MIPS CPUs implement ldl/ldr and the store
equivalents.  MIPS patented these instructions, so clones like Lexra's
don't implement the 32-bit versions (lwl, lwr etc).

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / http://www.algor.co.uk
