Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 14:49:44 +0100 (BST)
Received: from web15804.mail.cnb.yahoo.com ([IPv6:::ffff:202.165.102.84]:27264
	"HELO web15804.mail.cnb.yahoo.com") by linux-mips.org with SMTP
	id <S8226027AbVDDNta>; Mon, 4 Apr 2005 14:49:30 +0100
Message-ID: <20050404134918.29726.qmail@web15804.mail.cnb.yahoo.com>
Received: from [221.218.14.94] by web15804.mail.cnb.yahoo.com via HTTP; Mon, 04 Apr 2005 21:49:18 CST
Date:	Mon, 4 Apr 2005 21:49:18 +0800 (CST)
From:	dfsd df <tomcs163@yahoo.com.cn>
Subject: Re: questions about early-printk
To:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-Path: <tomcs163@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomcs163@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Sorry, It's still Malta board, MIPS4Kc cpu. the UART
is ti16c550c.

The source code at junsun.net is :
------------------------------------------------------
#include "uart16550.h" 

/* === CONFIG === */ 

#define BASE 0xb0000080
------------------------------------------------------

From the MALTA board manual, I can get "BASE"'s
physical addr is 0x1f000900.
What I want to know is how to get "BASE"'s memory
mapped virtual addr correctly?for this example: the
virtual addr is 0xb0000080.

Thanks!

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Apr 04, 2005 at 12:49:53PM +0800, dfsd df
> wrote:
> 
> > Hi:
> >   Had somebody used early-printk? Now, I'm porting
> > linux to a MIPS machine under instructions of
> "Linux
> > MIPS Porting Guide" from junsun.net.
> 
> There's an updated version in the www.linux-mips.org
> wiki.
> 
> > But at the first step, I want to modify the source
> > code of the barebone program to display
> "helloworld".
> > 
> > The program uses memory map addr as the UART
> device's
> > "base addr",and access the UART by adding offset
> to
> > this "base addr".
> > 
> > The "base addr" is assigned to a constant value.
> and
> > from the other early-printk patchs, the value of
> "base
> > addr" are not equals. So I want to know can I
> assign
> > the right value to this "base addr"?
> 
> You haven't even mentioned what hardware you're
> using so don't expect
> answer ...
> 
>   Ralf
> 
> 

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
