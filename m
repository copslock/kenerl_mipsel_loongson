Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 11:49:23 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:4253 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133488AbWFBJtO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2006 11:49:14 +0200
Received: from lagash (88-106-172-197.dynamic.dsl.as9105.com [88.106.172.197])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 2F6834475F; Fri,  2 Jun 2006 11:49:01 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fm6Gl-0003iO-KW; Fri, 02 Jun 2006 10:48:39 +0100
Date:	Fri, 2 Jun 2006 10:48:39 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: BFD: Warning: Writing section `.text' to huge (ie negative) file offset 0xa1ffff10
Message-ID: <20060602094839.GA32544@networkno.de>
References: <50c9a2250605312319v7480f2el36d9c0a052c85d5f@mail.gmail.com> <20060601092413.GL1717@networkno.de> <50c9a2250606010356s63f6d6e7j255c77660d6f472a@mail.gmail.com> <447EE274.7060207@mips.com> <50c9a2250606011749r7f89fbben2c61edd43c7ec0a6@mail.gmail.com> <50c9a2250606011950h7669c9a7w375e54cf513dcee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250606011950h7669c9a7w375e54cf513dcee@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

zhuzhenhua wrote:
[snip]
> >Idx Name          Size      VMA       LMA       File off  Algn
> >  0 .text         0000b140  72000000  72000000  00010000  2**4
> >                  CONTENTS, ALLOC, LOAD, READONLY, CODE
> >  1 .data         00001080  7200b140  7200b140  0001b140  2**4
> >                  CONTENTS, ALLOC, LOAD, DATA
> >  2 .sbss         00000010  7200c1c0  7200c1c0  0001c1c0  2**2
> >                  ALLOC
> >  3 .bss          000008a0  7200c1d0  7200c1d0  0001c1c0  2**4
> >                  ALLOC
> >  4 .reginfo      00000018  7200ca70  7200ca70  0001ca70  2**2
> >                  CONTENTS, ALLOC, LOAD, READONLY, DATA, 
> >                  LINK_ONCE_SAME_SIZE
> >  5 .pdr          000011a0  00000000  00000000  0001ca88  2**2
> >                  CONTENTS, READONLY
> >  6 .mdebug.abi32 00000000  00000000  00000000  0001dc28  2**0
> >                  CONTENTS, READONLY
> >  7 .comment      000000ea  00000000  00000000  0001dc28  2**0
> >                  CONTENTS, READONLY
> >  8 .rodata       00000190  000000f0  000000f0  000000f0  2**4
> >                  CONTENTS, ALLOC, LOAD, READONLY, DATA
> >  9 .rodata.str1.4 000005fe  00000280  00000280  00000280  2**2
> >                  CONTENTS, ALLOC, LOAD, READONLY, DATA
> 
> the 0x72xxxxxx should be 0xa2xxxxxx, because i can't pass by set
> 0xa2000000,so i change the .text to 0x72000000, and it can get the
> .bin correctly.

At some version the check for sign extensions was broken for MIPS
binutils, in that case the workaround was to specify the full sign
extension for 64 bit, that is 0xffffffffa0000000.


Thiemo
