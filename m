Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 19:54:30 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:37798 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903302Ab2IKRyX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 19:54:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 9C19984E;
        Tue, 11 Sep 2012 19:54:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id z+VbseKDISjf; Tue, 11 Sep 2012 19:54:16 +0200 (CEST)
Received: from [192.168.178.21] (ppp-188-174-8-103.dynamic.mnet-online.de [188.174.8.103])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 4259184B;
        Tue, 11 Sep 2012 19:54:04 +0200 (CEST)
Message-ID: <504F7AC8.6070405@metafoo.de>
Date:   Tue, 11 Sep 2012 19:54:16 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120724 Icedove/3.0.11
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH v2 3/3] pwm: Add Ingenic JZ4740 support
References: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de> <1347278719-15276-4-git-send-email-thierry.reding@avionic-design.de> <504E60F4.9010309@metafoo.de> <20120911050211.GA23771@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120911050211.GA23771@avionic-0098.mockup.avionic-design.de>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 09/11/2012 07:02 AM, Thierry Reding wrote:
> On Mon, Sep 10, 2012 at 11:51:48PM +0200, Lars-Peter Clausen wrote:
>> On 09/10/2012 02:05 PM, Thierry Reding wrote:
>>> This commit moves the driver to drivers/pwm and converts it to the new
>>> PWM framework.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>
>> Seems to work, thanks a lot. This one and patch 2:
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>> Tested-by: Lars-Peter Clausen <lars@metafoo.de>
>>
>> But I noticed a different problem. Some drivers using the pwm API depend on
>> HAVE_PWM (e.g. the pwm beeper driver), but the generic PWM framework does not
>> select HAVE_PWM, so I couldn't select the pwm beeper driver. Imo the generic
>> PWM framework should select HAVE_PWM
> 
> Does it also work if you add || PWM to the PWM beeper driver's depends?

Should work, but to select HAVE_PWM would in my opinion have been cleaner. But
since the custom implementations of the PWM API should be gone soon anyway it
probably does not matter that much.

- Lars
