Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2009 17:26:24 +0000 (GMT)
Received: from rv-out-0708.google.com ([209.85.198.244]:35828 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S21369439AbZCRR0Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2009 17:26:16 +0000
Received: by rv-out-0708.google.com with SMTP id c5so112952rvf.24
        for <multiple recipients>; Wed, 18 Mar 2009 10:26:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=0qVPW0G0Tse6YsIcJhqNwRYqUkjthcU3O4ni+S1XXek=;
        b=JeYShPRstK0P5uFFClVv+Jjp2eoQUFriY5tynFhxFzFBK/HxQRfUmQd01RziEcsRyp
         yVx+z0HhUsqnAUu17PzmiASiXsH3k3DWNCAxkp/rptMu69ftwbEVHSjlClllJVk7ad3r
         1OwAAkwnz3PgEuZE7nRO2PFFsVZfUSVUBaN1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZrSv2qsjXBUbpsHC+56sSwYdxPvd9k2aBeHehz/CNiPasckXoefvaXVuoOnBvgcOeW
         etKkmBjMnEToEBwkxOMF/8kt37Eo4YBuijYQRAHP9qVmISrezOugwPM9KGi0V9d4AQVo
         Pn1l8WkDCUgvwAPOQ8SqHcHmvhlYvj52QSl4Y=
MIME-Version: 1.0
Received: by 10.114.37.1 with SMTP id k1mr906098wak.172.1237397173491; Wed, 18 
	Mar 2009 10:26:13 -0700 (PDT)
In-Reply-To: <20090318.110154.76582864.nemoto@toshiba-tops.co.jp>
References: <e9c3a7c20903171002n50964148v8366fa2f00e3164c@mail.gmail.com>
	 <20090318.094935.238694196.nemoto@toshiba-tops.co.jp>
	 <e9c3a7c20903171823g1e6c42b9t5f042d550a6ddd47@mail.gmail.com>
	 <20090318.110154.76582864.nemoto@toshiba-tops.co.jp>
Date:	Wed, 18 Mar 2009 10:26:13 -0700
X-Google-Sender-Auth: 28eaa50d7ef021f8
Message-ID: <e9c3a7c20903181026h1801ef6i945e6ce9ccb36b8a@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Dan Williams <dan.j.williams@intel.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dan.j.williams@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 17, 2009 at 7:01 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Tue, 17 Mar 2009 18:23:46 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
>>  Or, just use some platform_data to identify the channel in the same
>> manner as atmel-mci?
>
> Yes, I still want to control chan->chan_id.
>
> The atmel-mci does not select "channel".  It just pick the first
> usable channel of the dma_device specified by platform_data.  I
> suppose dw_dmac is symmetric (it can use any channel for any slave).

You are right, it does not hardwire the channel, but it does hardwire
the device, see at32_add_device_mci [1].

> But TXx9 SoC DMAC channels are hardwired to each peripheral devices.

I think creating a dma_device instance per channel and specifying that
device like atmel-mci is the more future-proof way to go.

> And I want to call Channel-3 of DMAC-0 "dma0chan3" even if Channel-2
> was assigned to for public memcpy channel.

The problem is you could pass in the chan_id to guarantee 'chan3', but
there is no guarantee that you will get 'dma0', as the driver has no
knowledge of what other dma devices may be in the system.

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/avr32/mach-at32ap/at32ap700x.c;h=3fbfd1e32a9ee79af4f4545d95a9543b9070d189;hb=HEAD#l1327
