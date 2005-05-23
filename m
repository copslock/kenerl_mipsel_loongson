Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2005 16:39:43 +0100 (BST)
Received: from adsl-67-116-42-149.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.149]:61811
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225764AbVEWPj1>;
	Mon, 23 May 2005 16:39:27 +0100
Received: from [192.168.0.35] ([192.168.0.35] unverified) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 23 May 2005 08:39:24 -0700
Message-ID: <4291F929.9000302@avtrex.com>
Date:	Mon, 23 May 2005 08:39:21 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jerry <jerry@wicomtechnologies.com>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: 64 bit kernel for BCM1250
References: <20050519135207.7760.qmail@web32510.mail.mud.yahoo.com> <Pine.LNX.4.61L.0505191605350.10681@blysk.ds.pg.gda.pl> <27582192.20050523182609@wicomtechnologies.com>
In-Reply-To: <27582192.20050523182609@wicomtechnologies.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2005 15:39:24.0108 (UTC) FILETIME=[986B58C0:01C55FAD]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Jerry wrote:
> Hello Maciej,
> Thursday, May 19, 2005, 6:19:14 PM, you wrote:
> 
> 
>> For 64-bit builds you probably want to use fairly recent versions or you
>>risk hitting serious bugs that used to exist in older versions.  Using
>>David's patch (or preferably mine ;-) -- as available here: 
>>"http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.55.0406281509170.23162%40jurand.ds.pg.gda.pl";
>>which I keep using with GCC 4.0.0) is probably the lesser evil.
> 
> 
>  Without going into details - what difference between your and David's
> patch ? :) I'm in doubts which one is more suitable for me...
> 

FWIW: My current patch is quite similar to Maciej's.

David Daney.
