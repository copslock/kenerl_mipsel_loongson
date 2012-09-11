Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 19:56:27 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:38034 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903488Ab2IKR4X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 19:56:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 70E2985D;
        Tue, 11 Sep 2012 19:56:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gcJYvVfP6mTm; Tue, 11 Sep 2012 19:56:17 +0200 (CEST)
Received: from [192.168.178.21] (ppp-188-174-8-103.dynamic.mnet-online.de [188.174.8.103])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 4795785C;
        Tue, 11 Sep 2012 19:56:17 +0200 (CEST)
Message-ID: <504F7B4D.3030602@metafoo.de>
Date:   Tue, 11 Sep 2012 19:56:29 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120724 Icedove/3.0.11
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH v2 0/3] MIPS: JZ4740: Move PWM driver to PWM framework
References: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de> <504E0542.8020309@metafoo.de> <20120910173056.GA31611@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120910173056.GA31611@avionic-0098.mockup.avionic-design.de>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34474
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

On 09/10/2012 07:30 PM, Thierry Reding wrote:
> On Mon, Sep 10, 2012 at 05:20:34PM +0200, Lars-Peter Clausen wrote:
>> On 09/10/2012 02:05 PM, Thierry Reding wrote:
>>> Hi,
>>>
>>
>> [...]
> 
>> Patch 1 should go through the MIPS tree, but I still can't see why the issue
>> should occur nor does it happen for anybody else except for you. Instead of
>> moving the content over to the public irq.h I'd rather like to see the
>> private irq.h being renamed.
> 
> If we can solve this some other way I'm all for it. Maybe you can share
> the defconfig or .config that you use so I can test under the same
> conditions.
> 
> Thierry

This is the config I'm using:
http://projects.qi-hardware.com/index.php/p/qi-kernel/source/tree/jz-3.4/arch/mips/configs/qi_lb60_defconfig

- Lars
