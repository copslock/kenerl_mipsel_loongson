Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 15:55:11 +0100 (BST)
Received: from frog.mt.lv ([IPv6:::ffff:159.148.172.197]:12206 "EHLO
	frog.mt.lv") by linux-mips.org with ESMTP id <S8225535AbVDROyy>;
	Mon, 18 Apr 2005 15:54:54 +0100
Received: from [10.5.17.206] (helo=your-lnsz0iqs6f.mikrotik.com)
	by frog.mt.lv with esmtp (Exim 4.44)
	id 1DNXix-0006B6-O1; Mon, 18 Apr 2005 17:59:43 +0300
Message-Id: <6.2.1.2.0.20050418174810.0382e410@frog.mt.lv>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date:	Mon, 18 Apr 2005 17:54:05 +0300
To:	linux-mips@linux-mips.org
From:	John Tully <tully@mikrotik.com>
Subject: Re: Linux for RouterBoard532 - CPU MIPS32 4Kc - IDT 79RC32434.
Cc:	Wolfgang Denk <wd@denx.de>, cordova@uninet.com.br
In-Reply-To: <20050416225931.D620AC108D@atlas.denx.de>
References: <Your message of "Sat, 16 Apr 2005 11:33:45 -0300." <42612249.1fb.7a40.2093672349@uninet.com.br>
 <20050416225931.D620AC108D@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <tully@mikrotik.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tully@mikrotik.com
Precedence: bulk
X-list: linux-mips

I work for MikroTik and we make the RB500.  We are trying to add more 
documentation to make it easy to do more things with Linux.  At the moment, 
the CF image at least lets you quickly start on developing Linux 
applications.  Allot of what you need can be figured out from the kernel 
patch on the specs page for the RB500 at www.routerboard.com , but that is 
not so much fun.  We will add more documentation on the NAND device and 
such features.  So, please check the site and I can also write to this list 
as we add more info.

John
www.mikrotik.com

At 01:59 AM 4/17/2005, Wolfgang Denk wrote:
>In message <42612249.1fb.7a40.2093672349@uninet.com.br> you wrote:
> >
> > I´d just bought Routerboard532 (
> > http://www.routerboard.com/rb500.html ) and I want to port
> > linux to this board. The vendor has just an linux image on
> > the web site.
>
>This is not correct. If you just scroll  down  the  page  you  listed
>yoursself,   then   you   should   easily  find  the  section  titled
>"RouterBOARD 500 GNU/Linux support files" which includes  a  link  to
>"Patch for Linux 2.4.29 kernel".
>
> > Anyone could help me we some info or "HOWTO" ?
>
>Download the patch, download the corresponding  kernel  source  tree,
>apply  patch,  copy  "config.mipsel"  to  ".config"  to get a default
>configuration, build the kernel, download it, run it.
>
>So far I haven't been able to find out how to pass  kernel  arguments
>with their boot loader, so you may have to hack rc32434/rb500/prom.c
>
>I used the mips_4KCle packages of the ELDK to build the kernel and to
>provide a root filesystem over NFS - this worked fine. There are some
>problems (like not being able to switch the CPU clock and NAND  flash
>support not working at all), but it boots and runs.
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
>The IQ of the group is the lowest IQ of a member of the group divided
>by the number of people in the group.
