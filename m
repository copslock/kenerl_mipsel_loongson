Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 17:20:31 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:40911 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022991AbXIYQU3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 17:20:29 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id AB5BD30C8CA;
	Tue, 25 Sep 2007 16:20:31 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 25 Sep 2007 16:20:30 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Sep 2007 09:20:14 -0700
Message-ID: <46F9353D.6050107@avtrex.com>
Date:	Tue, 25 Sep 2007 09:20:13 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Fuxin Zhang <zhangfx@lemote.com>, debian-mips@lists.debian.org,
	linux-mips@linux-mips.org
Subject: Re: About openoffice linux/mips porting
References: <46F90261.1000003@lemote.com> <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl> <46F90841.1040903@ict.ac.cn> <20070925133812.GB2333@networkno.de>
In-Reply-To: <20070925133812.GB2333@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2007 16:20:14.0112 (UTC) FILETIME=[F3EC8A00:01C7FF8F]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Fuxin Zhang wrote:
>> Maciej W. Rozycki ??????:
>>> On Tue, 25 Sep 2007, Fuxin Zhang wrote:
>>>
>>>   
>>>> It is available at
>>>> http://qa.openoffice.org/issues/show_bug.cgi?id=81482, any comments are
>>>> welcome.
>>>> Have an official openoffice for linux/mips might be a good thing.
> 
> A quick glance revealed already several bugs. (alignment issues, ULH for
> laoding signed shorts, etc.)
> 
>>>  Hmm, why would anyone need to have asm snippets in a document processing 
>>> suite?  And it looks like the bits are ABI-dependent, so at least three 
>>> variations (if the changes are endianness-safe) would be required to 
>>> handle all the ABIs that we support.
>>>   
>> Openoffice wants to be able to interact with plugins written in many 
>> languages, instead of writting a module for each possible combination it 
>> chooses the so called bridge: every language interact with a common middle 
>> language.
> 
> So we have now foreign function interfaces for at least OpenOffice, Mozilla,
> Clisp and GCC's libffi. libffi recently got support for N32/N64 ABIs, and
> is the only solution which isn't bound to a specific application (as long
> as GCC is used).
> 
> Using libffi from Openoffice looks like the best long-term approach 
> to me.

I assume you mean 'Using libffi in...'.  I would tend to agree, but I am 
a bit biased toward libffi.

FWIW, GCC's libffi gets full n32/n64 support in version 4.3 (which has 
not been released yet)  The libffi part seems quite stable though, so 
you could start experimenting with it now I suppose...


David Daney
