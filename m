Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 22:30:02 +0100 (CET)
Received: from vs18.mail.saunalahti.fi ([62.142.117.199]:38990 "EHLO
        vs18.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008714AbbLQVaAXXIWa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 22:30:00 +0100
Received: from vams (localhost [127.0.0.1])
        by vs18.mail.saunalahti.fi (Postfix) with SMTP id C5DEC1800B9;
        Thu, 17 Dec 2015 23:29:54 +0200 (EET)
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi [195.197.172.115])
        by vs18.mail.saunalahti.fi (Postfix) with ESMTP id 913A11800B9;
        Thu, 17 Dec 2015 23:29:54 +0200 (EET)
Received: from [192.168.1.230] (91-157-120-53.elisa-laajakaista.fi [91.157.120.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by gw01.mail.saunalahti.fi (Postfix) with ESMTPSA id 7E1964008B;
        Thu, 17 Dec 2015 23:29:52 +0200 (EET)
To:     linux-mips@linux-mips.org
Cc:     Liviu.Dudau@arm.com
From:   Matti Laakso <malaakso@elisanet.fi>
Subject: Unable to allocate PCI I/O resources
Message-ID: <56732950.4060201@elisanet.fi>
Date:   Thu, 17 Dec 2015 23:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <malaakso@elisanet.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malaakso@elisanet.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello all,

I have some oldish MIPS-based (Lantiq Danube) routers that have a PCI
bus and a VIA 6212 USB-controller connected to it. The USB controller
requires I/O resources in addition to memory. It seems that with kernel
3.18 and newer PCI I/O resources can no longer be allocated on this
platform. I tracked the problem down to a patch set from Liviu Dudau
(Support for creating generic PCI host bridges from DT). After this
patch the function pci_address_to_pio in drivers/of/address.c hits the check

address > IO_SPACE_LIMIT

since address on this SoC is 0x1AE00000 and IO_SPACE_LIMIT is 0xFFFF on
MIPS (PCI_IOBASE is not defined). Changing IO_SPACE_LIMIT to 0xFFFFFFFF
I can work around the problem, but I think that is not the proper solution.

Any ideas on how to fix this?

Best regards,
Matti Laakso
