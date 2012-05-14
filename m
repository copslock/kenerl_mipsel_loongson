Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 20:45:30 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:36211 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903703Ab2ENSpY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 20:45:24 +0200
Message-ID: <4FB152C0.70400@openwrt.org>
Date:   Mon, 14 May 2012 20:45:20 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Langer <thomas.langer@lantiq.com>,
        spi-devel-general@lists.sourceforge.net
Subject: Re: [RESEND PATCH V2 16/17] SPI: MIPS: lantiq: add FALCON spi driver
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org> <1337017363-14424-16-git-send-email-blogic@openwrt.org> <CAOiHx==N=au_PhR51tJjSZ8Em1tfZxv8gO7GJTD_MS=5dFAuEQ@mail.gmail.com>
In-Reply-To: <CAOiHx==N=au_PhR51tJjSZ8Em1tfZxv8gO7GJTD_MS=5dFAuEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 33311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 14/05/12 20:32, Jonas Gorski wrote:
> There was a patch accepted just a few days ago dropping the
> requirement for (un)prepare_transfer being populated :)
>

Hi,

this patch needs to flow via ralfs next tree, so i will keep this to
avoid merge order breaking the code. I will add it on my todo for RC1.

Will resend with your comments folded into the patch in a moment.

Thanks,
John
