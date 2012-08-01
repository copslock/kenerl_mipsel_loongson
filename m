Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 08:50:32 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:42122 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903481Ab2HAGuV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2012 08:50:21 +0200
Message-ID: <5018D188.4090506@phrozen.org>
Date:   Wed, 01 Aug 2012 08:49:44 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: AR7: add select HAVE_CLK
References: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
In-Reply-To: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34011
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/08/12 08:38, Yoichi Yuasa wrote:
> fix redefinition of clk_*
> 
> arch/mips/ar7/clock.c:420:5: error: redefinition of 'clk_enable'
> include/linux/clk.h:295:19: note: previous definition of 'clk_enable' was here
> arch/mips/ar7/clock.c:426:6: error: redefinition of 'clk_disable'
> include/linux/clk.h:300:20: note: previous definition of 'clk_disable' was here
> arch/mips/ar7/clock.c:431:15: error: redefinition of 'clk_get_rate'
> include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate' was here
> arch/mips/ar7/clock.c:437:13: error: redefinition of 'clk_get'
> include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
> arch/mips/ar7/clock.c:454:6: error: redefinition of 'clk_put'
> include/linux/clk.h:291:20: note: previous definition of 'clk_put' was here
> make[2]: *** [arch/mips/ar7/clock.o] Error 1
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

Hi Yoichi,

I had to apply the same fix to mips/lantiq/ to make it work.

for the whole series :
Reviewed-by: John Crispin <blogic@openwrt.org>

John
