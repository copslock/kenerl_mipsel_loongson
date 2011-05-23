Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2011 18:48:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18595 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491139Ab1EWQsC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2011 18:48:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dda8ffc0000>; Mon, 23 May 2011 09:49:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 23 May 2011 09:47:56 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 23 May 2011 09:47:56 -0700
Message-ID: <4DDA8FBC.1090904@caviumnetworks.com>
Date:   Mon, 23 May 2011 09:47:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Gibson <david@gibson.dropbear.id.au>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/6] of: Allow scripts/dtc/libfdt to be used from
 kernel code
References: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com> <1305930343-31259-2-git-send-email-ddaney@caviumnetworks.com> <20110521063345.GB14828@yookeroo.fritz.box>
In-Reply-To: <20110521063345.GB14828@yookeroo.fritz.box>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2011 16:47:56.0860 (UTC) FILETIME=[2AE1BFC0:01CC1969]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/20/2011 11:33 PM, David Gibson wrote:
> On Fri, May 20, 2011 at 03:25:38PM -0700, David Daney wrote:
>> To use it you need to do this in your Kconfig:
>>
>> 	select LIBFDT
>>
>> And in the Makefile of the code using libfdt something like:
>>
>> ccflags-y := -include linux/libfdt_env.h -I$(src)/../../../scripts/dtc/libfdt
>>
>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>> ---
>>   drivers/of/Kconfig          |    3 +++
>>   drivers/of/Makefile         |    2 ++
>>   drivers/of/libfdt/Makefile  |    3 +++
>>   drivers/of/libfdt/fdt.c     |    2 ++
>>   drivers/of/libfdt/fdt_ro.c  |    2 ++
>>   drivers/of/libfdt/fdt_wip.c |    2 ++
>
> No fdt_sw.c or fdt_rw.c?
>

I had no immediate need for them.  They could of course be added, but 
that would potentially waste space.

Let's see if I can make it into an archive library.

David Daney

>>   include/linux/libfdt.h      |    8 ++++++++
>>   include/linux/libfdt_env.h  |   13 +++++++++++++
>>   8 files changed, 35 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/of/libfdt/Makefile
>>   create mode 100644 drivers/of/libfdt/fdt.c
>>   create mode 100644 drivers/of/libfdt/fdt_ro.c
>
