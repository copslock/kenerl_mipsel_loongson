Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 04:16:11 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.199]:48396 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133360AbVKGEPw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Nov 2005 04:15:52 +0000
Received: by zproxy.gmail.com with SMTP id x7so241758nzc
        for <linux-mips@linux-mips.org>; Sun, 06 Nov 2005 20:17:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QMcGtTFrpyK0e3mCtYoQbR+w7eGNSnDuONPzROXDSo04Ppq+s871IOrWuEbidYQlei8syQXCPcj3LOBNNsvCk74XzbPtdYRRKVu63ULjaLfAS0+NEG4ae59GMSByljzTUZ2nGjEpBso0sVO1owLoiNxXhbbtFukuUbAY7hosgdg=
Received: by 10.36.177.6 with SMTP id z6mr1520768nze;
        Sun, 06 Nov 2005 20:17:02 -0800 (PST)
Received: by 10.36.24.9 with HTTP; Sun, 6 Nov 2005 20:17:01 -0800 (PST)
Message-ID: <4955666b0511062017q5ea4fbc3g@mail.gmail.com>
Date:	Mon, 7 Nov 2005 13:17:02 +0900
From:	Yoichi Yuasa <yyuasa@gmail.com>
To:	Andre <armcc2000@yahoo.com>
Subject: Re: 2.6.14-git9 cobalt build fails
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051106152314.10450.qmail@web35615.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20051106152314.10450.qmail@web35615.mail.mud.yahoo.com>
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yyuasa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Andre,

2005/11/7, Andre <armcc2000@yahoo.com>:
> Not sure if the cobalt support that's just gone into the mainstream
> kernel is even supposed to compile yet... but it doesn't ;-) I tried
> 2.6.14 + git9 patch from kernel.org.
>
> Note that default config was tweaked slightly (to enable IDE DMA and
> a network driver).
>
>   ...
>   CC      arch/mips/pci/pci.o
>   CC      arch/mips/pci/ops-gt64111.o
>   CC      arch/mips/pci/fixup-cobalt.o
> arch/mips/pci/fixup-cobalt.c:35: error:
> `PCI_DEVICE_ID_MARVELL_GT64111' undeclared here (not in a function)
> arch/mips/pci/fixup-cobalt.c:35: error: initializer element is not
> constant
> arch/mips/pci/fixup-cobalt.c:35: error: (near initialization for
> `__pci_fixup_PCI_VENDOR_ID_MARVELLPCI_DEVICE_ID_MARVELL_GT64111qube_raq_galileo_early_fixup.device')
> arch/mips/pci/fixup-cobalt.c:116: error: initializer element is not
> constant
> arch/mips/pci/fixup-cobalt.c:116: error: (near initialization for
> `__pci_fixup_PCI_VENDOR_ID_MARVELLPCI_DEVICE_ID_MARVELL_GT64111qube_raq_galileo_fixup.device')
> arch/mips/pci/fixup-cobalt.c:58: error:
> __pci_fixup_PCI_VENDOR_ID_VIAPCI_DEVICE_ID_VIA_82C586_1qube_raq_via_bmIDE_fixup
> causes a section type conflict
> make[1]: *** [arch/mips/pci/fixup-cobalt.o] Error 1
> make: *** [arch/mips/pci] Error 2
> root@qube2:/usr/src/linux-2.6.14#
>

PCI_DEVICE_ID_MARVELL_GT64111 was removed from kernel.org git(I don't know why).
Please add the following device ID to include/linux/pci_ids.h

#define PCI_DEVICE_ID_MARVELL_GT64111 0x4146

Yoichi
