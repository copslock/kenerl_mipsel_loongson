Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2015 02:06:04 +0200 (CEST)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37537 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012768AbbHHAGAuYk2V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Aug 2015 02:06:00 +0200
Received: by wibhh20 with SMTP id hh20so84159805wib.0
        for <linux-mips@linux-mips.org>; Fri, 07 Aug 2015 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6UuOq/EZpZSQdLCFGgP2B9aORlGQ9Nx7zjty9jIThbE=;
        b=V7IOqZWaeeHvi3bn2B4eAbpmwo9iL7hhcSbNNt+Cn/Rs532bt9AK2aVQNfjUv+vTsC
         ETCQoH4I2ZIPzzXbFoNlaRbLIxZStcT0Z37r4eEpJ4e2JzmkqJHaTFQ4sgC/QZ9cIAq4
         oKPrEJ746EVgMjXjA+D+N95jNf7poEHbZkJslWT/NQwN9MenLBh+MSrR3coGuKaI0q4o
         t2c/jzUsPyctmUAiJbJ1jn6AJLLy/C/mwp7eGokcI7BshrmFbWxGmjAaEaLDejN2MVPh
         eO31KGqDPTwS2VqbnarOGZxS5kOYUhmMtACEQETaDjXrYSAAqBmF9vzlMeGTvgV+RxNI
         z/hw==
MIME-Version: 1.0
X-Received: by 10.194.52.105 with SMTP id s9mr20105236wjo.53.1438992355448;
 Fri, 07 Aug 2015 17:05:55 -0700 (PDT)
Received: by 10.27.157.65 with HTTP; Fri, 7 Aug 2015 17:05:55 -0700 (PDT)
In-Reply-To: <20150807175127.GB12013@leverpostej>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
        <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
        <20150807140106.GE7646@leverpostej>
        <55C4ECC6.7050908@caviumnetworks.com>
        <20150807175127.GB12013@leverpostej>
Date:   Sat, 8 Aug 2015 02:05:55 +0200
X-Google-Sender-Auth: BgaoFXdOr0JO8m1oLWIiyzGBogY
Message-ID: <CAJZ5v0gc=bo3ayO7aWq19Hh_205YC52wqXGbbM5vxR1atXm+oA@mail.gmail.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
From:   "Rafael J. Wysocki" <rafael@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "rob.herring@linaro.org" <rob.herring@linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Robert Richter <rrichter@cavium.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <deviectree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <rjwysocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48730
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

Hi Mark,

On Fri, Aug 7, 2015 at 7:51 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> [Correcting the devicetree list address, which I typo'd in my original
> reply]
>
>> >> +static const char * const addr_propnames[] = {
>> >> +  "mac-address",
>> >> +  "local-mac-address",
>> >> +  "address",
>> >> +};
>> >
>> > If these are going to be generally necessary, then we should get them
>> > adopted as standardised _DSD properties (ideally just one of them).
>>
>> As far as I can tell, and please correct me if I am wrong, ACPI-6.0
>> doesn't contemplate MAC addresses.
>>
>> Today we are using "mac-address", which is an Integer containing the MAC
>> address in its lowest order 48 bits in Little-Endian byte order.
>>
>> The hardware and ACPI tables are here today, and we would like to
>> support it.  If some future ACPI specification specifies a standard way
>> to do this, we will probably adapt the code to do this in a standard manner.
>>
>>
>> >
>> > [...]
>> >
>> >> +static acpi_status bgx_acpi_register_phy(acpi_handle handle,
>> >> +                                   u32 lvl, void *context, void **rv)
>> >> +{
>> >> +  struct acpi_reference_args args;
>> >> +  const union acpi_object *prop;
>> >> +  struct bgx *bgx = context;
>> >> +  struct acpi_device *adev;
>> >> +  struct device *phy_dev;
>> >> +  u32 phy_id;
>> >> +
>> >> +  if (acpi_bus_get_device(handle, &adev))
>> >> +          goto out;
>> >> +
>> >> +  SET_NETDEV_DEV(&bgx->lmac[bgx->lmac_count].netdev, &bgx->pdev->dev);
>> >> +
>> >> +  acpi_get_mac_address(adev, bgx->lmac[bgx->lmac_count].mac);
>> >> +
>> >> +  bgx->lmac[bgx->lmac_count].lmacid = bgx->lmac_count;
>> >> +
>> >> +  if (acpi_dev_get_property_reference(adev, "phy-handle", 0, &args))
>> >> +          goto out;
>> >> +
>> >> +  if (acpi_dev_get_property(args.adev, "phy-channel", ACPI_TYPE_INTEGER, &prop))
>> >> +          goto out;
>> >
>> > Likewise for any inter-device properties, so that we can actually handle
>> > them in a generic fashion, and avoid / learn from the mistakes we've
>> > already handled with DT.
>>
>> This is the fallacy of the ACPI is superior to DT argument.  The
>> specification of PHY topology and MAC addresses is well standardized in
>> DT, there is no question about what the proper way to specify it is.
>> Under ACPI, it is the Wild West, there is no specification, so each
>> system design is forced to invent something, and everybody comes up with
>> an incompatible implementation.
>
> Indeed.
>
> If ACPI is going to handle it, it should handle it properly. I really
> don't see the point in bodging properties together in a less standard
> manner than DT, especially for inter-device relationships.
>
> Doing so is painful for _everyone_, and it's extremely unlikely that
> other ACPI-aware OSs will actually support these custom descriptions,
> making this Linux-specific, and breaking the rationale for using ACPI in
> the first place -- a standard that says "just do non-standard stuff" is
> not a usable standard.
>
> For intra-device properties, we should standardise what we can, but
> vendor-specific stuff is ok -- this can be self-contained within a
> driver.
>
> For inter-device relationships ACPI _must_ gain a better model of
> componentised devices. It's simply unworkable otherwise, and as you
> point out it's fallacious to say that because ACPI is being used that
> something is magically industry standard, portable, etc.
>
> This is not your problem in particular; the entire handling of _DSD so
> far is a joke IMO.

It is actually useful to people as far as I can say.

Also, if somebody is going to use properties with ACPI, why whould
they use a different set of properties with DT?

Wouldn't it be more reasonable to use the same set in both cases?

Thanks,
Rafael
