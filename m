Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 14:16:07 +0100 (BST)
Received: from mail.tmr.com ([64.65.253.246]:10696 "EHLO pixels.tmr.com")
	by ftp.linux-mips.org with ESMTP id S20037765AbWHRNQF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2006 14:16:05 +0100
Received: from [127.0.0.1] (pixels.tmr.com [127.0.0.1])
	by pixels.tmr.com (8.12.10/8.12.10) with ESMTP id k7IDJpX2016674;
	Fri, 18 Aug 2006 09:19:52 -0400
Message-ID: <44E5BE77.9040200@tmr.com>
Date:	Fri, 18 Aug 2006 09:19:51 -0400
From:	Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
CC:	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
References: <200608102318.04512.thomas.koeller@baslerweb.com> <200608142126.29171.thomas.koeller@baslerweb.com> <20060817153138.GE5950@ucw.cz> <200608172230.30682.thomas.koeller@baslerweb.com>
In-Reply-To: <200608172230.30682.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <davidsen@tmr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davidsen@tmr.com
Precedence: bulk
X-list: linux-mips

Thomas Koeller wrote:
> On Thursday 17 August 2006 17:31, Pavel Machek wrote:
>> Well, I guess v4l api will need to be improved, then. That is still
>> not a reason to introduce completely new api...
> 
> The API as implemented by the driver I submitted is very minimalistic,
> because it is just a starting point. There's more to be added in future,
> like controlling flashes, interfacing to line-scan cameras clocked by
> incremental encodes attached to some conveyor, and other stuff which
> is common in industrial image processing applications. You really do
> not want to clutter the v4l2 API with these things; that would hardly
> be an 'improvement'.
> 
> Different interfaces, designed to serve different purposes...
> 
If you look at Pavel's posts WRT swsusp2, he has taken this position 
before, that lack of functionality in {something} is no justification to 
introduce a new solution, and that the limitations of {something} can be 
addressed by incremental improvement. Like any good idea, this can be 
carried to extremes.

Don't take it personally, just write working code people can patch in. 
When your code has the features you mentioned it will be highly useful 
and hopefully ported to many devices. I guess security monitoring is an 
"industrial image processing application," which interests me. At the 
moment I would call it an impressive proof of concept, but you have many 
useful ideas for its future.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
