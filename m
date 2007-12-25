Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Dec 2007 14:33:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38885 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576160AbXLYOdO (ORCPT <rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 25 Dec 2007 14:33:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBPEWiJG000605;
	Tue, 25 Dec 2007 15:32:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBPEWf3Y000604;
	Tue, 25 Dec 2007 15:32:41 +0100
Date:	Tue, 25 Dec 2007 15:32:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Alon Bar-Lev <alon.barlev@gmail.com>,
	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [MIPS] MEM_SDREFCFG is not defined for Alchemy DB1550 (compile
	fail)
Message-ID: <20071225143240.GA29231@linux-mips.org>
References: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com> <4770DE51.5000205@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4770DE51.5000205@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 25, 2007 at 01:41:21PM +0300, Sergei Shtylyov wrote:

>> When I have:
>> CONFIG_MIPS_DB1550
>> CONFIG_SOC_AU1550
>> CONFIG_SOC_AU1X00
>> CONFIG_PM
>
>> MEM_SDREFCFG is used at:
>> arch/mips/au1000/common/power.c::pm_do_freq()
>
>    PM code is generally broken and unmaintained, so no wonder. I don't 
> remember if anyone has fixed CPU context restoration code (it uses a 
> "skewed" stack frame).
>
>> While the MEM_SDREFCFG constant is declare only for CONFIG_SOC_AU1000,
>> CONFIG_SOC_AU1500, CONFIG_SOC_AU1100 at:
>> include/asm-mips/mach-au1x00/au1000.h
>
>> Maybe MEM_SDREFCFG should be defined for CONFIG_SOC_AU1X00?
>
>    I've just looked into the Au1550 datasheet and indeed it doesn't have 
> such register; its SDDRAM controller is not compatible with older SoCs.
>
>> Or there should be #ifdef for its usage in power.c?
>
>    Looks like you'll have to invent something... ;-)
>
>> Best Regards,
>> Alon Bar-Lev.

So I guess it's time to mark the whole PM stuff as BROKEN?

  Ralf
