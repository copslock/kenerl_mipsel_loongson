Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 15:59:58 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:31253 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225308AbVCKP7n>; Fri, 11 Mar 2005 15:59:43 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2BFxOYk009274;
	Fri, 11 Mar 2005 15:59:24 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2BFxOij009273;
	Fri, 11 Mar 2005 15:59:24 GMT
Date:	Fri, 11 Mar 2005 15:59:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Rishabh@soc-soft.com, linux-mips@linux-mips.org
Subject: Re: Memory Management HAndling
Message-ID: <20050311155924.GD5958@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C61E22B@soc-mail.soc-soft.com> <1110548190.15943.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110548190.15943.46.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 11, 2005 at 01:36:31PM +0000, Alan Cox wrote:

> On Gwe, 2005-03-11 at 05:25, Rishabh@soc-soft.com wrote:
> > These macros can handle memory pages in KSEG0. Any suggestions on how
> > can they be changed for addressing memory present in HIGHMEM. Since VA
> > will not be in linear relation with mem_map.
> 
> Take a look at how kmap() works on x86 and how the mappings are used.

Highmem is supported for MIPS since ~ 2.4.18 or so.

  Ralf
