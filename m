Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Feb 2005 22:04:08 +0000 (GMT)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:22882
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225205AbVB0WDw>; Sun, 27 Feb 2005 22:03:52 +0000
Received: from unknown (HELO ?10.2.2.69?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 27 Feb 2005 22:03:49 -0000
Message-ID: <4220F253.6060508@embeddedalley.com>
Date:	Sat, 26 Feb 2005 14:04:03 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Fixes to MTD flash driver on AMD Alchemy db1100 board
References: <1108962105.6611.24.camel@SillyPuddy.localdomain> <1109052412.20045.6.camel@SillyPuddy.localdomain> <421ADE76.5020905@embeddedalley.com> <200502221632.53448.eckhardt@satorlaser.com>
In-Reply-To: <200502221632.53448.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> Pete Popov wrote:
> 
>>Here is a 2.6 patch that gets rid of all the Au1x mapping files and
>>replaces them with a single file. 
> 
> 
> Big step forward, this looks much cleaner and easier to maintain!
> 
> Just a few nits:
> 
> 1. mymtd = do_map_probe("cfi_probe", &alchemy_map);
> 
> Doesn't this mean that the Alchemy flash driver depends on the CFI interface? 
> I also see that CONFIG_MTD_CFI is not set in the configfiles for some boards.
> 
> 2. If above do_map_probe() returns NULL, the ioremap()ed memory is leaked. 
> Doesn't matter that much probably, but is trivial to fix.
> 
>  if (!mymtd)
>  {
>   iounmap( alchemy_map.virt);
>   return -ENXIO;
>  }
> 
> 3. No need to cast the parameter to iounmap(), it should happily digest 
> whatever ioremap() returns. If that gives warnings, something different is 
> going wrong in between. ;)

Thanks, I took care of all this. I removed the multiple drivers in 
favor of the single, simplied driver. I pushed the updates in 
linux-mips head, and the mtd community tree. To use these changes 
with linux-mips 2.4 branch, you have to patch-in the entire mtd 
tree. However, even then I had some compile problems that were not 
related to the changes I made, so I don't know if you can still use 
the latest mtd tree with a 2.4 kernel.

Pete
