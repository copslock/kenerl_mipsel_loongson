Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 17:25:01 +0100 (BST)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:56994
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8226043AbVCaQYp>; Thu, 31 Mar 2005 17:24:45 +0100
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 31 Mar 2005 16:24:43 -0000
Message-ID: <424C2450.4030406@embeddedalley.com>
Date:	Thu, 31 Mar 2005 08:24:48 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Compressed Kernels
References: <1112258126.28438.16.camel@localhost.localdomain> <20050331084207.GA8346@curie-int.orbis-terrarum.net>
In-Reply-To: <20050331084207.GA8346@curie-int.orbis-terrarum.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Robin H. Johnson wrote:
> On Thu, Mar 31, 2005 at 09:35:26AM +0100, JP Foster wrote:
> 
>>I've noticed that mips doesn't have a compressed kernel option,
>>so I had added support (ripped shamelessly from arch/i386) for it
>>to save space on our flash chips.
>>
>>It works fine for my db1550 and also our product boards.
>>The patch is pretty messy but if there was interest in it I could clean
>>it up. Is there any historical reason for it not being included?
> 
> Pete Popov was already working some zImage code.
> 
> His link for it:
> ftp://ftp.linux-mips.org/pub/linux/mips/people/ppopov/2.6/zImage_2_6_10.patch
> 
> It worked for me in January on an XXS1500 device, but I haven't tried it
> on any newer kernel since then.
> 
> I don't know the current status of it, or if it is going to go into the
> main codebase at all.

Should be easy to update if if doesn't apply cleanly anymore. I think the 
complaint about that patch is that it duplicates some code from other 
architectures and a more common solution is needed. Since I don't have time to 
work on something more common, the patch remains stand alone.

Pete
