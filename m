Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2015 02:32:50 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35095 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012768AbbHHAcsKcEXk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Aug 2015 02:32:48 +0200
Received: by wibxm9 with SMTP id xm9so79016865wib.0
        for <linux-mips@linux-mips.org>; Fri, 07 Aug 2015 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=k/6m3tNMNdxpgGMNniBaEVBQ6N9hFoUYyOdn20+n7sI=;
        b=yru8bKETe5+qtzeTf2KboI4ew+6Ey/f4UAgKF4Yi0I51bQbZ1xv+9mN/aFmxGESe/s
         eNfvq7jwLA1l8secRtNWwhGhWBNtIhcJ8LMkvr91X5JufLr3LLz5/uvmVkJWReo8FQWp
         /Qm1sE7AV9ph+kgSHx12DfJw0ag6t+Ns8w6dbrnd5/Jme1dxX1xXnbFnonp2hv2W4sqH
         NKESD6CXyIxcCg93ytN1a/bKVydVZAFNVujqQBL2gKO8PNo+m2ZC3pcQN9AmGi6AtZpZ
         RywRN/L9LMDWZPdRiLVLuqw32YoGGUyz0hgziKcfGxx2YzpsgzwO3N+iWTC3HJdnWdRU
         vAxQ==
MIME-Version: 1.0
X-Received: by 10.194.250.69 with SMTP id za5mr20279906wjc.90.1438993962894;
 Fri, 07 Aug 2015 17:32:42 -0700 (PDT)
Received: by 10.27.157.65 with HTTP; Fri, 7 Aug 2015 17:32:42 -0700 (PDT)
In-Reply-To: <55C4F597.50103@caviumnetworks.com>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
        <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
        <20150807145414.GA5468@xora-haswell.xora.org.uk>
        <55C4F597.50103@caviumnetworks.com>
Date:   Sat, 8 Aug 2015 02:32:42 +0200
X-Google-Sender-Auth: UMGyuIkjP4sFFoYU17kDXIOgN7g
Message-ID: <CAJZ5v0hG8xUX9k7QD+vTR90_V+Rrvv3LqxLF966YCRk192zrzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
From:   "Rafael J. Wysocki" <rafael@kernel.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Graeme Gregory <gg@slimlogic.co.uk>,
        David Daney <ddaney.cavm@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Robert Richter <rrichter@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <rjwysocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rafael@kernel.org
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

Hi David,

On Fri, Aug 7, 2015 at 8:14 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 08/07/2015 07:54 AM, Graeme Gregory wrote:
>>
>> On Thu, Aug 06, 2015 at 05:33:10PM -0700, David Daney wrote:
>>>
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> Find out which PHYs belong to which BGX instance in the ACPI way.
>>>
>>> Set the MAC address of the device as provided by ACPI tables. This is
>>> similar to the implementation for devicetree in
>>> of_get_mac_address(). The table is searched for the device property
>>> entries "mac-address", "local-mac-address" and "address" in that
>>> order. The address is provided in a u64 variable and must contain a
>>> valid 6 bytes-len mac addr.
>>>
>>> Based on code from: Narinder Dhillon <ndhillon@cavium.com>
>>>                      Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>>                      Robert Richter <rrichter@cavium.com>
>>>
>>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>> Signed-off-by: Robert Richter <rrichter@cavium.com>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> ---
>>>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 137
>>> +++++++++++++++++++++-
>>>   1 file changed, 135 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>>> b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>>> index 615b2af..2056583 100644
>>> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>>> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>
> [...]
>>>
>>> +
>>> +static int acpi_get_mac_address(struct acpi_device *adev, u8 *dst)
>>> +{
>>> +       const union acpi_object *prop;
>>> +       u64 mac_val;
>>> +       u8 mac[ETH_ALEN];
>>> +       int i, j;
>>> +       int ret;
>>> +
>>> +       for (i = 0; i < ARRAY_SIZE(addr_propnames); i++) {
>>> +               ret = acpi_dev_get_property(adev, addr_propnames[i],
>>> +                                           ACPI_TYPE_INTEGER, &prop);
>>
>>
>> Shouldn't this be trying to use device_property_read_* API and making
>> the DT/ACPI path the same where possible?
>>
>
> Ideally, something like you suggest would be possible.  However, there are a
> couple of problems trying to do it in the kernel as it exists today:
>
> 1) There is no 'struct device *' here, so device_property_read_* is not
> applicable.
>
> 2) There is no standard ACPI binding for MAC addresses, so it is impossible
> to create a hypothetical fw_get_mac_address(), which would be analogous to
> of_get_mac_address().
>
> Other e-mail threads have suggested that the path to an elegant solution is
> to inter-mix a bunch of calls to acpi_dev_get_property*() and
> fwnode_property_read*() as to use these more generic fwnode_property_read*()
> functions whereever possible.  I rejected this approach as it seems cleaner
> to me to consistently use a single set of APIs.

Actually, that wasn't my intention.

I wanted to say that once you'd got an ACPI device pointer (struct
acpi_device), you could easly convert it to a struct fwnode_handle
pointer and operate that going forward when accessing properties.
That at least would help with the properties that do not differ
between DT and ACPI.

Thanks,
Rafael
