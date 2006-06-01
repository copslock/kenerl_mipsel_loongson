Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2006 11:25:02 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:45224 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133361AbWFAJYz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2006 11:24:55 +0200
Received: from lagash (88-106-172-197.dynamic.dsl.as9105.com [88.106.172.197])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id F013144D2E; Thu,  1 Jun 2006 11:24:52 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FljPZ-0004BJ-Ng; Thu, 01 Jun 2006 10:24:13 +0100
Date:	Thu, 1 Jun 2006 10:24:13 +0100
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: BFD: Warning: Writing section `.text' to huge (ie negative) file offset 0xa1ffff10
Message-ID: <20060601092413.GL1717@networkno.de>
References: <50c9a2250605312319v7480f2el36d9c0a052c85d5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250605312319v7480f2el36d9c0a052c85d5f@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

zhuzhenhua wrote:
> i have write a code to link at 0xa2000000(uncached address)
> but when link i get the error as
> "BFD: Warning: Writing section `.text' to huge (ie negative) file
> offset 0xa1ffff10.
> BFD: Warning: Writing section `.data' to huge (ie negative) file
> offset 0xa200b050.
> BFD: Warning: Writing section `.reginfo' to huge (ie negative) file
> offset 0xa200c980.
> mipsel-linux-objcopy: /root/project/brec_flash/release/brec_flash.bin:
> File truncated
> make: *** [brec_flash] Error 1"
> 
> my link.xn as follow:
> 
> OUTPUT_ARCH(mips)
> ENTRY(brec_flash_entry)
> SECTIONS
> {
> .text 0xa2000000 :

Use

 . = 0xa2000000;
 .text :

instead. "info ld" explains the subtle difference.


Thiemo
