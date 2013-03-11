Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Mar 2013 11:14:06 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:52893 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824764Ab3CKKOFRncao (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Mar 2013 11:14:05 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UaNfhltkkx6p; Mon, 11 Mar 2013 11:13:39 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 73EFF2842E0;
        Mon, 11 Mar 2013 11:13:36 +0100 (CET)
Message-ID: <513DAE69.30207@openwrt.org>
Date:   Mon, 11 Mar 2013 11:14:01 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] pci: convert to devm_ioremap_resource()
References: <1362987753-6607-1-git-send-email-silviupopescu1990@gmail.com> <513DAB22.2060309@openwrt.org> <513DAAAA.1050003@phrozen.org>
In-Reply-To: <513DAAAA.1050003@phrozen.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-archive-position: 35865
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2013.03.11. 10:58 keltezéssel, John Crispin írta:
> On 11/03/13 11:00, Gabor Juhos wrote:
>> 2013.03.11. 8:42 keltezéssel, Silviu-Mihai Popescu írta:
>>> Convert all uses of devm_request_and_ioremap() to the newly introduced
>>> devm_ioremap_resource() which provides more consistent error handling.
>>>
>>> devm_ioremap_resource() provides its own error messages so all explicit
>>> error messages can be removed from the failure code paths.
>>>
>>> Signed-off-by: Silviu-Mihai Popescu<silviupopescu1990@gmail.com>
>>> ---
>>>   arch/mips/pci/pci-ar724x.c |   18 +++++++++---------
>>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> Acked-by: Gabor Juhos<juhosg@openwrt.org>
>>
>> Just a minor note, arch/mips/pci/pci-ar71xx.c should be fixed as well probably.
>>
>>
> 
> 
> Hi,
> 
> is this patch supposed to go upstream via linux-mips.org ?

Yes, IMHO.

-Gabor
