Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 16:23:46 +0000 (GMT)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:40206 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S24141426AbYLEQXh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Dec 2008 16:23:37 +0000
Received: from [192.168.236.58] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id KAA27419;
	Fri, 5 Dec 2008 10:21:24 -0600
Message-ID: <4939557F.1000609@paralogos.com>
Date:	Fri, 05 Dec 2008 10:23:27 -0600
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Nick Andrew <nick@nick-andrew.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Lucas Woods <woodzy@gmail.com>, linux-mips@linux-mips.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix incorrect use of loose in vpe.c
References: <S24119814AbYLEAhF/20081205003705Z+5882@ftp.linux-mips.org> <20081205155654.GA2765@linux-mips.org>
In-Reply-To: <20081205155654.GA2765@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Dec 05, 2008 at 11:36:54AM +1100, Nick Andrew wrote:
>   
>> From: Nick Andrew <nick@nick-andrew.net>
>> Date: Fri, 05 Dec 2008 11:36:54 +1100
>> To: Jonathan Corbet <corbet@lwn.net>, "Kevin D. Kissell" <kevink@mips.com>,
>> 	Lucas Woods <woodzy@gmail.com>, Nick Andrew <nick@nick-andrew.net>,
>> 	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
>> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>> Subject: Fix incorrect use of loose in vpe.c
>>
>> Fix incorrect use of loose in vpe.c
>>
>> From: Nick Andrew <nick@nick-andrew.net>
>>
>> It should be 'lose', not 'loose'.
>>
>> Signed-off-by: Nick Andrew <nick@nick-andrew.net>
>>     
>
> Thanks, applied.  Note that the address you used for Kevin Kissel to post
> your patch is no longer valid.
>   
Yeah, but I'm still on the mailing list, so I saw it.  I don't "own" 
that particular module,
but for whatever it's worth, I'm OK with fixing the comment - though I'm 
surprised
that checkpatch let a non-canonical multi-line comment block like that 
go by.  ;o)

          Regards,

          Kevin K.
