Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 16:56:12 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:29588 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133415AbWDQP4D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 16:56:03 +0100
Received: (qmail 22071 invoked from network); 17 Apr 2006 20:11:14 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 17 Apr 2006 20:11:14 -0000
Message-ID: <4443BD39.4030200@ru.mvista.com>
Date:	Mon, 17 Apr 2006 20:07:21 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
References: <444291E9.2070407@ru.mvista.com>	<20060417.110945.59031594.nemoto@toshiba-tops.co.jp>	<444392CF.7070808@ru.mvista.com> <20060418.000918.95064811.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060418.000918.95064811.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
> On Mon, 17 Apr 2006 17:06:23 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

>>>I agree with you.  Then how about something like
>>>CONFIG_NE2000_RTL8019_BYTEMODE?

>>    Have you looked at the patch? RTL8019 is easily detectable at
>>runtime, so the limitation is easily enforcable w/o extra Kconfig
>>option, I think

> Well, I meant something like:

> #elif defined(CONFIG_NE2000_RTL8019_BYTEMODE)
> #  define DCR_VAL 0x48
> #else
> #  define DCR_VAL 0x49

> to avoid changing #elif line every time when we want to support a new
> board with byte-mode RTL8019AS.  Of course, calculating DCR_VAL at
> runtime would be much better but I'm not sure if we can do it ...

    Hm, with only 3-4 known boards so far (all Toshiba RBTX49[23][78], 
RBTX4925 also has the chip but I see no 2.6 support for this board), I doubt 
that it's worth the effort. And the option sounds a bit "too specific", IMO. :-)

>>> Also, setting 0xbad value to mem_end
>>>can skip the Product-ID checking without inflating bad_clone_list.
>>>Just a thought...

    Er, calling RTL8019AS in 8-bit mode "NE2000" (as the driver would have 
done in case of RBTX49xx if we have used 0xbad), is not a correct thing. :-)

>>    0xbad in dev->mem_end currently skips 8390 reset which is not a
>>good thing for the clones for which it does work...

> The 8390 reset will not skipped.  The difference is behavior _after_
> detection of no reset ack, isn't it?

    Yes, I was too hasty and have overlooked this. :-)

> ---
> Atsushi Nemoto

WBR, Sergei
