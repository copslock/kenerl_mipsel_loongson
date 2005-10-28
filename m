Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 11:24:17 +0100 (BST)
Received: from 40.237.98-84.rev.gaoland.net ([84.98.237.40]:47923 "EHLO
	serveurSMTP") by ftp.linux-mips.org with ESMTP id S8133638AbVJ1KYA
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 11:24:00 +0100
Received: from [192.168.150.1] by serveurSMTP
  (ArGoSoft Mail Server Freeware, Version 1.8 (1.8.8.2)); Fri, 28 Oct 2005 12:24:52 +0200
Message-ID: <4361FCEF.30707@avilinks.com>
Date:	Fri, 28 Oct 2005 12:26:55 +0200
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	Louis Lai <louis.lai@entone.com>
CC:	linuxconsole-dev@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: missing /dev/tty0
References: <HAENJFHIMADGCOMALOKKOEELCBAA.louis.lai@entone.com>
In-Reply-To: <HAENJFHIMADGCOMALOKKOEELCBAA.louis.lai@entone.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips

Louis Lai a écrit :

>Hi all,
>
>I am using a 2.4.30 kernel for my MIPS embedded processor. The kernel can
>start up properly but the tty0 doesn't exist under /dev. I have already
>enable the virtual console during kernel configuration. is it something
>configure not properly for the kernel?? Anyone can help??
>
>Thanks in advance,
>Louis
>
>  
>
Hi Louis,

The problem is that you didn't create the special file /dev/tty0. Create 
it with the mknod command :
# mknod /dev/tty0 c 4 0
Then put the good rights, for example:
# chmod 640 /dev/tty0
That should do it...

    Yoann
