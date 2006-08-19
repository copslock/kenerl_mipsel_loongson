Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2006 17:03:20 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:55231 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038482AbWHSQDT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Aug 2006 17:03:19 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C67633EF4; Sat, 19 Aug 2006 09:03:14 -0700 (PDT)
Message-ID: <44E73688.4000906@ru.mvista.com>
Date:	Sat, 19 Aug 2006 20:04:24 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mlachwani@mvista.com
Subject: Re: [PATCH] TX49 has write buffer
References: <44E64687.7000704@ru.mvista.com> <20060819.231132.25910211.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060819.231132.25910211.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>TX49 CPUs have a write buffer, so we need to select CPU_HAS_WB -- otherwise 
>>all Toshiba RBTX49xx kernels fail to build.

> TX49 CPUs also have a SYNC instruction which flushes a write buffer.
> I think it is enough and wbflush() have been abused in
> arch/mips/tx4927/ and arch/mips/tx4938/ codes.

    How about a patch? I needed the kernel up and running, so I came up with 
the obvious patch. I don't have no time to fix this assumed abuse.
    I should also note, that this patch wasn't enough to bring RBTX4938 kernel 
back to life since rbhma4500_defconfig is broken somewhere so the kernel 
doesn't output anything on the colsole). If I have some more time, I'll try to 
investigate what exactly was causing this (I have a working .config)...

WBR, Sergei
