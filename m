Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Aug 2013 10:10:03 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47428 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818014Ab3HaIJ4apEDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 31 Aug 2013 10:09:56 +0200
Message-ID: <5221A4C1.90703@phrozen.org>
Date:   Sat, 31 Aug 2013 10:09:37 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Julia Lawall <Julia.Lawall@lip6.fr>
CC:     Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/6] MIPS: ath79: simplify platform_get_resource_byname/devm_ioremap_resource
References: <1376902316-18520-1-git-send-email-Julia.Lawall@lip6.fr> <1376902316-18520-7-git-send-email-Julia.Lawall@lip6.fr> <52164F54.2070209@openwrt.org>
In-Reply-To: <52164F54.2070209@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 22/08/13 19:50, Gabor Juhos wrote:
> 2013.08.19. 10:51 keltezéssel, Julia Lawall írta:
>> From: Julia Lawall<Julia.Lawall@lip6.fr>
>>
>> Remove unneeded error handling on the result of a call to
>> platform_get_resource_byname when the value is passed to devm_ioremap_resource.
>>
>> A simplified version of the semantic patch that makes this change is as
>> follows: (http://coccinelle.lip6.fr/)
>>
>> //<smpl>
>> @@
>> expression pdev,res,e,e1;
>> expression ret != 0;
>> identifier l;
>> @@
>>
>>    res = platform_get_resource_byname(...);
>> - if (res == NULL) { ... \(goto l;\|return ret;\) }
>>    e = devm_ioremap_resource(e1, res);
>> //</smpl>
>>
>> Signed-off-by: Julia Lawall<Julia.Lawall@lip6.fr>
>
> Acked-by: Gabor Juhos<juhosg@openwrt.org>
>
> Thanks!
>
> -Gabor

Hi,

should this patch go upstream via the lmo tree ?

	John
