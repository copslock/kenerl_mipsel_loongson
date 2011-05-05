Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 00:15:08 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41187 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490992Ab1EEWPD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 May 2011 00:15:03 +0200
Message-ID: <4DC321C7.8060600@openwrt.org>
Date:   Fri, 06 May 2011 00:16:39 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     ralf@linux-mips.org, ralph.hempel@lantiq.com,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/3] MIPS: lantiq: add ethernet driver
References: <1304633402-24161-1-git-send-email-blogic@openwrt.org>      <1304633402-24161-3-git-send-email-blogic@openwrt.org> <20110505.151049.35056363.davem@davemloft.net>
In-Reply-To: <20110505.151049.35056363.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

On 06/05/11 00:10, David Miller wrote:
> From: John Crispin <blogic@openwrt.org>
> Date: Fri,  6 May 2011 00:10:01 +0200
>
>   
>> This patch adds the driver for the ETOP Packet Processing Engine (PPE32) found
>> inside the XWAY family of Lantiq MIPS SoCs. This driver makes 100MBit ethernet
>> work. Support for all 8 dma channels, gbit and the embedded switch found on
>> the ar9/vr9 still needs to be implemented.
>>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
>>     
> No objections from me and this can go via the MIPS tree:
>
> Acked-by: David S. Miller <davem@davemloft.net>
>
>   
Thank you !
