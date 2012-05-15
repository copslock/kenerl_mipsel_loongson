Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 18:48:17 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54925 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903678Ab2EOQsK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 May 2012 18:48:10 +0200
Message-ID: <4FB288C5.2020207@openwrt.org>
Date:   Tue, 15 May 2012 18:48:05 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RESEND PATCH V2 06/17] MIPS: lantiq: convert dma to platform
 driver
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org> <1337017363-14424-6-git-send-email-blogic@openwrt.org> <4FB237EE.5010502@mvista.com> <4FB28694.6030300@mvista.com>
In-Reply-To: <4FB28694.6030300@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 15/05/12 18:38, Sergei Shtylyov wrote:
> Hello.
>
> On 05/15/2012 03:03 PM, Sergei Shtylyov wrote:
>
>>> Add code to make the dma driver load as a platform device from the
>>> devicetree.
>
>>> Signed-off-by: John Crispin<blogic@openwrt.org>
>>> ---
>>> arch/mips/lantiq/xway/dma.c | 65
>>> ++++++++++++++++++++++++++++--------------
>>> 1 files changed, 43 insertions(+), 22 deletions(-)
>
>>> diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
>>> index b210e93..0dffb94 100644
>>> --- a/arch/mips/lantiq/xway/dma.c
>>> +++ b/arch/mips/lantiq/xway/dma.c
>> [...]
>>> +int __init
>>> +dma_init(void)
>>> +{
>>> + int ret = platform_driver_register(&dma_driver);
>>> +
>>> + if (ret)
>>> + pr_info("ltq_dma : Error registering platfom driver!");
>
>> You forgot '\n'.
>
>    And I didn't notice "platfom" at first. Sorry. :-)
>    Maybe you'll just get rid of the message? ;-)
>
> WBR, Sergei
>
good idea :-)
