Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2005 17:36:02 +0100 (BST)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:14114
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225218AbVERQfr>;
	Wed, 18 May 2005 17:35:47 +0100
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 18 May 2005 09:35:44 -0700
Message-ID: <428B6EDD.4040508@avtrex.com>
Date:	Wed, 18 May 2005 09:35:41 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Michael Belamina <belamina1@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: 64 bit kernel for BCM1250
References: <20050518080917.45521.qmail@web32501.mail.mud.yahoo.com> <428B663C.7050308@avtrex.com> <Pine.LNX.4.61L.0505181715070.19170@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0505181715070.19170@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 May 2005 16:35:44.0760 (UTC) FILETIME=[A3612780:01C55BC7]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 18 May 2005, David Daney wrote:
> 
> 
>>I saw this with a 32 bit kernel (for a 32 bit target).  As far as I know, no
>>2.4.x kernels from linux-mips.org will work with gcc 3.4.x.
> 
> 
>  That could actually be true -- I've been using GCC 4.0.0 for quite some 
> time now (that includes CVS snapshots from before the release), so I have 
> no slightest idea whether it's OK to use older versions. ;-)
> 
> 
>>I have previously posted patches to this list that fixed the problem for me.
>>Specifically I think the messages in this thread are relevant:
>>
>>http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=41AFDA18.2010906%40avtrex.com
> 
> 
>  Hasn't one of the proposed fixes for the bug made its way to Linux in the 
> end?  That would be regrettable...
> 

WRT the 2.4 kernel the answer seems to be no.  And yes I think it is 
regrettable.

If anybody thinks it would be useful, I could post my current patch again.

David Daney.
