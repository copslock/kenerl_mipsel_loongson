Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2003 05:01:03 +0100 (BST)
Received: from bay1-f107.bay1.hotmail.com ([IPv6:::ffff:65.54.245.107]:53775
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225073AbTD3EBB>; Wed, 30 Apr 2003 05:01:01 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 29 Apr 2003 21:00:52 -0700
Received: from 4.3.108.196 by by1fd.bay1.hotmail.msn.com with HTTP;
	Wed, 30 Apr 2003 04:00:52 GMT
X-Originating-IP: [4.3.108.196]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: wd@denx.de
Cc: geert@linux-m68k.org, linux-mips@linux-mips.org,
	edotkumar@yahoo.com
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Tue, 29 Apr 2003 21:00:52 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F107QuhhqeOhFm0001075c@hotmail.com>
X-OriginalArrivalTime: 30 Apr 2003 04:00:52.0848 (UTC) FILETIME=[17E51700:01C30ECD]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

Thanks for the comments. But still I get an error.

[root@localhost linux-2.4.20-6]# make ARCH=mips xconfig
rm -f include/asm
( cd include ; ln -sf asm-mips asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.20-6/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/mips/config.in >> kconfig.tk
arch/mips/config-shared.in: 482: unterminated quoted string
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20-6/scripts'
make: *** [xconfig] Error 2

Please help me get passed this. Please let me know if there is document on 
this.


Thanks a lot,
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
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail
