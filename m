Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2006 17:35:13 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:16832 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038484AbWHSQfK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Aug 2006 17:35:10 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 606BA3EF4; Sat, 19 Aug 2006 09:35:05 -0700 (PDT)
Message-ID: <44E73DFD.5030404@ru.mvista.com>
Date:	Sat, 19 Aug 2006 20:36:13 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH] TX49 has write buffer
References: <44E64687.7000704@ru.mvista.com>
In-Reply-To: <44E64687.7000704@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylyov wrote:

> TX49 CPUs have a write buffer, so we need to select CPU_HAS_WB -- 
> otherwise all Toshiba RBTX49xx kernels fail to build.

    The uptimate reason is I think that <asm/system.h> doesn't include 
<asm/wbflush.h> if CONFIG_CPU_HAS_WB is undefined -- although, <asm/wbflush.h> 
handles this situation itself. Well, <asm/system.h> doesn't need the wbflush() 
macro in that case, so it's in his own right to not include that header...

WBR, Sergei
