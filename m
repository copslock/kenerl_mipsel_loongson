Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 19:42:18 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4438 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491837Ab0JORmP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Oct 2010 19:42:15 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb892990000>; Fri, 15 Oct 2010 10:42:49 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 15 Oct 2010 10:42:29 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 15 Oct 2010 10:42:29 -0700
Message-ID: <4CB89275.8020502@caviumnetworks.com>
Date:   Fri, 15 Oct 2010 10:42:13 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        Warner Losh <imp@bsdimp.com>, prasun.kapoor@caviumnetworks.com,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
References: <4CB79D93.6090500@caviumnetworks.com> <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com> <20101014.191309.515504596.imp@bsdimp.com> <AANLkTi=dqMHa04=-+RjnxuPGL3ZsqNCiaxUPT0VpV6kC@mail.gmail.com> <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com>
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400D01B50901@XMB-RCD-208.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2010 17:42:29.0671 (UTC) FILETIME=[56C01370:01CB6C90]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/15/2010 10:30 AM, David VomLehn (dvomlehn) wrote:

> If this is really a question of needing to dynamically generate the
> device tree, then you have no choice. It's worth mentioning, though,
> that the device tree compiler (dtc) does have the ability to include
> files, making it easier to create and maintain device trees that are
> static but which share devices.

Some experimentation will be necessary.  We will have to patch in some
properties like the Ethernet MAC address as that is stored in a
separate eeprom.  Also some boards have pluggable I/O modules, so we
may not know at dtb generation time what is there.

David Daney


>> -----Original Message-----
>> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
>> mips.org] On Behalf Of Grant Likely
>> Sent: Thursday, October 14, 2010 6:29 PM
>> To: Warner Losh
>> Cc: ddaney@caviumnetworks.com; prasun.kapoor@caviumnetworks.com; linux-
>> mips@linux-mips.org; devicetree-discuss@lists.ozlabs.org
>> Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
>>
>> On Thu, Oct 14, 2010 at 7:13 PM, Warner Losh<imp@bsdimp.com>  wrote:
>>> In message:<AANLkTi=UM2p26JJMqv-
>> cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
>>>             Grant Likely<grant.likely@secretlab.ca>  writes:
>>> : Overall the plan makes sense, however I would suggest the
>> following.
>>> : instead of 'live' modifying the tree, another option is to carry a
>> set
>>> : of 'stock' device trees in the kernel; one per board.  Of course
>> this
>>> : assumes that your current ad-hoc code is keying on the specific
>> board.
>>> :  If it is interpreting data provided by the firmware, then your
>>> : suggestion of modifying a single stock tree probably makes more
>> sense,
>>> : or possibly a combination of the too.  In general you should avoid
>>> : live modification as much as possible.
>>>
>>> The one draw back on this is that there's lots of different "stock"
>>> boards that the Cavium Octeon SDK supports.  These will be difficult
>>> to drag along for every kernel.  And they'd be mostly the same to,
>>> which is why I think that David is suggesting the live modification
>>> thing...
>>
>> Okay.  Do what makes the most sense for your platform.
>>
>> g.
>
>
