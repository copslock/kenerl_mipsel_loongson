Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2008 19:47:25 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:17757 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28792438AbYD2SrV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2008 19:47:21 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 04B3D3EC9; Tue, 29 Apr 2008 11:47:12 -0700 (PDT)
Message-ID: <48176D09.7030308@ru.mvista.com>
Date:	Tue, 29 Apr 2008 22:46:33 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Pb1000: bury the remnants of the PCI code
References: <200804052259.29959.sshtylyov@ru.mvista.com>
In-Reply-To: <200804052259.29959.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> PCI support for the Pb1000 board was ectomized by Pete Popov four years ago.
> Unfortunately,  the header file  wasn't cleansed, so the remnants still get
> in the way of the kernel build (due to macro redefinitions).

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Hm looks like I have somehow missed the remanants in 
arch/mips/au1000/pb1000/board_setup.c... too bad that this patch has been long 
merged. :-/

WBR, Sergei
