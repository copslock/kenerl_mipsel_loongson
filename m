Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2005 02:09:09 +0100 (BST)
Received: from web15806.mail.cnb.yahoo.com ([IPv6:::ffff:202.165.102.86]:20815
	"HELO web15806.mail.cnb.yahoo.com") by linux-mips.org with SMTP
	id <S8226072AbVDABIy>; Fri, 1 Apr 2005 02:08:54 +0100
Message-ID: <20050401010839.66832.qmail@web15806.mail.cnb.yahoo.com>
Received: from [210.76.108.109] by web15806.mail.cnb.yahoo.com via HTTP; Fri, 01 Apr 2005 09:08:39 CST
Date:	Fri, 1 Apr 2005 09:08:39 +0800 (CST)
From:	dfsd df <tomcs163@yahoo.com.cn>
Subject: Re: Some questions about kernel tailoring
To:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-Path: <tomcs163@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomcs163@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Sorry, I used YAHOO web e-mail.I'm not familiar with
it.and I have set the edit mode to plain text. Pls
help me to check whether the e-mail is still on HTML,
thanks!

Now, I have 4M flash memory and 8M SDRAM can use.any
suggestion?

Thanks again!

--- Stuart Longland <stuartl@longlandclan.hopto.org>
wrote:
> dfsd df wrote:
> > Thanks again!
> 
> BTW: Your mail client has just switched back to its
> fixation on HTML.
> Could you please have a close look at the settings
> and disable HTML mail
> composition?  (at least for this email
> address/domain)
> 
> > Because of the limitation of memory, I don't want
> to use YAMON.
> > Using gzip -9, I can get a kernel more small than
> the kernel made by
> > "make zImage".
> > So I want to write a very simple bootloader and
> make a self-decompressed
> > kernel.
> 
> AFAIK the bootloader is only resident during the
> initial bootup, and is
> normally gone by the time userland kicks in.  (Think
> about it -- what's
>  the point in it sticking around, its job is done
> ;-)
> 
> If you've got at least 8MB RAM you should be okay. 
> (And lets face it --
> Linux on 4MB *IS NOT PRETTY* -- Been there, done
> that)  How much RAM are
> you working with?
> -- 
>
+-------------------------------------------------------------+
> | Stuart Longland -oOo-
> http://stuartl.longlandclan.hopto.org |
> | Atomic Linux Project     -oOo-   
> http://atomicl.berlios.de |
> | - - - - - - - - - - - - - - - - - - - - - - - - -
> - - - - - |
> | I haven't lost my mind - it's backed up on a tape
> somewhere |
>
+-------------------------------------------------------------+
> 

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
