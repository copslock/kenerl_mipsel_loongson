Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2011 13:06:38 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:58225 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491925Ab1AKMGf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jan 2011 13:06:35 +0100
Message-ID: <4D2C480C.4030109@openwrt.org>
Date:   Tue, 11 Jan 2011 13:07:40 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 00/10] MIPS: add support for Lantiq SoCs
References: <1294257379-417-1-git-send-email-blogic@openwrt.org> <4D2BC3F7.3080006@gmail.com>
In-Reply-To: <4D2BC3F7.3080006@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

On 11/01/11 03:44, Daniel Schwierzeck wrote:
> Hi John,
>
> after the 2.6.36 release i've started the same upstream project. I'm
> hacking software for CPE's with Danube and VRX SoC's thus I have full
> access to hardware manuals and latest BSP's. Maybe we should merge our
> code somehow ;)
>
> Daniel

Hi Daniel,

i am in the middle of finishing my dma/etop rewrite. once this is done i
think the core is ready.

in general all contributions are welcome. question is if it is a good
idea to merge the 2 trees now or if we merge one and then fix/add
fetures that your tree has that mine is missing.

i was unable to find any public place where you keep your code. could
you upload it somewhere so i can see what the exact differences are ?

also could you tell me what the code base is based on ? (spinacer,
ifxcpe, ifxmips...)

i have so far not added vrx support due to lack of hardware to test on.
a quick read of the docs does tell me however that only the gbit
phy/switch and the clk needs to be adapted for vrx to also work. the
gbit phy/switch part will already be included in my etop patches as it
is needed by the arx series

thanks,
John

thanks,
John
