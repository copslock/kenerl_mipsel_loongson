Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 09:45:45 +0100 (BST)
Received: from webmail.ict.ac.cn ([IPv6:::ffff:159.226.39.7]:37345 "HELO
	ict.ac.cn") by linux-mips.org with SMTP id <S8224901AbUJNIpl>;
	Thu, 14 Oct 2004 09:45:41 +0100
Received: (qmail 27975 invoked by uid 507); 14 Oct 2004 08:22:49 -0000
Received: from unknown (HELO ict.ac.cn) (fxzhang@159.226.40.187)
  by ict.ac.cn with SMTP; 14 Oct 2004 08:22:49 -0000
Message-ID: <416E3CA4.9080807@ict.ac.cn>
Date: Thu, 14 Oct 2004 16:45:24 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: Dmitriy Tochansky <toch@dfpost.ru>
CC: linux-mips@linux-mips.org
Subject: Re: Strange instruction
References: <20041014115304.3edbe141.toch@dfpost.ru>
In-Reply-To: <20041014115304.3edbe141.toch@dfpost.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

objdump -d -mmips:4000 vmlinux to force it regconize all MIPS III 
instructions

I think this option should be renamed( i had try -mips3 -mmips3 etc. 
before i find it
by reading the source code)
 or the default should be changed.

Dmitriy Tochansky wrote:

>Hello!
>
>When starts kernel for my au1500 board reseting board. After disassembling I found instruction
>which reseting board. Here is few strings of "mipsel-linux-objdump -D vmlinux" output:
>
>---
>
>a0000650:       07400003        bltz    k0,a0000660 <nmi_handler+0x1c>          
>a0000654:       03a0d82d        0x3a0d82d                                       
>a0000658:       3c1ba020        lui     k1,0xa020 
>
>---
>
>Base address changed by me.
>
>What is A0000654? There is board resets.
>
>
>
>  
>
