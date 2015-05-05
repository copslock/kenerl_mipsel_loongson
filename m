Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 20:16:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13333 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012494AbbEESQiK4mSx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2015 20:16:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 62C03E52E231;
        Tue,  5 May 2015 19:16:30 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 5 May
 2015 19:16:34 +0100
Received: from [10.100.200.220] (10.100.200.220) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 5 May
 2015 19:16:32 +0100
Message-ID: <5549083F.8080505@imgtec.com>
Date:   Tue, 5 May 2015 15:13:19 -0300
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Reply-To: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
CC:     <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH V2 0/3] Pistachio USB2.0 PHY
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org> <CAL1qeaE0+aMLBgk8SKgJ3fXm==M2-Z_yEPYNVZ0yxSee-p7YOw@mail.gmail.com>
In-Reply-To: <CAL1qeaE0+aMLBgk8SKgJ3fXm==M2-Z_yEPYNVZ0yxSee-p7YOw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.220]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

Hi Kishon,

> 
> This series adds support for the USB2.0 PHY present on the IMG Pistachio SoC.
> 
> Based on mips-for-linux-next and tested on the IMG Pistachio BuB.  If possible,
> I'd like this to go through the MIPS tree with Kishon's ACK.
> 

Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Can we have your Ack for this series so Ralf can pick it?

Thanks!
Ezequiel

> Cc: James Hartley <james.hartley@imgtec.com>
> Cc: Damien Horsley <Damien.Horsley@imgtec.com>
> 
> Changes from v1:
>  - Added patch to enable PHY driver in pistachio_defconfig
>  - Fixed a couple of spelling errors
> 
> Andrew Bresticker (3):
>   phy: Add binding document for Pistachio USB2.0 PHY
>   phy: Add driver for Pistachio USB2.0 PHY
>   MIPS: pistachio: Enable USB PHY driver in defconfig
> 
>  .../devicetree/bindings/phy/pistachio-usb-phy.txt  |  29 +++
>  arch/mips/configs/pistachio_defconfig              |   1 +
>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-pistachio-usb.c                    | 206 +++++++++++++++++++++
>  include/dt-bindings/phy/phy-pistachio-usb.h        |  16 ++
>  6 files changed, 260 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>  create mode 100644 drivers/phy/phy-pistachio-usb.c
>  create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
> 
> --
> 2.2.0.rc0.207.ga3a616c
> 

-- 
Ezequiel
