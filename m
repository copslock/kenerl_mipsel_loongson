Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 12:19:58 +0200 (CEST)
Received: from mail-ew0-f221.google.com ([209.85.219.221]:40983 "EHLO
        mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492356Ab0EDKTz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 12:19:55 +0200
Received: by ewy21 with SMTP id 21so983745ewy.25
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 03:19:49 -0700 (PDT)
Received: by 10.213.77.13 with SMTP id e13mr1403561ebk.7.1272968388771;
        Tue, 04 May 2010 03:19:48 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-77-52-154.pppoe.mtu-net.ru [91.77.52.154])
        by mx.google.com with ESMTPS id 14sm3651182ewy.14.2010.05.04.03.19.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 03:19:48 -0700 (PDT)
Message-ID: <4BDFF49A.9000404@mvista.com>
Date:   Tue, 04 May 2010 14:19:06 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     yajin <yajinzhou@vm-kernel.org>
CC:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com, vince@simtec.co.uk,
        ben@simtec.co.uk
Subject: Re: [PATCH 8/12] gdium uses different freq of mclk&m1xclk of sm501
References: <q2u180e2c241005040255n628614a0p828116a04f65a894@mail.gmail.com>
In-Reply-To: <q2u180e2c241005040255n628614a0p828116a04f65a894@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

yajin wrote:

> Gdium uses different freq of mclk&m1xclk of sm501. This seems a dirty
> hack. Maybe we need a configuration option for changing the freq of
> these clocks.
>
> Signed-off-by: yajin <yajin@vm-kernel.org>
> ---
>  drivers/mfd/sm501.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index ce5dfce..5e55cbd 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -1606,10 +1606,15 @@ static struct sm501_initdata sm501_pci_initdata = {
>  	.devices	= SM501_USE_ALL,
>
>  	/* Errata AB-3 says that 72MHz is the fastest available
> -	 * for 33MHZ PCI with proper bus-mastering operation */
> -
> +	 * for 33MHZ PCI with proper bus-mastering operation
> +	 * For gdium, it works under 84&112M clock freq.*/
>   

   According to CodingStyle, style of multiline comments should 
preferably be:

/*
 * bla
 * bla
 * bla
 */

WBR, Sergei
