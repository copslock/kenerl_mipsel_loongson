Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Apr 2013 17:55:32 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:36015 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835402Ab3DZPzWXcq72 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Apr 2013 17:55:22 +0200
Message-ID: <517AA268.8020005@openwrt.org>
Date:   Fri, 26 Apr 2013 17:51:04 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ralink: add missing define for RT3883_GPIO_11
References: <1366990140-23596-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1366990140-23596-1-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36298
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

On 26/04/13 17:29, Gabor Juhos wrote:
> The RT3883_GPIO_11 symbol is not declared anywhere and
> this causes the following error:
>
>    CC      arch/mips/ralink/rt3883.o
> arch/mips/ralink/rt3883.c:101:17: error: 'RT3883_GPIO_11' undeclared here (not in a function)
> make[6]: *** [arch/mips/ralink/rt3883.o] Error 1
>

Hi Gabor,

Strange, I tested all 4 Ralink SoC builds only 2 nights ago and did not 
stumble over this one ...

I will fold the fix into the patch you mentioned

     John
