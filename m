Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 19:54:58 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:28040 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20029896AbYDPSyz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2008 19:54:55 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 77FCD3EC9; Wed, 16 Apr 2008 11:54:48 -0700 (PDT)
Message-ID: <48064B52.4050804@ru.mvista.com>
Date:	Wed, 16 Apr 2008 22:54:10 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: kill useless #include's, #define's and	extern's
 (take 3)
References: <200804162115.59620.sshtylyov@ru.mvista.com> <20080416172737.GA32263@linux-mips.org>
In-Reply-To: <20080416172737.GA32263@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>>Go thru the Alchemy code and hunt down every unneeded #include, #define, and
>>extern (some of which refer to already long dead functions).

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>Killed #include <au1xxx_dbdma.h> and couple #define's in
>>arch/mips/au1000/pb1200/board_setup.c...

>>Please update the queued patch, hopefully the last time. :-)

> Done,

    Thanks. But actually, summary and description also did change -- but not 
in the queue. :-)

>   Ralf

WBR, Sergei
