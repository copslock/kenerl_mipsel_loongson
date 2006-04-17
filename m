Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 13:55:21 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:32940 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133415AbWDQMzM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 13:55:12 +0100
Received: (qmail 19578 invoked from network); 17 Apr 2006 17:10:18 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 17 Apr 2006 17:10:18 -0000
Message-ID: <444392CF.7070808@ru.mvista.com>
Date:	Mon, 17 Apr 2006 17:06:23 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	geoffrey.levand@am.sony.com, linux-mips@linux-mips.org
Subject: Re: tx49 Ether problems
References: <444032A5.3030304@am.sony.com>	<44415D17.1070005@ru.mvista.com>	<444291E9.2070407@ru.mvista.com> <20060417.110945.59031594.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060417.110945.59031594.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
> On Sun, 16 Apr 2006 22:50:17 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

>>>   This is really strange place for that #ifdef -- 'wordlength' is 
>>>determined much earlier in this function (and stop_page is set to 0x40 
>>>for 8-bit case), shouldn't #ifdef be moved instead?

>>     What I think we actually need is more generic fix for RTL8019AS, not the
>>board specific hacks -- if this RX ring stop page value limitation *really*
>>needs to be enforced.

> I agree with you.  Then how about something like
> CONFIG_NE2000_RTL8019_BYTEMODE?

    Have you looked at the patch? RTL8019 is easily detectable at runtime, so 
the limitation is easily enforcable w/o extra Kconfig option, I think

>  Also, setting 0xbad value to mem_end
> can skip the Product-ID checking without inflating bad_clone_list.
> Just a thought...

    0xbad in dev->mem_end currently skips 8390 reset which is not a good thing 
for the clones for which it does work...

> ---
> Atsushi Nemoto

WBR, Sergei
