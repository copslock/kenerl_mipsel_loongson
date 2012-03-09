Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 18:59:10 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4512 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903694Ab2CIR7F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2012 18:59:05 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f5a454e0000>; Fri, 09 Mar 2012 10:00:46 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 9 Mar 2012 09:59:02 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 9 Mar 2012 09:59:02 -0800
Message-ID: <4F5A44E5.6090300@cavium.com>
Date:   Fri, 09 Mar 2012 09:59:01 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] of: Make of_find_node_by_path() traverse /aliases
 for relative paths.
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com> <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com> <20120309013324.64DF53E0901@localhost>
In-Reply-To: <20120309013324.64DF53E0901@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2012 17:59:02.0350 (UTC) FILETIME=[4F851EE0:01CCFE1E]
X-archive-position: 32627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/08/2012 05:33 PM, Grant Likely wrote:
> On Wed, 29 Feb 2012 11:21:04 -0800, David Daney<ddaney.cavm@gmail.com>  wrote:
>> From: David Daney<david.daney@cavium.com>
>>
>> Currently all paths passed to of_find_node_by_path() must begin with a
>> '/', indicating a full path to the desired node.
>>
>> Augment the look-up code so that if a path does *not* begin with '/',
>> the path is used as the name of an /aliases property.  The value of
>> this alias is then used as the full node path to be found.
>>
>> Signed-off-by: David Daney<david.daney@cavium.com>
[...]
>
> All the aliases are already decoded at boot time now.  See
> of_alias_scan().  Instead of open-coding this, you can add an
> of_alias_lookup() function something like this (untested):
>

After objections from davem, and a bit of thought, I already indicated 
on a different branch of this thread that we should drop this patch.

I have improved my code so that it is no longer needed.

Thanks,
David Daney
