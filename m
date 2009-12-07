Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 14:34:15 +0100 (CET)
Received: from [222.92.8.141] ([222.92.8.141]:50673 "EHLO lemote.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493664AbZLGNeM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Dec 2009 14:34:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by lemote.com (Postfix) with ESMTP id E810731CAF9;
        Mon,  7 Dec 2009 21:20:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
        by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TuQzA4zjt0Yl; Mon,  7 Dec 2009 21:19:44 +0800 (CST)
Received: from localhost.localdomain (unknown [222.92.8.142])
        by lemote.com (Postfix) with ESMTP id C3A2D31CAEB;
        Mon,  7 Dec 2009 21:19:43 +0800 (CST)
Message-ID: <4B1D038B.5080801@lemote.com>
Date:   Mon, 07 Dec 2009 21:30:51 +0800
From:   zhangfx <zhangfx@lemote.com>
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To:     figo zhang <figo1802@gmail.com>
CC:     wuzhangjin@gmail.com, linux-mips@linux-mips.org,
        rostedt@goodmis.org
Subject: Re: Dma addr should use Kuseg1 for MIPS32?
References: <c6ed1ac50912062352u227c28e1me2107dbf7bd8a0ea@mail.gmail.com>
In-Reply-To: <c6ed1ac50912062352u227c28e1me2107dbf7bd8a0ea@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070202050902040205000906"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070202050902040205000906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

physical address (address comes out of the CPU bus to memory) can be=20
different with bus address(used by DMA) in MIPS boards.

figo zhang =E5=86=99=E9=81=93:
> hi,
>
> I am writing a driver for MIPS32. i wirte this code for DMA addr:
>
> dma_vaddr =3D(char*) __get_free_pages(GFP_KERNEL|GFP_DMA, order);
> dma_phy =3D virt_to_phy(dma_vaddr);
>
> i write dma_phy to DMA base register, but why it cannot work? it=20
> should write Kseg1 space to DMA register?
> I remember that it is ok for ARM/X86 .
>
>
> Best,
> Figo.zhang

--------------070202050902040205000906
Content-Type: text/x-vcard; charset=utf-8;
 name="zhangfx.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="zhangfx.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUU1PUJDPUEwPUU3PUE2PThGPUU2
PTk2PUIwDQpuO3F1b3RlZC1wcmludGFibGU7cXVvdGVkLXByaW50YWJsZTo9RTU9QkM9QTA7
PUU3PUE2PThGPUU2PTk2PUIwDQpvcmc7cXVvdGVkLXByaW50YWJsZTo7PUU3PUFFPUExPUU3
PTkwPTg2PUU5PTgzPUE4DQphZHI7cXVvdGVkLXByaW50YWJsZTtkb206Ozs9RTY9QjE9OUY9
RTg9OEI9OEY9RTc9OUM9ODE9RTU9Qjg9Qjg9RTc9ODY9OUY9RTU9Qjg9ODI9RTg9OTk9OUU9
RTU9QjE9QjE9RTk9DQoJPTk1PTg3PUU2PUEyPUE2PUU1PTg1PUIwPUU1PUI3PUE1PUU0PUI4
PTlBPUU1PTlCPUFEOzs7MjE1NTAwDQplbWFpbDtpbnRlcm5ldDp6aGFuZ2Z4QGxlbW90ZS5j
b20NCnRpdGxlO3F1b3RlZC1wcmludGFibGU6PUU2PTgwPUJCPUU3PUJCPThGPUU3PTkwPTg2
DQp0ZWw7d29yazowNTEyLTUyMzA4Njc5DQp1cmw6aHR0cDovL3d3dy5sZW1vdGUuY29tDQp2
ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------070202050902040205000906--
