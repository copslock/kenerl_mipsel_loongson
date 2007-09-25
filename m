Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:39:09 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:6303 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20023083AbXIYNjH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 14:39:07 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 156D79E33C;
	Tue, 25 Sep 2007 15:38:14 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IaAc8-0006NB-Nd; Tue, 25 Sep 2007 14:38:12 +0100
Date:	Tue, 25 Sep 2007 14:38:12 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Fuxin Zhang <zhangfx@lemote.com>, debian-mips@lists.debian.org,
	linux-mips@linux-mips.org
Subject: Re: About openoffice linux/mips porting
Message-ID: <20070925133812.GB2333@networkno.de>
References: <46F90261.1000003@lemote.com> <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl> <46F90841.1040903@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F90841.1040903@ict.ac.cn>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Fuxin Zhang wrote:
> Maciej W. Rozycki ??????:
>> On Tue, 25 Sep 2007, Fuxin Zhang wrote:
>>
>>   
>>> It is available at
>>> http://qa.openoffice.org/issues/show_bug.cgi?id=81482, any comments are
>>> welcome.
>>> Have an official openoffice for linux/mips might be a good thing.

A quick glance revealed already several bugs. (alignment issues, ULH for
laoding signed shorts, etc.)

>>  Hmm, why would anyone need to have asm snippets in a document processing 
>> suite?  And it looks like the bits are ABI-dependent, so at least three 
>> variations (if the changes are endianness-safe) would be required to 
>> handle all the ABIs that we support.
>>   
> Openoffice wants to be able to interact with plugins written in many 
> languages, instead of writting a module for each possible combination it 
> chooses the so called bridge: every language interact with a common middle 
> language.

So we have now foreign function interfaces for at least OpenOffice, Mozilla,
Clisp and GCC's libffi. libffi recently got support for N32/N64 ABIs, and
is the only solution which isn't bound to a specific application (as long
as GCC is used).

Using libffi from Openoffice looks like the best long-term approach 
to me.


Thiemo
