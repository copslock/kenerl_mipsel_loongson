Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 13:21:10 +0100 (BST)
Received: from LAubervilliers-151-13-113-26.w217-128.abo.wanadoo.fr ([217.128.183.26]:53876
	"EHLO serveurSMTP") by ftp.linux-mips.org with ESMTP
	id S8133646AbVJ1MUt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 13:20:49 +0100
Received: from [192.168.150.1] by serveurSMTP
  (ArGoSoft Mail Server Freeware, Version 1.8 (1.8.8.2)); Fri, 28 Oct 2005 14:21:25 +0200
Message-ID: <43621841.9050203@avilinks.com>
Date:	Fri, 28 Oct 2005 14:23:29 +0200
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	Louis Lai <louis.lai@entone.com>
CC:	linuxconsole-dev@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: missing /dev/tty0
References: <HAENJFHIMADGCOMALOKKIEEMCBAA.louis.lai@entone.com>
In-Reply-To: <HAENJFHIMADGCOMALOKKIEEMCBAA.louis.lai@entone.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips

You should something like that at the output of
$ ls -l /dev/tty?
crw--w----  1 root root 4, 0 2005-03-19 20:36 /dev/tty0
crw-rw----  1 root tty  4, 1 2005-10-24 18:24 /dev/tty1
crw-rw----  1 root tty  4, 2 2005-10-24 18:24 /dev/tty2
...
$

You wrote about  virtual consoles: in this case you should have 
CONFIG_VT=y in .config file.
Or at least you should something like this at the output of 

$ grep CONFIG_SERIAL_CONSOLE /where-your-kernel-sources-are/.config
CONFIG_SERIAL_CONSOLE=y
$

But be aware of:
  "If you don't have a VGA card installed and you say Y here, the
   kernel will automatically use the first serial line, /dev/ttyS0, as
   system console."

This is from HELP command in menuconfig...

I'll hope this will help...

    Yoann



Louis Lai a écrit :

>Hi Yoann,
>
>Thanks for your reply!!
>i can create the device file but i still not able to open it.
>When i open /dev/tty0, i got "No such device".
>Any ideas??
>
>Thanks again,
>Louis
>
>-----Original Message-----
>From: Yoann Allain [mailto:yallain@avilinks.com]
>Sent: Friday, October 28, 2005 6:27 PM
>To: Louis Lai
>Cc: linuxconsole-dev@lists.sourceforge.net; linux-mips@linux-mips.org
>Subject: Re: missing /dev/tty0
>
>
>Louis Lai a écrit :
>
>  
>
>>Hi all,
>>
>>I am using a 2.4.30 kernel for my MIPS embedded processor. The kernel can
>>start up properly but the tty0 doesn't exist under /dev. I have already
>>enable the virtual console during kernel configuration. is it something
>>configure not properly for the kernel?? Anyone can help??
>>
>>Thanks in advance,
>>Louis
>>
>>
>>
>>    
>>
>Hi Louis,
>
>The problem is that you didn't create the special file /dev/tty0. Create
>it with the mknod command :
># mknod /dev/tty0 c 4 0
>Then put the good rights, for example:
># chmod 640 /dev/tty0
>That should do it...
>
>    Yoann
>
>
>
>  
>
