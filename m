Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2011 18:49:47 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14631 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491773Ab1E0Qtl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2011 18:49:41 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ddfd6630000>; Fri, 27 May 2011 09:50:43 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 May 2011 09:49:39 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 May 2011 09:49:39 -0700
Message-ID: <4DDFD622.1000102@caviumnetworks.com>
Date:   Fri, 27 May 2011 09:49:38 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Gibson <david@gibson.dropbear.id.au>,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/6] of: Allow scripts/dtc/libfdt to be used from
 kernel code
References: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com> <1305930343-31259-2-git-send-email-ddaney@caviumnetworks.com> <20110521063345.GB14828@yookeroo.fritz.box> <4DDA8FBC.1090904@caviumnetworks.com> <20110527032402.GD7793@yookeroo.fritz.box>
In-Reply-To: <20110527032402.GD7793@yookeroo.fritz.box>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2011 16:49:39.0139 (UTC) FILETIME=[117F4930:01CC1C8E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/26/2011 08:24 PM, David Gibson wrote:
> On Mon, May 23, 2011 at 09:47:56AM -0700, David Daney wrote:
>> On 05/20/2011 11:33 PM, David Gibson wrote:
>>> On Fri, May 20, 2011 at 03:25:38PM -0700, David Daney wrote:
>>>> To use it you need to do this in your Kconfig:
>>>>
>>>> 	select LIBFDT
>>>>
>>>> And in the Makefile of the code using libfdt something like:
>>>>
>>>> ccflags-y := -include linux/libfdt_env.h -I$(src)/../../../scripts/dtc/libfdt
>>>>
>>>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>>>> ---
>>>>   drivers/of/Kconfig          |    3 +++
>>>>   drivers/of/Makefile         |    2 ++
>>>>   drivers/of/libfdt/Makefile  |    3 +++
>>>>   drivers/of/libfdt/fdt.c     |    2 ++
>>>>   drivers/of/libfdt/fdt_ro.c  |    2 ++
>>>>   drivers/of/libfdt/fdt_wip.c |    2 ++
>>>
>>> No fdt_sw.c or fdt_rw.c?
>>>
>>
>> I had no immediate need for them.  They could of course be added,
>> but that would potentially waste space.
>>
>> Let's see if I can make it into an archive library.
>
> That would be preferable.  It's more or less designed to work that way
> so that everything is available without using unnecessary space in the
> binary.
>

Well, I was looking at this some more:

Grant specifically requested that this go in drivers/of/libfdt, however 
I am fairly sure that building archive libraries there will require 
changes to the upper level Makefile infrastructure.

If I go back to lib/libfdt, like my first version, I can easily achieve 
archive library behavior, but then it is separated from from drivers/of.

Personally I am starting to like the lib/libfdt home more than 
drivers/of.  If Grant doesn't object, I think I will move it back there.

What do you think?

David Daney
