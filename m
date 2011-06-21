Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 20:51:41 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45384 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491160Ab1FUSvf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 20:51:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 95FB38BCB;
        Tue, 21 Jun 2011 20:51:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LfGNtwKgt0ZH; Tue, 21 Jun 2011 20:51:32 +0200 (CEST)
Received: from [192.168.0.152] (dyndsl-085-016-164-198.ewe-ip-backbone.de [85.16.164.198])
        by hauke-m.de (Postfix) with ESMTPSA id B6A7E8BC1;
        Tue, 21 Jun 2011 20:51:31 +0200 (CEST)
Message-ID: <4E00E832.5040502@hauke-m.de>
Date:   Tue, 21 Jun 2011 20:51:30 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     "John W. Linville" <linville@tuxdriver.com>
CC:     mb@bu3sch.de, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ssb: add __devinit to some functions
References: <20110621150227.GB14197@linux-mips.org> <1308680889-4217-1-git-send-email-hauke@hauke-m.de> <20110621183800.GB2273@tuxdriver.com>
In-Reply-To: <20110621183800.GB2273@tuxdriver.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17459

On 06/21/2011 08:38 PM, John W. Linville wrote:
> On Tue, Jun 21, 2011 at 08:28:09PM +0200, Hauke Mehrtens wrote:
>> Two functions in ssb are using register_pci_controller() which is
>> __devinit. The functions ssb_pcicore_init_hostmode() and
>> ssb_gige_probe() should also be __devinit.
>>
>> This fixes the following warning:
>> WARNING: vmlinux.o(.text+0x2727b8): Section mismatch in reference from the function ssb_pcicore_init_hostmode() to the function .devinit.text:register_pci_controller()
>> The function ssb_pcicore_init_hostmode() references
>> the function __devinit register_pci_controller().
>> This is often because ssb_pcicore_init_hostmode lacks a __devinit
>> annotation or the annotation of register_pci_controller is wrong.
>>
>> WARNING: vmlinux.o(.text+0x273398): Section mismatch in reference from the function ssb_gige_probe() to the function .devinit.text:register_pci_controller()
>> The function ssb_gige_probe() references
>> the function __devinit register_pci_controller().
>> This is often because ssb_gige_probe lacks a __devinit
>> annotation or the annotation of register_pci_controller is wrong.
>>
>> Reported-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Signed-off-by??
> 

Ops missing, will resend both patches.

Hauke
