Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 16:37:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57264 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007599AbbLDPhSp6Bg7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2015 16:37:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tB4FbHLf016844;
        Fri, 4 Dec 2015 16:37:17 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tB4FbH9U016843;
        Fri, 4 Dec 2015 16:37:17 +0100
Date:   Fri, 4 Dec 2015 16:37:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     James Hogan <james@albanarts.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 6/9] MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
Message-ID: <20151204153716.GA16238@linux-mips.org>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
 <1449137297-30464-7-git-send-email-matt.redfearn@imgtec.com>
 <56605081.5050307@cogentembedded.com>
 <5660577F.2020401@imgtec.com>
 <56607FE6.7040001@cogentembedded.com>
 <BA73413A-D335-4692-85A4-9330D7ACAC03@albanarts.com>
 <56614CB5.9020002@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56614CB5.9020002@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Dec 04, 2015 at 08:20:05AM +0000, Matt Redfearn wrote:

> >Although, it could still be reduced:
> >PTR_ADDU sp, gp, _THREAD_SIZE - 32 - PT_SIZE
> >
> >Assuming the immediate is in range of signed 16bit.
> 
> The immediate would be 32552, so in range of signed 16bit, but that would be
> brittle if either _THREAD_SIZE or PT_SIZE were to change in future....

The maximum value possible for _THREAD_SIZE would be with 64k pages for
which the expression will exceed the signed 16 bit range.  The good news
is that GAS is smart enough to cope with the situation by suitably
expanding the instruction into a macro unless ".set noat" or ".set nomacro"
mode are enabled:

$ cat s.s 
	addu	$sp, $gp, 65536
[ralf@h7 tmp]$ mips-linux-as -O2 -als -o s.o s.s
GAS LISTING s.s 			page 1


   1 0000 3C010001 		addu	$sp, $gp, 65536
   1      0381E821 
   1      00000000 
   1      00000000 

GAS LISTING s.s 			page 2


NO DEFINED SYMBOLS

NO UNDEFINED SYMBOLS
[ralf@h7 tmp]$ mips-linux-objdump -d s.o 
s.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <.text>:
   0:	3c010001 	lui	at,0x1
   4:	0381e821 	addu	sp,gp,at
	...

And of course that macro should better not be expanded in a branch
delay slot ...

  Ralf
