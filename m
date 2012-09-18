Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2012 13:57:26 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58859 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903421Ab2IRL5P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2012 13:57:15 +0200
Received: by obbta17 with SMTP id ta17so10782819obb.36
        for <multiple recipients>; Tue, 18 Sep 2012 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0OEpOmu3yaVExx2aeDaMuVbQmZgW01kxQlMbD+o6R+I=;
        b=DLhT8or5prEJ0TFmLrRE5aZP1YVb+OOuLGHgk5NzvxaVq/zQDN8Nh9sibm6fLzhSHl
         kiN8sVrKXDN2a85Y3jMFXaxMJsCRTFqJXL/dLwhkycHUo+W7FEwdQi8XC8b0FTeDFSGe
         ifKLJOK//YnVOh3Nd4uETNWwTAu9yAkZJHRdIwX5Q5NAd3Yx37JT2tfgk2fjd7LRGZes
         x+tP0/S/K/p+2n7icCDMd/ai7c7DBHzP6NYyAhIDE6Y8on1WvmzgHJZ2J2Mit/vNzpeT
         hjlSvv8Cqp8g+QIz7GlT50bvzdbDoAimq6nI69M3cCq14TrHbp14t4sc5D8TojGf1cv8
         omLg==
Received: by 10.182.119.72 with SMTP id ks8mr14894972obb.10.1347969429124;
 Tue, 18 Sep 2012 04:57:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.3.15 with HTTP; Tue, 18 Sep 2012 04:56:49 -0700 (PDT)
In-Reply-To: <50586059.4090407@mvista.com>
References: <1347960728-5884-1-git-send-email-jonas.gorski@gmail.com> <50586059.4090407@mvista.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 18 Sep 2012 13:56:49 +0200
Message-ID: <CAOiHx=nKmZHeqDo3CNYMW_xLN7A6=_WQde=Jv33Eka9bOow-Ag@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM63XX: properly handle mac address octet overflow
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 18 September 2012 13:51, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 18-09-2012 13:32, Jonas Gorski wrote:
>
>> While calculating the mac address the pointer for the current octet was
>> never reset back to the least significant one after being decremented
>> because of an octet overflow. This resulted in the code continuing to
>> increment at the current octet, potentially generating duplicate or
>> invalid mac addresses.
>
>
>> As a second issue the pointer was allowed to advance up to the most
>> significant octet, modifying the OUI, and potentially changing the type
>> of mac address.
>
>
>> Rewrite the code so it resets the pointer to the least significant
>> in each outer loop step, and bails out when the least significant octet
>> of the OUI is reached.
>
>
>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>> ---
>>   arch/mips/bcm63xx/boards/board_bcm963xx.c |   16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>
>
>> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c
>> b/arch/mips/bcm63xx/boards/board_bcm963xx.c
>> index ea4ea77..f0fcec6 100644
>> --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
>> +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
>> @@ -720,7 +720,7 @@ const char *board_get_name(void)
>>    */
>>   static int board_get_mac_address(u8 *mac)
>>   {
>> -       u8 *p;
>> +       u8 *oui;
>>         int count;
>>
>>         if (mac_addr_used >= nvram.mac_addr_count) {
>> @@ -729,21 +729,23 @@ static int board_get_mac_address(u8 *mac)
>>         }
>>
>>         memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
>> -       p = mac + ETH_ALEN - 1;
>> +       oui = mac + ETH_ALEN/2 - 1;
>>         count = mac_addr_used;
>>
>>         while (count--) {
>> +               p = mac + ETH_ALEN - 1;
>
>
>    But didn't you remove 'p' above? Did you compile this?

Argh. Yes, but the wrong version (my "user space" one to test it). Let
me try that again ... . Thanks for catching it.

Jonas
