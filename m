Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 14:20:06 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54497 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491755Ab1DEMUE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Apr 2011 14:20:04 +0200
Message-ID: <4D9B0951.3030206@openwrt.org>
Date:   Tue, 05 Apr 2011 14:21:37 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V6] MIPS: lantiq: add NOR flash support
References: <1302005720-8508-1-git-send-email-blogic@openwrt.org> <1302005751.2760.116.camel@localhost>
In-Reply-To: <1302005751.2760.116.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips


> Sorry, but pr_err is defined as follows:
>
> #define pr_err(fmt, ...) \
>         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>
> You should not add KERN_INFO.
>
>   
Hi,

i missed that one :(
let me resend a fixed version

sorry,
John
