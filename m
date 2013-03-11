Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Mar 2013 11:01:31 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:50035 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824764Ab3CKKB1C2cST (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Mar 2013 11:01:27 +0100
Message-ID: <513DAAAA.1050003@phrozen.org>
Date:   Mon, 11 Mar 2013 10:58:02 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] pci: convert to devm_ioremap_resource()
References: <1362987753-6607-1-git-send-email-silviupopescu1990@gmail.com> <513DAB22.2060309@openwrt.org>
In-Reply-To: <513DAB22.2060309@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35864
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

On 11/03/13 11:00, Gabor Juhos wrote:
> 2013.03.11. 8:42 keltezéssel, Silviu-Mihai Popescu írta:
>> Convert all uses of devm_request_and_ioremap() to the newly introduced
>> devm_ioremap_resource() which provides more consistent error handling.
>>
>> devm_ioremap_resource() provides its own error messages so all explicit
>> error messages can be removed from the failure code paths.
>>
>> Signed-off-by: Silviu-Mihai Popescu<silviupopescu1990@gmail.com>
>> ---
>>   arch/mips/pci/pci-ar724x.c |   18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> Acked-by: Gabor Juhos<juhosg@openwrt.org>
>
> Just a minor note, arch/mips/pci/pci-ar71xx.c should be fixed as well probably.
>
>


Hi,

is this patch supposed to go upstream via linux-mips.org ?

	John
