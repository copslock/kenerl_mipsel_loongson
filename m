Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Apr 2005 04:03:54 +0100 (BST)
Received: from web15804.mail.cnb.yahoo.com ([IPv6:::ffff:202.165.102.84]:15018
	"HELO web15804.mail.cnb.yahoo.com") by linux-mips.org with SMTP
	id <S8224937AbVDBDDd>; Sat, 2 Apr 2005 04:03:33 +0100
Message-ID: <20050402030325.93348.qmail@web15804.mail.cnb.yahoo.com>
Received: from [61.51.73.251] by web15804.mail.cnb.yahoo.com via HTTP; Sat, 02 Apr 2005 11:03:25 CST
Date:	Sat, 2 Apr 2005 11:03:25 +0800 (CST)
From:	dfsd df <tomcs163@yahoo.com.cn>
Subject: Re: [Fwd: Re: Some questions about kernel tailoring] 
To:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-Path: <tomcs163@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomcs163@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Thanks! I will take a look at U-BOOT.

BTW: Could you please tell me what's the diffence
among U-BOOT, REDBOOT, and YAMON?

Thanks again! 

> --- Wolfgang Denk <wd@denx.de> wrote:
> > In message
> >
>
<20050401071559.69834.qmail@web25109.mail.ukl.yahoo.com>
> > you wrote:
> > > > Don't re-invent the wheel. Consider using
> > (porting)
> > > > U-Boot.
> > > 
> > > BTW, do you know how big is U-Boot ?
> > 
> > Sure :-)
> > 
> > This depends on which features you have on your
> > board  and  configure
> > into  U-Boot. Typical image sizes are 150...200 kB
> > with most features
> > enabled (network support including TFTP, DHCP,
> NFS;
> > hush  shell  with
> > the  capability  to  run shell scripts; support
> for
> > IDE, CompactFlash
> > cards, USB (memory sticks), NAND flash; support 
> for
> >  DOS,  ext2  and
> > JFFS2  filesystems;  graphical display on LCD/VGA,
> > splash screen etc.
> > etc.). The biggest configuration I am  aware  of 
> at
> >  the  moment  is
> > 280kB; small configurations can be fit in 128 kB;
> if
> > you really throw
> > out everything you can get rid of you may even
> make
> > it fit into 64kB.
> > As  mentioned  before:  this  depends  on 
> > architecture  and hardware
> > features that have to be supported.
> > 
> > 
> > And referring to the original question:  of 
> course 
> > U-Boot  supports
> > booting  of  compressed images (kernel, ramdisk,
> > other) uzing gzip or
> > gzip2 compression.
> > 
> > Best regards,
> > 
> > Wolfgang Denk
> > 
> > -- 
> > Software Engineering:  Embedded and Realtime
> > Systems,  Embedded Linux
> > Phone: (+49)-8142-66989-10 Fax:
> (+49)-8142-66989-80
> > Email: wd@denx.de
> > Respect is a rational process
> > 	-- McCoy, "The Galileo Seven", stardate 2822.3
> > 
> > 
> 
>
_________________________________________________________
> Do You Yahoo!?
> 150万曲MP3疯狂搜，带您闯入音乐殿堂
> http://music.yisou.com/
> 美女明星应有尽有，搜遍美图、艳图和酷图
> http://image.yisou.com
> 1G就是1000兆，雅虎电邮自助扩容！
>
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
> 

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
