Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 11:04:24 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:43343 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832192Ab3AXKEYICjB5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 11:04:24 +0100
Message-ID: <51010635.9080707@openwrt.org>
Date:   Thu, 24 Jan 2013 11:00:21 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 01/11] MIPS: allow platforms to override cp0_compare_irq
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-2-git-send-email-blogic@openwrt.org> <5101043A.6080009@openwrt.org>
In-Reply-To: <5101043A.6080009@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

> Maybe we should use Felix's patch [1] to fix this. That seems simpler as it uses
> the existing 'get_c0_compare_int' function. Also it covers mips_r1 CPUs as well.
> I did not test that on Ralink SoCs though.
>
> -Gabor
>
> 1.
> https://dev.openwrt.org/browser/trunk/target/linux/atheros/patches-3.3/001-get_c0_compare_int_fix.patch
>

ok, i will test it on the eval board today ...

     John
