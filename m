Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2003 08:13:19 +0100 (BST)
Received: from bay1-f93.bay1.hotmail.com ([IPv6:::ffff:65.54.245.93]:26634
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225073AbTD3HNQ>; Wed, 30 Apr 2003 08:13:16 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 30 Apr 2003 00:13:09 -0700
Received: from 4.3.108.196 by by1fd.bay1.hotmail.msn.com with HTTP;
	Wed, 30 Apr 2003 07:13:08 GMT
X-Originating-IP: [4.3.108.196]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: wd@denx.de
Cc: geert@linux-m68k.org, linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Wed, 30 Apr 2003 00:13:08 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F93dHd6z6BJ8Qi0001d2c1@hotmail.com>
X-OriginalArrivalTime: 30 Apr 2003 07:13:09.0144 (UTC) FILETIME=[F4102980:01C30EE7]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Now I got passed the config issue.

I used the following command:

$ make ARCH=mips menuconfig

& changed the Machine option to Atlas 4Kc & saved it
Then
$ make dep
Then when I tried make, I got the following error:

[root@localhost linux-2.4.20-6]# make
scripts/split-include include/linux/autoconf.h include/config
make -r -f tmp_include_depends all
make[1]: Entering directory `/usr/src/linux-2.4.20-6'
make[1]: *** No rule to make target 
`/usr/src/linux-2.4.20-6/include/asm/math_emu.h', needed by 
`/usr/src/linux-2.4.20-6/arch/i386/math-emu/fpu_emu.h'.  Stop.
make[1]: Leaving directory `/usr/src/linux-2.4.20-6'
make: *** [tmp_include_depends] Error 2


I guess it's something to do with the FPU option ( not sure).. Please help 
me with this. I wonder why its still refering to files from arch/i386. The 
autoconfig.h seems to be fine. Ony the MIPS processor options are enabled.

Thanks,
-Mike.






>From: Wolfgang Denk <wd@denx.de>
>To: "Michael Anburaj" <michaelanburaj@hotmail.com>
>CC: geert@linux-m68k.org, linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board Date: Tue, 29 Apr 2003 22:00:29 
>+0200
>
>In message <BAY1-F39ahdtT8esYrJ0000a53e@hotmail.com> you wrote:
> >
> > Now I have all the tools (mips32el-linux) on Redhat Linux 9 & its 
>source. I
>
>Did you have a look at the ELDK? See http://www.denx.de/re/ELDK.html
>resp. ftp://ftp.leo.org/pub/eldk/2.1.0/eldk-mips-linux-x86/
>
> > $ make xconfig
> >
> > It displayed a window with lot of options. But under processor I could 
>only
> > find flavors of x86 core.
>
>I bet you missed to set "ARCH := mips" in the TLD Makefile;
>alternatively try "make ARCH=mips xconfig"
>
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>"The number  of  Unix  installations  has  grown  to  10,  with  more
>expected."    - The Unix Programmer's Manual, 2nd Edition, June, 1972


_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
