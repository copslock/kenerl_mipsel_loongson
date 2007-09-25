Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:21:14 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:43974 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20023059AbXIYNVM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 14:21:12 +0100
Received: (qmail 13500 invoked by uid 507); 25 Sep 2007 21:17:28 +0800
Received: from unknown (HELO ?127.0.0.1?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 25 Sep 2007 21:17:28 +0800
Message-ID: <46F90841.1040903@ict.ac.cn>
Date:	Tue, 25 Sep 2007 21:08:17 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Fuxin Zhang <zhangfx@lemote.com>, debian-mips@lists.debian.org,
	linux-mips@linux-mips.org
Subject: Re: About openoffice linux/mips porting
References: <46F90261.1000003@lemote.com> <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki 写道:
> On Tue, 25 Sep 2007, Fuxin Zhang wrote:
>
>   
>> It is available at
>> http://qa.openoffice.org/issues/show_bug.cgi?id=81482, any comments are
>> welcome.
>> Have an official openoffice for linux/mips might be a good thing.
>>     
>
>  Hmm, why would anyone need to have asm snippets in a document processing 
> suite?  And it looks like the bits are ABI-dependent, so at least three 
> variations (if the changes are endianness-safe) would be required to 
> handle all the ABIs that we support.
>   
Openoffice wants to be able to interact with plugins written in many 
languages, instead of writting a module for each possible combination it 
chooses the so called bridge: every language interact with a common 
middle language.
>  It smells like OpenOffice is doing something outrageously wrong here...
>
>   Maciej
>
>
>
>
>   
