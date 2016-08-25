Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 00:26:30 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:35611 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992249AbcHYW0Xsyq0J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 00:26:23 +0200
Received: by mail-it0-f66.google.com with SMTP id f6so7432845ith.2
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2016 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=5xbKPLUMERsKmJO0x/vsKt958ekqX7MCVncb5XyOEcw=;
        b=cIj4J1mKkUplUXijMVjK5OABNrh5nN17kCtYDbbiduA2hez6OdwOQ1xdRAZ/ZEvSQ6
         aqZxn+KZ2lsfC4qdlhx+chrkg3MSIX5J3FcEyGILxcqOa+IiUX6scrr+ot87+6b/fRum
         lcoTYF2t400Qoa83LIQvkLpJwgIi6WHuZRFZo2/btYpLlCte3bSZl9bA8a0QBIKzD4vc
         Hk69GWO/JuxJgUrA6bFsi//x9cN+DY6pUa4FhGalzme/+WJUd0aLLxRNpCdEIr6y4w5V
         HCuYnaMznrfTG6Cn7Ae48dTwfAlnWLldneqw5lQxU1kdHQjNDK1ZdxhugyAulm4H/eqd
         A73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=5xbKPLUMERsKmJO0x/vsKt958ekqX7MCVncb5XyOEcw=;
        b=Ica7tsrwT3KkSlcN/PibQWiaXsLoFHDrEQ7xdAfj2j0hILwrwpyannH8KGeGeC44DE
         C3h5foGjeNBcTSJOQLE7zkHmCrTswtiUg/3TmswydexS5A6ISj6gWr4t9Ogt7lO53fry
         ndmU2PcYupHEqSwBa+StJdMc7dlnByNlss8KVipczvjZci75Cm/9o75D9sE9UTnpuMNV
         w3rmuzXtz22LYbRypm3nZ1aLtMLoXotFpzFjhtoHa1PEVy2+Ecac0GUJZ3VVhkbm0fKR
         GV3PJEPr7rEkQOijGzmPhf4MHAaW8ShzAkX4ZXBEV7NrJuTTF8dbSFQA5EUgfGZBfX49
         eK7w==
X-Gm-Message-State: AEkoousjEdz2B9XtbFp31eEnzZIlrOnQavZWBTbHDuZ/5qUUA9P2jovCyjJMqnISt/Wbdg==
X-Received: by 10.36.249.5 with SMTP id l5mr8182525ith.46.1472163977247;
        Thu, 25 Aug 2016 15:26:17 -0700 (PDT)
Received: from dl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id i4sm30543itf.0.2016.08.25.15.26.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 15:26:16 -0700 (PDT)
Message-ID: <57BF7086.1020401@gmail.com>
Date:   Thu, 25 Aug 2016 15:26:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        linux-mips <linux-mips@linux-mips.org>,
        driverdev-devel <devel@driverdev.osuosl.org>,
        netdev <netdev@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Improving OCTEON II 10G Ethernet performance
References: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com> <57BF21C7.5070709@caviumnetworks.com> <20160825182210.GE12169@raspberrypi.musicnaut.iki.fi> <57BF5101.6080909@caviumnetworks.com> <20160825211852.GG12169@raspberrypi.musicnaut.iki.fi>
In-Reply-To: <20160825211852.GG12169@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/25/2016 02:18 PM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Aug 25, 2016 at 01:11:45PM -0700, David Daney wrote:
>> On 08/25/2016 11:22 AM, Aaro Koskinen wrote:
>>> On Thu, Aug 25, 2016 at 09:50:15AM -0700, David Daney wrote:
>>>> Ideally we would configure the packet classifiers on the RX side to create
>>>> multiple RX queues based on a hash of the TCP 5-tuple, and handle each queue
>>>> with a single NAPI instance.  That should result in better performance while
>>>> maintaining packet ordering.
>>>
>>> Would this need anything else than reprogramming CVMX_PIP_PRT_TAGX, and
>>> eliminating the global pow_receive_group and creating multiple NAPI instances
>>> and registering IRQ handlers?
>>
>> That is essentially how it works.  Set the tag generation parameters, and
>> use the low order bits of the tag to select which POW/SSO group is assigned.
>> The SSO group corresponds to an "rx queue"
>
> OK, I will try to experiment with this. Even though my home routers are
> 2-core only I could still create more queues and verify that the traffic
> gets distributed by checking the counters...
>

You will have to set proper SSO group masks, etc. when you do the get 
work operation, and who knows what else.

Good Luck!

>>> In the Yocto tree, the CVMX_PIP_PRT_TAGX register values are actually
>>> documented:
>>>
>>> http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/tree/arch/mips/include/asm/octeon/cvmx-pip-defs.h?h=apaliwal/octeon#n3737
>>
>> Wow, I didn't realize that documentation was made public.
>
> Also D-Link and Qbiquity GPL source offerings for their products usually
> include documentation for register fields. Only in mainline kernel they
> are missing.
>

The desires of the Lawyers foiled again by the requirements of the GPL.

> A.
>
