Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 17:48:04 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:64303 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225009AbUGSQr5>;
	Mon, 19 Jul 2004 17:47:57 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 19 Jul 2004 09:47:43 -0700
Message-ID: <40FBFA43.4080305@avtrex.com>
Date: Mon, 19 Jul 2004 09:43:47 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: martin.nichols@oxinst.co.uk
CC: linux-mips@linux-mips.org
Subject: Re: Link errors
References: <DEF431FFDB15C1488464F0E57D5506642AA539@MEDNT02>
In-Reply-To: <DEF431FFDB15C1488464F0E57D5506642AA539@MEDNT02>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jul 2004 16:47:43.0905 (UTC) FILETIME=[1CDBB910:01C46DB0]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

martin.nichols@oxinst.co.uk wrote:
> Hi All,
> 
> I'm new to MIPs architecture and Linux so apologies in advance!
> 
> I'm trying to build an application to run on the Au1100.
> I have a crosscompiler setup (gcc 3.2) and can build a 'hello world' that
> runs on the target.
> When I try building a more serious application using Kdevelop - with the
> appropriate settings
> for the crosstools - I get lots of errors like this:
> assert.o(.text+0x1cc): relocation truncated to fit: R_MIPS_GOT16
> __assert_program_name
> /opt/crosstool/mipsel-unknown-linux-gnu/gcc-3.2.3-glibc-2.2.3/mipsel-unknown
> -linux-gnu/lib/libc.a(dcigettext.o): In function `_nl_find_msg':
> dcigettext.o(.text+0x153c): relocation truncated to fit: R_MIPS_CALL16
> _nl_load_domain
> /opt/crosstool/mipsel-unknown-linux-gnu/gcc-3.2.3-glibc-2.2.3/mipsel-unknown
> -linux-gnu/lib/libc.a(finddomain.o): In function `_nl_find_domain':
> 
> Could someone tell me what I'm doing wrong please.
> 
This is the got overflow problem.

Later versions of binutils have multi-got support (2.15 for example),
which under most circumstances will fix the problem.

If you have extreamly large compilation units you might have to use a
32bit got index.  In GCC3.4 and later this is done with the -mxgot
option.  With eariler versions of GCC you have to pass -xgot to the
assembler (-Wa,-xgot IIRC).

David Daney.
