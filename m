Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 19:47:11 +0000 (GMT)
Received: from vsmtp14.tin.it ([IPv6:::ffff:212.216.176.118]:47241 "EHLO
	vsmtp14.tin.it") by linux-mips.org with ESMTP id <S8225254AbVAVTrG>;
	Sat, 22 Jan 2005 19:47:06 +0000
Received: from eppesuigoccas.homedns.org (80.180.159.168) by vsmtp14.tin.it (7.0.027) (authenticated as giuseppe.sacco17@tin.it)
        id 41EFD0C20012C04C for linux-mips@linux-mips.org; Sat, 22 Jan 2005 20:46:59 +0100
Received: from localhost ([127.0.0.1] ident=giuseppe)
	by eppesuigoccas.homedns.org with asmtp (Exim 3.35 #1 (Debian))
	id 1CsRDl-0000u5-00
	for <linux-mips@linux-mips.org>; Sat, 22 Jan 2005 20:46:57 +0100
Message-ID: <41F2ADB0.8020200@eppesuigoccas.homedns.org>
Date:	Sat, 22 Jan 2005 20:46:56 +0100
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: O2 and 128Mb
References: <1105602134.10493.23.camel@localhost>	 <41E627F8.3010004@total-knowledge.com>	 <1105605285.10490.52.camel@localhost>	 <41E6CB5B.6080303@total-knowledge.com> <1106338775.4760.17.camel@localhost>	  <41F168DA.60301@total-knowledge.com> <1106342715.4757.27.camel@localhost> <41F1BE9E.8070109@gentoo.org>
In-Reply-To: <41F1BE9E.8070109@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Kumba wrote:

> Giuseppe Sacco wrote:
>
>> I think my O2 just blowed up :-(
>> Actually it doesn't switch on. Even unplugging and plugging again the
>> power cord, it stay off.
>
> Pull the mainboard out, find the flash-clear jumper, cover it with a 
> nearby jumper cap (this jumper and cap should be near the RTC, a 
> Dallas chip).  Pop the board back into the system, and see if it 
> powers on.  If it does, power back off, remove the jumper cap, and 
> then power back up, and it should power up fine.


Thank you very much: this solved the problem and the O2 is now back again.

[...]

> Drop minicom, I get nothing but trouble with it.  Use "xc", a small, 
> simple dial program.  If it's not on your system, you'll have to 
> install it via whatever means your working distro provides, then do this:


Now I tried using minicom, cu and xc. All of them gave me the same 
result: nothing.
Please note that, using the same configuration, I may see the console 
output if I use the actual kernel.

The kernel that isn't working is almost any kernel compiled from about 
start of december. (Prior to this I never managed to compile a kernel 
from CVS sources.)

In order to compile the kernel, I cd /usr/local/src/linux and type:
 > make-kpkg --revision $(date +%Y%m%d) --rootcmd sudo kernel-image

Any other idea?
Giuseppe

P.S. When compiling I always get this error:
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -o arch/mips/Kconfig
arch/mips/Kconfig:1598: can't open file "arch/mips/oprofile/Kconfig"
make[2]: *** [oldconfig] Error 1
make[1]: *** [oldconfig] Error 2
