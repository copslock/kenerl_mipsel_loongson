Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 03:30:43 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:9163 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225471AbUC3Cam>; Tue, 30 Mar 2004 03:30:42 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B891U-0006Ew-00; Mon, 29 Mar 2004 20:30:40 -0600
Message-ID: <4068DBCE.8000702@realitydiluted.com>
Date: Mon, 29 Mar 2004 21:30:38 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Kevin D. Kissell" <kevink@mips.com>,
	Brian Murphy <brian@murphy.dk>, linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com> <008901c415d0$3a94d5f0$10eca8c0@grendel> <20040330012403.GB4068@linux-mips.org>
In-Reply-To: <20040330012403.GB4068@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> The change goes beyond just cache managment; the API also abstracts away
> I/O MMUs which so far are quite rare on MIPS systems - but I really hope
> they're going to establish themselves asap.
> 
> The Documentation/DMA-API.txt also documents how properly deal with cache
> alignment when using this API.
> 
> Steven, maybe that we should add another assertion to make sure we don't
> run into trouble with missaligned cachelines?
>
Okay. I will have a look at tomorrow morning.

-Steve
