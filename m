Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2004 17:07:11 +0000 (GMT)
Received: from smtp804.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.168.183]:48029
	"HELO smtp804.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225233AbULTRHF>; Mon, 20 Dec 2004 17:07:05 +0000
Received: from unknown (HELO ?10.2.2.62?) (pvpopov@pacbell.net@63.194.214.47 with plain)
  by smtp804.mail.sc5.yahoo.com with SMTP; 20 Dec 2004 17:06:52 -0000
Message-ID: <41C70686.2090806@embeddedalley.com>
Date: Mon, 20 Dec 2004 09:06:14 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Green <jgreen@users.sourceforge.net>
CC: linux-mips@linux-mips.org
Subject: Re: Fixes to drivers/net/au1000_eth.c
References: <1103412993.9129.8.camel@SillyPuddy.localdomain> <1103511268.15414.15.camel@SillyPuddy.localdomain>
In-Reply-To: <1103511268.15414.15.camel@SillyPuddy.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Thanks, I'll take care of the patches.

Pete

Josh Green wrote:
> On Sat, 2004-12-18 at 15:36 -0800, Josh Green wrote:
> 
>>I'm using latest linux-mips CVS kernel (2.6.10rc3) and GCC 3.4.2 on a
>>AMD Alchemy DBau1100 development board (mipsel/MIPS32).  I wasn't able
>>to find any other location to post bugs, so please let me know if there
>>is a bug system or more appropriate place to post this.
> 
> 
> I'm replying to my own post, since I discovered what was causing the
> kernel oops with the au1000_eth.c driver.  The attached patch fixes 3
> problems:
> 
> - The build problem with extern inline str2eaddr.  I just made it
> non-inline, although I'm not sure if this is the best way to resolve the
> issue.
> 
> - At the end of mii_probe(): aup->mii is checked to indicate whether an
> ethernet device was found or not, this variable will actually always be
> set, which leads to a crash when aup->mii->chip_info->name is accessed
> in code following it (in the case where no device is detected).
> aup->mii->chip_info seems like a better test, although I'm not positive
> on that one.
> 
> - In au1000_probe() 'sizeof(dev->dev_addr)' was being used in memcpy
> when copying ethernet MAC addresses.  This size is currently 32 which is
> larger than the 6 byte buffers being used in the copies, leading to
> kernel oopses.
> 
> If I should be sending this to the author of the driver or some other
> location, please let me know. Best regards,
> 	Josh Green
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: arch/mips/au1000/common/prom.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/common/prom.c,v
> retrieving revision 1.12
> diff -r1.12 prom.c
> 115c115
> < inline void str2eaddr(unsigned char *ea, unsigned char *str)
> ---
> 
>>void str2eaddr(unsigned char *ea, unsigned char *str)
> 
> Index: drivers/net/au1000_eth.c
> ===================================================================
> RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
> retrieving revision 1.39
> diff -r1.39 au1000_eth.c
> 100,101c100
> < extern inline void str2eaddr(unsigned char *ea, unsigned char *str);
> < extern inline unsigned char str2hexnum(unsigned char c);
> ---
> 
>>extern void str2eaddr(unsigned char *ea, unsigned char *str);
> 
> 1045c1044
> < 	if (aup->mii == NULL) {
> ---
> 
>>	if (aup->mii->chip_info == NULL) {
> 
> 1497c1496
> < 			memcpy(au1000_mac_addr, ethaddr, sizeof(dev->dev_addr));
> ---
> 
>>			memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
> 
> 1508c1507
> < 						sizeof(dev->dev_addr));
> ---
> 
>>						sizeof(au1000_mac_addr));
> 
> 1513c1512
> < 		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(dev->dev_addr));
> ---
> 
>>		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
> 
> 1523c1522
> < 		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(dev->dev_addr));
> ---
> 
>>		memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
