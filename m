Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 05:50:29 +0100 (BST)
Received: from web15808.mail.cnb.yahoo.com ([IPv6:::ffff:202.165.102.88]:38294
	"HELO web15808.mail.cnb.yahoo.com") by linux-mips.org with SMTP
	id <S8225984AbVDDEuN>; Mon, 4 Apr 2005 05:50:13 +0100
Message-ID: <20050404044953.86817.qmail@web15808.mail.cnb.yahoo.com>
Received: from [210.76.108.109] by web15808.mail.cnb.yahoo.com via HTTP; Mon, 04 Apr 2005 12:49:53 CST
Date:	Mon, 4 Apr 2005 12:49:53 +0800 (CST)
From:	dfsd df <tomcs163@yahoo.com.cn>
Subject: questions about early-printk
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-Path: <tomcs163@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomcs163@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Hi:
  Had somebody used early-printk? Now, I'm porting
linux to a MIPS machine under instructions of "Linux
MIPS Porting Guide" from junsun.net.

But at the first step, I want to modify the source
code of the barebone program to display "helloworld".

The program uses memory map addr as the UART device's
"base addr",and access the UART by adding offset to
this "base addr".

The "base addr" is assigned to a constant value. and
from the other early-printk patchs, the value of "base
addr" are not equals. So I want to know can I assign
the right value to this "base addr"?

Thanks!

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
