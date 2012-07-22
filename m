Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2012 18:09:23 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44052 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903467Ab2GVQJQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2012 18:09:16 +0200
Message-ID: <500C2598.906@openwrt.org>
Date:   Sun, 22 Jul 2012 18:08:56 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] MIPS: lantiq: add helper to set PCI clock delay
References: <1342940161-1421-1-git-send-email-blogic@openwrt.org> <1342940161-1421-2-git-send-email-blogic@openwrt.org> <500C2498.1010609@mvista.com>
In-Reply-To: <500C2498.1010609@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33955
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

Hi Sergei,
>> +/* allow PCI driver to specify the clock delay. This is a 6 bit
>> value */
>
>    WHy make it 'u32' then?
yep, let me change it to u8 ...

Thanks,
John
