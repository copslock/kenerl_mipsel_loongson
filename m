Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2006 16:54:24 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:957 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037789AbWLIQyU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2006 16:54:20 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 7F7693ECA; Sat,  9 Dec 2006 08:54:03 -0800 (PST)
Message-ID: <457AEA8B.9030605@ru.mvista.com>
Date:	Sat, 09 Dec 2006 19:55:39 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: console stuck
References: <1165630940.7860.7.camel@sandbar.kenati.com>
In-Reply-To: <1165630940.7860.7.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ashlesha Shintre wrote:
> Hi,

> I m very much confused as to why there is an infinite loop in the
> __request_resource function in the linux/kernel/resource.c file?

    It has 2 exit points (return statements).

> The serial console is getting stuck at this point.

    Then there's something very wrong with your resources...

>>for (;;) {
>>                tmp = *p;
>>                if (!tmp || tmp->start > end) {
>>                        new->sibling = tmp;
>>                        *p = new;
>>                        new->parent = root;
>>                        return NULL;
>>                }
>>                p = &tmp->sibling;
>>                if (tmp->end < start){
>>                        printk("tmp->end = %d\n",tmp->end);
>>                        printk("tmp->start = %d\n",tmp->start);
>>                        printk("*********!!!!!!!*******sibling?!!\n");
>>                        continue;
>>                }
>>                return tmp;
> 
> 
> Thanks and Regards,
> Ashlesha.

WBR, Sergei
