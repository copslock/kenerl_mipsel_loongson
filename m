Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2008 11:40:47 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:56467 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20040923AbYEEKkp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 May 2008 11:40:45 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A87A53EC9; Mon,  5 May 2008 03:40:39 -0700 (PDT)
Message-ID: <481EE407.9080707@ru.mvista.com>
Date:	Mon, 05 May 2008 14:40:07 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Pb1000: bury the remnants of the PCI code
References: <200804052259.29959.sshtylyov@ru.mvista.com> <48176D09.7030308@ru.mvista.com> <20080429185333.GB14609@linux-mips.org>
In-Reply-To: <20080429185333.GB14609@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>>PCI support for the Pb1000 board was ectomized by Pete Popov four years ago.
>>>Unfortunately,  the header file  wasn't cleansed, so the remnants still get
>>>in the way of the kernel build (due to macro redefinitions).

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>   Hm looks like I have somehow missed the remanants in 
>>arch/mips/au1000/pb1000/board_setup.c... too bad that this patch has been 
>>long merged. :-/

> New patch, new luck ;-)

    I have posted the new patch but the luck (or lack thereof) is the same. ;-)

>   Ralf

WBR, Sergei
