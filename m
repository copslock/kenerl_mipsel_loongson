Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 19:14:38 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16053 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab1EFROe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2011 19:14:34 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dc42cb50000>; Fri, 06 May 2011 10:15:33 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 6 May 2011 10:14:31 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 6 May 2011 10:14:31 -0700
Message-ID: <4DC42C72.1010306@caviumnetworks.com>
Date:   Fri, 06 May 2011 10:14:26 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Michal Marek <mmarek@suse.cz>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/6] of: Allow scripts/dtc/libfdt to be used from
 kernel code
References: <1304614949-30460-1-git-send-email-ddaney@caviumnetworks.com> <1304614949-30460-2-git-send-email-ddaney@caviumnetworks.com> <4DC3D3D5.6060007@suse.cz>
In-Reply-To: <4DC3D3D5.6060007@suse.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2011 17:14:31.0901 (UTC) FILETIME=[1093F0D0:01CC0C11]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/06/2011 03:56 AM, Michal Marek wrote:
> On 5.5.2011 19:02, David Daney wrote:
>> --- /dev/null
>> +++ b/drivers/of/libfdt/Makefile
>> @@ -0,0 +1,8 @@
>> +ccflags-y := -include linux/libfdt_env.h
>> -I$(src)/../../../scripts/dtc/libfdt
>> +
>> +obj-y = fdt.o fdt_wip.o fdt_ro.o
>> +
>> +
>> +$(obj)/%.o: $(src)/../../../scripts/dtc/libfdt/%.c FORCE
>> + $(call cmd,force_checksrc)
>> + $(call if_changed_rule,cc_o_c)
>
> It's just three source files, so you could use three one-line wrappers
> that #include ../../../scripts/dtc/libfdt/<file>.c instead of copying
> the %.c -> %.o rule here.
>

Good idea, that does seem cleaner.

I will adjust the patch.

David Daney
