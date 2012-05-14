Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 21:49:11 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59206 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903703Ab2ENTtF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 21:49:05 +0200
Message-ID: <4FB161AD.5000008@openwrt.org>
Date:   Mon, 14 May 2012 21:49:01 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH V2 10/17] SERIAL: MIPS: lantiq: implement OF support
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org> <1337017363-14424-10-git-send-email-blogic@openwrt.org> <20120514193232.GA5741@kroah.com>
In-Reply-To: <20120514193232.GA5741@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 14/05/12 21:32, Greg KH wrote:
> On Mon, May 14, 2012 at 07:42:36PM +0200, John Crispin wrote:
>> Add devicetree and handling for our new clkdev clocks. The patch is rather
>> straightforward. .of_match_table is set and the 3 irqs are now loaded from the
>> devicetree.
>>
>> This series converts the lantiq target to clkdev amongst other things. The
>> driver needs to handle two clocks now. The fpi bus clock used to derive the
>> divider and the clock gate needed on some socs to make the secondary port work.
>>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: linux-serial@vger.kernel.org
>> ---
>> This patch is part of a series moving the mips/lantiq target to OF and clkdev
>> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.
> Fine with me as well, if you need it:
>   Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Thank you very much !
