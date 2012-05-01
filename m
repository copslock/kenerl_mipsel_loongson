Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 08:38:34 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:33633 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901761Ab2EAGi2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 May 2012 08:38:28 +0200
Message-ID: <4F9F8494.1010002@openwrt.org>
Date:   Tue, 01 May 2012 08:37:08 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 08/14] MIPS: lantiq: clear all irqs properly on boot
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org> <1335785589-32532-8-git-send-email-blogic@openwrt.org> <4F9F19D3.7040006@mvista.com>
In-Reply-To: <4F9F19D3.7040006@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/05/12 01:01, Sergei Shtylyov wrote:
> Hello.
>
> On 30-04-2012 15:33, John Crispin wrote:
>
>> Due to a wrongly placed bracket,
>
>    I don't see a bracket in old code at all.

Wrongly placed in a different file :-)

Thanks, i will make the message more precise

John
