Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2012 22:27:40 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57942 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903298Ab2IBU1e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2012 22:27:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id E0231FBE;
        Sun,  2 Sep 2012 22:27:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Ho4kJNmqDFy1; Sun,  2 Sep 2012 22:27:28 +0200 (CEST)
Received: from [192.168.178.21] (ppp-88-217-76-199.dynamic.mnet-online.de [88.217.76.199])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id BE907FBD;
        Sun,  2 Sep 2012 22:27:27 +0200 (CEST)
Message-ID: <5043C139.2010700@metafoo.de>
Date:   Sun, 02 Sep 2012 22:27:37 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120724 Icedove/3.0.11
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH 2/3] MIPS: JZ4740: Export timer API
References: <1346579550-5990-1-git-send-email-thierry.reding@avionic-design.de> <1346579550-5990-3-git-send-email-thierry.reding@avionic-design.de> <50437117.8000700@metafoo.de> <20120902202124.GA21635@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120902202124.GA21635@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34408
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

On 09/02/2012 10:21 PM, Thierry Reding wrote:
> On Sun, Sep 02, 2012 at 04:45:43PM +0200, Lars-Peter Clausen wrote:
>> On 09/02/2012 11:52 AM, Thierry Reding wrote:
>>> This is a prerequisite for allowing the PWM driver to be converted to
>>> the PWM framework.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>
>> I'd prefer to keep the timer functions inline, some of them are called quite
>> often in the system clock code.
> 
> I've opted for this variant because it better hides the register values.
> If the functions are inlined it also means the complete register
> definitions need to go into timer.h. If you don't think that's an issue,
> I can update the patch accordingly.
> 

It's not pretty, but it should be ok. Having a single global function for each
and every register access is kind of ugly too.

- Lars
