Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 13:23:09 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:40264 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835062Ab3DLLXGUTVvZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 13:23:06 +0200
Message-ID: <5167EDAE.4020000@openwrt.org>
Date:   Fri, 12 Apr 2013 13:19:10 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 09/16] MIPS: ralink: adds support for RT2880 SoC family
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-9-git-send-email-blogic@openwrt.org> <5167EC0A.8020003@openwrt.org>
In-Reply-To: <5167EC0A.8020003@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36112
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

On 12/04/13 13:12, Gabor Juhos wrote:
> The commit log says that the code registers the pinmux settings. However the
> patch only contains the definitions of the pinmux groups without doing anything
> with those. Additionally, the structures and the 'rt288x_wdt_reset' function
> should be static.
>
> However converting them to static would cause compiler warnings about unused
> variables/functions. So it would be simpler to remove these. You have removed
> the pinmux driver from the series anyway, and this part can't be used without that.


the same was done for rt305x and causes no harm, so I really don't see a 
problem with adding these now.

i will address the "static" bit for the next series
