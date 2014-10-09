Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 18:42:24 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52698 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010968AbaJIQmWYCfoC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Oct 2014 18:42:22 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 2858A280621;
        Thu,  9 Oct 2014 18:41:28 +0200 (CEST)
Received: from dicker-alter.lan (p548CBAD8.dip0.t-ipconnect.de [84.140.186.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu,  9 Oct 2014 18:41:28 +0200 (CEST)
Message-ID: <5436BAEA.4020702@openwrt.org>
Date:   Thu, 09 Oct 2014 18:42:18 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 08/10] MIPS: ralink: add rt2880 wmac clock
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org> <1412812385-64820-9-git-send-email-blogic@openwrt.org> <5436B5E1.4060201@cogentembedded.com>
In-Reply-To: <5436B5E1.4060201@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43153
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


On 09/10/2014 18:20, Sergei Shtylyov wrote:
> On 10/09/2014 03:53 AM, John Crispin wrote:
>
>> Register the wireleass mac clock on rt2880. This is required by the
>> wifi driver.
>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> ---
>>   arch/mips/ralink/rt288x.c |    3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>
>> diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
>> index f87de1a..90e8934 100644
>> --- a/arch/mips/ralink/rt288x.c
>> +++ b/arch/mips/ralink/rt288x.c
>> @@ -76,7 +76,7 @@ struct ralink_pinmux rt_gpio_pinmux = {
>>
>>   void __init ralink_clk_init(void)
>>   {
>> -    unsigned long cpu_rate;
>> +    unsigned long cpu_rate, wmac_rate = 40000000;
>
>    Why you need this variable at all?
in theory there can be a 20mhz clock. the code follows the same pattern
as the other SoCs. due to lack of datasheet do however not know how to
read the clock register. if you see this as a problem we can change it.
   
    John
