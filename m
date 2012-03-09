Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 12:30:09 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:33275 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903589Ab2CILaG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2012 12:30:06 +0100
Message-ID: <4F59E99D.7090409@openwrt.org>
Date:   Fri, 09 Mar 2012 12:29:33 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH V2 1/3] MTD: MIPS: lantiq: use module_platform_driver
 inside lantiq map driver
References: <1330013024-13622-1-git-send-email-blogic@openwrt.org> <1331292517.29445.6.camel@sauron.fi.intel.com>
In-Reply-To: <1331292517.29445.6.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 32624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/03/12 12:28, Artem Bityutskiy wrote:
> On Thu, 2012-02-23 at 17:03 +0100, John Crispin wrote:
>> Reduce boilerplate code by converting driver to module_platform_driver.
>>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> Cc: linux-mtd@lists.infradead.org
> This is not an independent patch - do you want to merge it via the mips
> tree?
>
via MIPS, sorry for not putting the info in the commit text
