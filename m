Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2011 16:42:53 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60820 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491174Ab1CBPmu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Mar 2011 16:42:50 +0100
Message-ID: <4D6E65C8.4020500@openwrt.org>
Date:   Wed, 02 Mar 2011 16:44:08 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com>
In-Reply-To: <4D6E286D.9050100@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Sergei,

thanks for the comments, one question below
>> +    /* we do not need to enable the clock as it is always running */
>> +    clk = clk_get(&pdev->dev, "io");
>
>    clk_get() may fail...
>

lantiq socs have 2 static clock that are always running. so i think it
is safe to assume that this wont fail unless someone renames the clocks.

alternatively i could add a

if (!clk)
   BUG();

but i am not sure if it is required.

thanks,
John
