Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6JYCw28126
	for linux-mips-outgoing; Thu, 6 Dec 2001 11:34:12 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB6JY6o28123
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 11:34:06 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB6IXmM11547;
	Thu, 6 Dec 2001 16:33:48 -0200
Date: Thu, 6 Dec 2001 16:33:48 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: config problem?
Message-ID: <20011206163348.D8002@dea.linux-mips.net>
References: <200112040451.fB44pto11151@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112040451.fB44pto11151@oss.sgi.com>; from fxzhang@ict.ac.cn on Tue, Dec 04, 2001 at 11:50:09AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 04, 2001 at 11:50:09AM +0800, Zhang Fuxin wrote:

>    when upgrading to current CVS 2_4_branch,I find that the configure
> scripts seems problematic:
>        1. drivers/hotplug doesn't exist,so line 421:
>              source "drivers/hotplug/config.in" 
>          leads to failures of make xconfig/menuconfig 

RTFM ...  But to make it easier for you: cvs update -d -P :-)

>        2. drivers/sound/config.in line 37 type error
>                 = 'y' should be = "y"

Thanks, fixed.

>        3.the newly added "Embed root filesys ramdisk.." is not in 
>          any mainmenu block,so "statement not in menu" occurs

Fixed also.

>   'make config' is ok            

I wouldn't use anything else :-)

  Ralf
