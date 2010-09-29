Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 18:25:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11918 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491132Ab0I2QZA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Sep 2010 18:25:00 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca3687a0000>; Wed, 29 Sep 2010 09:25:30 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 29 Sep 2010 09:24:57 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 29 Sep 2010 09:24:57 -0700
Message-ID: <4CA36859.2050506@caviumnetworks.com>
Date:   Wed, 29 Sep 2010 09:24:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: How to setup interrupts for a new board?
References: <AEA634773855ED4CAD999FBB1A66D0760115A5BC@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760115A5BC@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Sep 2010 16:24:57.0459 (UTC) FILETIME=[DB34DC30:01CB5FF2]
X-archive-position: 27890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 23472

On 09/29/2010 07:06 AM, Ardelean, Andrei wrote:
> Hi,
>
> I created new board specific files gd_xxxx similar with malta_xxxx and I
> am trying to configure Linux interrupts in gd-int.c.
> My board has no external interrupt controller like Malta has, it has no
> PCI, I use Vectored interrupt mode and a mux routes the external
> interrupts to the MIPS h/w interrupts.
> Wthat is the meaning of the following switches and how to set them:
> cpu_has_divec		
> cpu_has_vce		
> cpu_has_llsc
> cpu_has_counter
> cpu_has_vint
>
> What is the difference between:
> setup_irq()
> set_irq_handler()
> set_vi_handler()
>
> Can you point me to document regarding interrupts implementation in MIPS
> Linux?

Other than the Linux Kernel source code, make sure you have a copy of:

MD00090-2B-MIPS32PRA-AFP, the "MIPS32® Architecture for Programmers 
Volume III: The MIPS32® Privileged Resource Architecture"

It can be downloaded from mips.com

David Daney


>
> Thanks,
> Andrei
>
>
