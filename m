Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 14:34:11 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:1246 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20021797AbXDRNeK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2007 14:34:10 +0100
Received: (qmail 32598 invoked by uid 507); 18 Apr 2007 21:36:22 +0800
Received: from unknown (HELO ?192.168.1.7?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 18 Apr 2007 21:36:22 +0800
Message-ID: <46261DE2.5040908@ict.ac.cn>
Date:	Wed, 18 Apr 2007 21:32:18 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	tiansm@lemote.com, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <20070418120620.GE3938@linux-mips.org>
In-Reply-To: <20070418120620.GE3938@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips


>> +
>>     
>
> Is there anything in implementation of this option Loongson2-specific?
>   
Yes. Most 64bit MIPS processors cannot access 64bit content of registers 
when it is in 32bit mode.

Loongson2 has no 32/64 mode bit in fact.

And the usage arise from Loongson2's multimedia extension, which is also 
uniq.
> If not then I suggest we make this option loook like:
>
>    bool "Save 64bit integer registers" if CPU_SUPPORTS_64BIT_KERNEL && 32BIT
>
> Somebody else might have a use for it!
>
>   Ralf
>
>
>
>
>   
