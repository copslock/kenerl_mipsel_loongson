Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2012 01:39:58 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:57771 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903269Ab2H3Xjx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Aug 2012 01:39:53 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 43C73625C;
        Thu, 30 Aug 2012 17:47:16 -0600 (MDT)
Received: from springbank2.nvidia.com (unknown [38.96.16.75])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 71C1BE40E5;
        Thu, 30 Aug 2012 17:39:44 -0600 (MDT)
Message-ID: <503FF9E9.4020701@wwwdotorg.org>
Date:   Thu, 30 Aug 2012 16:40:25 -0700
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@arm.linux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] clk: Make the generic clock API available by default
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com> <503E8E6E.1010101@wwwdotorg.org> <20120830171918.GE4356@opensource.wolfsonmicro.com>
In-Reply-To: <20120830171918.GE4356@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 08/30/12 10:19, Mark Brown wrote:
> On Wed, Aug 29, 2012 at 02:49:34PM -0700, Stephen Warren wrote:
>> On 08/28/12 13:35, Mark Brown wrote:
>
>>> @@ -674,6 +676,7 @@ config ARCH_TEGRA
>>>   	select GENERIC_CLOCKEVENTS
>>>   	select GENERIC_GPIO
>>>   	select HAVE_CLK
>>> +	select HAVE_CUSTOM_CLK
>
>> For 3.7, Tegra will switch to the common clock framework. I think
>> this patch would then disable that. How should we resolve this -
>> rebase the Tegra common-clk tree on top of any branch containing
>> this patch in order to remove that select statement?
>
> I'd expect this to be applied on a separate branch so you should be able
> to rebase your conversion on top of it or merge it into your branch
> which should deal with things well enough I think?

That should work.
