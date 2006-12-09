Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2006 02:09:39 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:59296 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20038913AbWLICJe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2006 02:09:34 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id E2FEE15D4005;
	Fri,  8 Dec 2006 19:39:49 -0800 (PST)
Subject: console stuck
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Fri, 08 Dec 2006 18:22:20 -0800
Message-Id: <1165630940.7860.7.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I m very much confused as to why there is an infinite loop in the
__request_resource function in the linux/kernel/resource.c file?

The serial console is getting stuck at this point.

> for (;;) {
>                 tmp = *p;
>                 if (!tmp || tmp->start > end) {
>                         new->sibling = tmp;
>                         *p = new;
>                         new->parent = root;
>                         return NULL;
>                 }
>                 p = &tmp->sibling;
>                 if (tmp->end < start){
>                         printk("tmp->end = %d\n",tmp->end);
>                         printk("tmp->start = %d\n",tmp->start);
>                         printk("*********!!!!!!!*******sibling?!!\n");
>                         continue;
>                 }
>                 return tmp;

Thanks and Regards,
Ashlesha.
