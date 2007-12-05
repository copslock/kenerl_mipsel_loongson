Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 20:38:19 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:35305 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20032661AbXLEUiK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 20:38:10 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id CCEFC310C7D;
	Wed,  5 Dec 2007 20:38:16 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed,  5 Dec 2007 20:38:16 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 5 Dec 2007 12:38:00 -0800
Message-ID: <47570C27.9050901@avtrex.com>
Date:	Wed, 05 Dec 2007 12:37:59 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	peter fuerst <pf@pfrst.de>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <Pine.LNX.4.21.0712051841520.1354@Opal.Peter>
In-Reply-To: <Pine.LNX.4.21.0712051841520.1354@Opal.Peter>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2007 20:38:00.0368 (UTC) FILETIME=[B9DC2B00:01C8377E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

peter fuerst wrote:
> 
> On Wed, 5 Dec 2007, Thomas Bogendoerfer wrote:
> 
>> Date: Wed, 5 Dec 2007 10:39:38 +0100
>> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> To: Kumba <kumba@gentoo.org>
>> Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
>> Subject: Re: [UPDATED PATCH] IP28 support
>>
>> On Wed, Dec 05, 2007 at 01:16:13AM -0500, Kumba wrote:
>>> I've been out of it lately -- did the gcc side of things ever make it in,
>>> or do we need to go push on that some more?
>> We need push on that. ...
> 
> There was no answer to .../2006-05/msg01446.html. Perhaps i should just
> put together an updated patch,

That would be helpful.  It would have to be against GCC's svn trunk. 
Currently 4.3 is in regression fix only mode.  The earliest the patch 
could appear in an official GCC release would probably be version 4.4


> that incorporates the changes proposed in
> msg01446.html, and submit it (with the longer "Cc:" line and a hint to
> the increasing demand for it ;-) to revive at least the discussion at
> gcc-patches.

Just sent it to gcc-patches@   I think it will be noticed.


> What could be changed beyond the proposed changes without either omitting
> necessary cache-barriers or crippling the R10k, i can't see yet.
> 
>> We need push on that. Looking at
>>
>> http://gcc.gnu.org/ml/gcc-patches/2006-04/msg00291.html
>>
>> there seems to be a missing understanding, why the cache
>> barriers are needed. I guess the patch could be improved
>> by pointing directly to the errata section of the R10k
>> user manual. Or even better copy the text out of the user
>> manual. That should make clear why this patch is needed.
> 
> Better copy, i guess. (Assuming copying whole paragraphs is still proper
> citation ;-) Along with the initial patch (.../2006-03.msg00090.html) as
> well as in the last letter so far (.../2006-05/msg01446.html) i pointed
> to the corresponding chapter in the R10k User's Manual and to the entry
> in the NetBSD eMail archive. In the last letter i tried to augment these
> by a summarizing explanation, but it seems i'm not very good at that...
> 
>> Peter did you do the copyright assigment ? That's probably
>> the second part, which needs to be done.
> 
> Yes, the assignment process became complete on May 22 2006
> (though apparently i missed to notify Richard Sandiford about it)
> 

Good.  Richard is generally quite responsive to patches.  Perhaps CC him 
on your patch.

David Daney
