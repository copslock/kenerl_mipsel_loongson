Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 15:27:16 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:57363 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20171245AbYD1O1O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Apr 2008 15:27:14 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1282A3ECB; Mon, 28 Apr 2008 07:27:07 -0700 (PDT)
Message-ID: <4815DE95.9010107@ru.mvista.com>
Date:	Mon, 28 Apr 2008 18:26:29 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	bzolnier@gmail.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Au1200: kill IDE driver function prototypes
References: <200804142228.51987.sshtylyov@ru.mvista.com>
In-Reply-To: <200804142228.51987.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> Fix these warnings emitted when compiling drivers/ide/mips/au1xxx-ide.c:

> include/asm/mach-au1x00/au1xxx_ide.h:137: warning: 'auide_tune_drive' declared 
> `static' but never defined
> include/asm/mach-au1x00/au1xxx_ide.h:138: warning: 'auide_tune_chipset' declared
>  `static' but never defined

> by wiping out the whole "function prototyping" section from the header file
> <asm-mips/mach-au1x00/au1xxx_ide.h> as it mostly declared functions that are
> already dead in the IDE driver; move the only useful prototype into the driver.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

> Bart, au1xxx-ide-fix-mwdma-support.patch will probably need to be updated to
> remove that added prototype since it won't be needed anymore...

    Which you haven't done either in that patch or in 
au1xxx-ide-use-init_dma-method.patch. So, face the consequences:

drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
'auide_ddma_init' was here
drivers/ide/mips/au1xxx-ide.c:456: error: conflicting types for 'auide_ddma_init'
drivers/ide/mips/au1xxx-ide.c:51: error: previous declaration of
'auide_ddma_init' was here
drivers/ide/mips/au1xxx-ide.c:51: warning: 'auide_ddma_init' used but never
defined

MBR, Sergei
