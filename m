Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 17:50:24 +0200 (CEST)
Received: from mail.active-venture.com ([67.228.131.205]:58329 "EHLO
        mail.active-venture.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822308Ab3HHPuTUrvKj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 17:50:19 +0200
Received: (qmail 34851 invoked by uid 399); 8 Aug 2013 15:50:08 -0000
Received: from unknown (HELO server.roeck-us.net) (linux@roeck-us.net@108.223.40.66)
  by mail.active-venture.com with ESMTPAM; 8 Aug 2013 15:50:08 -0000
X-Originating-IP: 108.223.40.66
X-Sender: linux@roeck-us.net
Message-ID: <5203BE38.9020902@roeck-us.net>
Date:   Thu, 08 Aug 2013 08:50:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/2] DT: Add documentation for ralink-wdt
References: <1375954919-30737-1-git-send-email-blogic@openwrt.org> <5203923B.7030304@roeck-us.net> <52039551.9090006@openwrt.org>
In-Reply-To: <52039551.9090006@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 08/08/2013 05:55 AM, John Crispin wrote:
> On 08/08/13 14:42, Guenter Roeck wrote:
>> On 08/08/2013 02:41 AM, John Crispin wrote:
>>> Describe ralink-wdt binding.
>>>
>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>> Cc: linux-watchdog@vger.kernel.org
>>> Cc: linux-mips@linux-mips.org
>>> Cc: devicetree@vger.kernel.org
>>> ---
>>> V1 used the old devicetree list as Cc.
>>>
>>>   .../devicetree/bindings/watchdog/ralink-wdt.txt     |   19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
>>> new file mode 100644
>>> index 0000000..a70f0e8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
>>> @@ -0,0 +1,19 @@
>>> +Ralink Watchdog Timers
>>> +
>>> +Required properties :
>>> +- compatible: must be "ralink,rt2880-wdt"
>>> +- reg: physical base address of the controller and length of the register range
>>> +
>>> +Optional properties :
>>> +- interrupt-parent: phandle to the INTC device node
>>> +- interrupts : Specify the INTC interrupt number
>>> +
>>> +Example:
>>> +
>>> +    watchdog@120 {
>>> +        compatible = "ralink,mt7620a-wdt", "ralink,rt2880-wdt";
>>
>> Just wondering ... what is the "ralink,mt7620a-wdt" supposed to be used for ?
>
> Hi
>
> i copied the example from the dtsi file of the mt7620a SoC. i can remove it if you like.
>

Unless I am missing something, it is not a valid binding for this driver/device, so it should be removed.

Guenter
