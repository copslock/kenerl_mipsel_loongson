Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 13:21:53 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:17755 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021798AbXHAMVv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 13:21:51 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 85A443EC9; Wed,  1 Aug 2007 05:21:18 -0700 (PDT)
Message-ID: <46B07B36.1000501@ru.mvista.com>
Date:	Wed, 01 Aug 2007 16:23:18 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
References: <20070801115231.GA20323@linux-mips.org>
In-Reply-To: <20070801115231.GA20323@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> Somebody with a clue on the Alchemy stuff may want to look into this
> mostpost warning:

>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x1e32dc): Section mismatch: reference to .init.text:add_wired_entry (between 'config_access' and 'config_write')
>   LD      vmlinux

> All the PCI config space accessors on Alchemy will call
> arch/mips/pci/ops-au1000.c:config_access which in turn calls add_wired_entry
> add_wired_entry in turn is an __init function so it's only a matter of
> luck if the PCI code doesn't explode on Alchemy.

> So could somebody Alchemist try to rewrite this to use ioremap() instead?

    Will ioremap() work for 4 GB range? I guess not.
    What actually needs to be done is move this code under if (first_cfg) into 
__init function...

> Thanks,

>   Ralf

MBR, Sergei
