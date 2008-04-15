Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 13:57:39 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:30250 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28574444AbYDOM5h (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Apr 2008 13:57:37 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 09BCC3EC9; Tue, 15 Apr 2008 05:57:33 -0700 (PDT)
Message-ID: <4804A617.5010703@ru.mvista.com>
Date:	Tue, 15 Apr 2008 16:56:55 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ralf@linux-mips.org, bzolnier@gmail.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Pb1200/DBAu1200: IDE resource size off by one
References: <200804142107.30799.sshtylyov@ru.mvista.com>
In-Reply-To: <200804142107.30799.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> The IDE platform device on Pb1200/DBAu1200 boards claims one byte too many for
> its memory resource -- fix the platform code and the IDE driver in accordance.

    Don't apply this patch yet. It turned out that the resource size is 
actually twice wrong -- 257 ISO 512. I'll send an updated patch soon.

WBR, Sergei
