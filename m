Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 02:30:37 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:6576
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225072AbTDIBag>; Wed, 9 Apr 2003 02:30:36 +0100
Received: (qmail 15044 invoked from network); 9 Apr 2003 01:09:27 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 9 Apr 2003 01:09:27 -0000
Message-ID: <3E9377A8.4050407@ict.ac.cn>
Date: Wed, 09 Apr 2003 09:30:16 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Earl Mitchell <earlmips@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: pci graphics card for malta running linux
References: <20030408175517.66121.qmail@web20708.mail.yahoo.com> <1049833899.8939.9.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1049833899.8939.9.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Alan Cox wrote:

>On Maw, 2003-04-08 at 18:55, Earl Mitchell wrote:
>  
>
>>Does anybody have any good reccs for PCI graphcis cards I can use with
>>Malta board running linux? Some linux device drivers assume x86. If
>>you know some PCI cards that work with linux/mips on malta let me know
>>(especially nVidia or ATI cards). Also any PCI sound cards that work
>>too. 
>>    
>>
we managed to use x86emu to run bios firmware on a mips board,the cards we
tried including nvidia riva TNT2(?) and ATI Rage Pro and some old S3 too.
If you want i can give your the code. It is expected to run both in 
pmon,kernel
and user space(probably some hardware related tweak needed),though i 
have never
got enough time to make things perfect.

>Nvidia and ATI cards require you run the BIOS firmware to boot them. 
>XFree86 can do that for the ATI at least. If you just need to ram 
>something into a box so you can see what is going up I'd suggest
>getting an old voodoo1/voodoo2 off ebay. They report as multimedia
>devices and the current kernel fb driver can bootstrap them from
>cold on little or big endian systems with no bios support (tested
>on parisc, x86 etc)
>
>Not bad for <$10 a card although nobody has made Glide work big endian
>so you can do 3D yet 8)
>
>Alan
>
>
>
>
>  
>
