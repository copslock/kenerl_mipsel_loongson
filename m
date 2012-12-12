Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 19:49:22 +0100 (CET)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:35404 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823690Ab2LLStREs9tN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 19:49:17 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 1C0B3A98;
        Wed, 12 Dec 2012 19:49:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id bpiphb2w9jGz; Wed, 12 Dec 2012 19:49:10 +0100 (CET)
Received: from [192.168.178.21] (ppp-188-174-172-163.dynamic.mnet-online.de [188.174.172.163])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 425A6A97;
        Wed, 12 Dec 2012 19:49:09 +0100 (CET)
Message-ID: <50C8D1D4.5050200@metafoo.de>
Date:   Wed, 12 Dec 2012 19:49:56 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
MIME-Version: 1.0
To:     "Hill, Steven" <sjhill@mips.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
References: <1354858280-29576-1-git-send-email-sjhill@mips.com>,<50C89870.5000704@metafoo.de> <31E06A9FC96CEC488B43B19E2957C1B801146AA779@exchdb03.mips.com>
In-Reply-To: <31E06A9FC96CEC488B43B19E2957C1B801146AA779@exchdb03.mips.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35272
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

On 12/12/2012 05:44 PM, Hill, Steven wrote:
> Lars,
> 
> This patch was requested by our DSP/Codec group to help with selecting the best user-space codecs at runtime. Simply reading /proc/cpuinfo was insufficient. I posted this patch more for feedback and interest with minimal expectations that it would make it upstream. This patch will always be in our supported branches, but I will defer to everyone else on its worth for upstream.
> 
> -Steve

Well if it is something that is useful it makes sense to upstream it,
especially if you are developing applications. Many people before you have
learned the hard way that stashing stuff away in their private branches was not
the best idea. If you are smart you are going to avoid that.

It may not be the best solution though to just dump all the cp register to
userspace. As Florian suggested there might be a smarter way to solve this.

- Lars
