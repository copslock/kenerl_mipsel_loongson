Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Dec 2007 10:41:32 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:41420 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023087AbXLYKlY (ORCPT
	<rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 25 Dec 2007 10:41:24 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B35F03EC9; Tue, 25 Dec 2007 02:40:50 -0800 (PST)
Message-ID: <4770DE51.5000205@ru.mvista.com>
Date:	Tue, 25 Dec 2007 13:41:21 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alon Bar-Lev <alon.barlev@gmail.com>
Cc:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [MIPS] MEM_SDREFCFG is not defined for Alchemy DB1550 (compile
 fail)
References: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>
In-Reply-To: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alon Bar-Lev wrote:

> When I have:
> CONFIG_MIPS_DB1550
> CONFIG_SOC_AU1550
> CONFIG_SOC_AU1X00
> CONFIG_PM

> MEM_SDREFCFG is used at:
> arch/mips/au1000/common/power.c::pm_do_freq()

    PM code is generally broken and unmaintained, so no wonder. I don't 
remember if anyone has fixed CPU context restoration code (it uses a "skewed" 
stack frame).

> While the MEM_SDREFCFG constant is declare only for CONFIG_SOC_AU1000,
> CONFIG_SOC_AU1500, CONFIG_SOC_AU1100 at:
> include/asm-mips/mach-au1x00/au1000.h

> Maybe MEM_SDREFCFG should be defined for CONFIG_SOC_AU1X00?

    I've just looked into the Au1550 datasheet and indeed it doesn't have such 
register; its SDDRAM controller is not compatible with older SoCs.

> Or there should be #ifdef for its usage in power.c?

    Looks like you'll have to invent something... ;-)

> Best Regards,
> Alon Bar-Lev.

WBR, Sergei
