Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 19:02:50 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:47085 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835071Ab3DLRCqQb1pJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 19:02:46 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rT5EB0QOxMSc; Fri, 12 Apr 2013 19:01:59 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 2B64C280520;
        Fri, 12 Apr 2013 19:01:59 +0200 (CEST)
Message-ID: <51683E53.8040208@openwrt.org>
Date:   Fri, 12 Apr 2013 19:03:15 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 09/16] MIPS: ralink: adds support for RT2880 SoC family
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-9-git-send-email-blogic@openwrt.org> <5167EC0A.8020003@openwrt.org> <5167EDAE.4020000@openwrt.org>
In-Reply-To: <5167EDAE.4020000@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.12. 13:19 keltezéssel, John Crispin írta:
> On 12/04/13 13:12, Gabor Juhos wrote:
>> The commit log says that the code registers the pinmux settings. However the
>> patch only contains the definitions of the pinmux groups without doing anything
>> with those. Additionally, the structures and the 'rt288x_wdt_reset' function
>> should be static.
>>
>> However converting them to static would cause compiler warnings about unused
>> variables/functions. So it would be simpler to remove these. You have removed
>> the pinmux driver from the series anyway, and this part can't be used without
>> that.
> 
> 
> the same was done for rt305x and causes no harm, so I really don't see a problem
> with adding these now.

You are right, it causes no harm explicitly. Simply it adds dead code which will
be built into the kernel and it will never run.

> i will address the "static" bit for the next series

Don't bother with that. Adding static declaration for unused variables/functions
give us nothing but compiler warnings.

-Gabor
