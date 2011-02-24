Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Feb 2011 03:22:53 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3459 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491820Ab1BXCWu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Feb 2011 03:22:50 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d65c12d0000>; Wed, 23 Feb 2011 18:23:41 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 23 Feb 2011 18:22:48 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 23 Feb 2011 18:22:48 -0800
Message-ID: <4D65C0F3.8030503@caviumnetworks.com>
Date:   Wed, 23 Feb 2011 18:22:43 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Gibson <david@gibson.dropbear.id.au>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/10] MIPS: Octeon: Add device tree source files.
References: <1298408274-20856-1-git-send-email-ddaney@caviumnetworks.com> <1298408274-20856-3-git-send-email-ddaney@caviumnetworks.com> <20110223000759.GA26300@yookeroo> <4D655AB6.80400@caviumnetworks.com> <20110223234923.GA4932@yookeroo> <4D65BB17.4060703@caviumnetworks.com> <20110224021440.GD26300@yookeroo>
In-Reply-To: <20110224021440.GD26300@yookeroo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2011 02:22:48.0534 (UTC) FILETIME=[BAC1C760:01CBD3C9]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/23/2011 06:14 PM, David Gibson wrote:
> On Wed, Feb 23, 2011 at 05:57:43PM -0800, David Daney wrote:
>> On 02/23/2011 03:49 PM, David Gibson wrote:
>>> On Wed, Feb 23, 2011 at 11:06:30AM -0800, David Daney wrote:
>>>> On 02/22/2011 04:07 PM, David Gibson wrote:
>>>>> On Tue, Feb 22, 2011 at 12:57:46PM -0800, David Daney wrote:
>>>>>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>>>>>> ---
>>>>>>   arch/mips/cavium-octeon/.gitignore      |    2 +
>>>>>>   arch/mips/cavium-octeon/Makefile        |   13 ++
>>>>>>   arch/mips/cavium-octeon/octeon_3xxx.dts |  314 +++++++++++++++++++++++++++++++
>>>>>>   arch/mips/cavium-octeon/octeon_68xx.dts |   99 ++++++++++
>>>>>>   4 files changed, 428 insertions(+), 0 deletions(-)
>>>>>>   create mode 100644 arch/mips/cavium-octeon/.gitignore
>>>>>>   create mode 100644 arch/mips/cavium-octeon/octeon_3xxx.dts
>>>>>>   create mode 100644 arch/mips/cavium-octeon/octeon_68xx.dts
>>>>>>
>>>>>> diff --git a/arch/mips/cavium-octeon/.gitignore b/arch/mips/cavium-octeon/.gitignore
>>>>>> new file mode 100644
>>>>>> index 0000000..39c9686
>>>>>> --- /dev/null
>>>>>> +++ b/arch/mips/cavium-octeon/.gitignore
>>>>>> @@ -0,0 +1,2 @@
>>>>>> +*.dtb.S
>>>>>
>>>>> .dtb.S?
>>>>
>>>> I think I have the correct .gitignore syntax.
>>>
>>> What I meant was, where are you generating .dtb.S files that you need
>>> to ignore them?
>>>
>>
>> They are a byproduct of $(call cmd,dtc).
>>
>> Normally make removes them automatically, but if you abort at just
>> the right time, they can be left around.
>>
>> If it is objectionable, I can just remove that .gitignore bit.
>
> No, if they're byproducts of cmd,dtc they should be there.  I'm just a
> bit baffled as to why cmd,dtc would produce such byproducts.  dtc
> itself will convert dts ->  dtb without any extraneous intermediate
> steps.
>

I misspoke.

$(call cmd,dtc) does indeed just do the direct conversion.  There are 
other rules in scripts/Makefile.lib that convert the .dtb into a .dtb.o 
file that generate the .dtb.S files.

David Daney
