Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 22:34:38 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7364 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903790Ab2B2Vea (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Feb 2012 22:34:30 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f4e9a4b0000>; Wed, 29 Feb 2012 13:36:11 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 29 Feb 2012 13:34:27 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 29 Feb 2012 13:34:27 -0800
Message-ID: <4F4E99E2.2000607@cavium.com>
Date:   Wed, 29 Feb 2012 13:34:26 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>, grant.likely@secretlab.ca
CC:     ddaney.cavm@gmail.com, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        rob.herring@calxeda.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] of: Make of_find_node_by_path() traverse /aliases
 for relative paths.
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>   <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com> <20120229.153633.249570825230282737.davem@davemloft.net>
In-Reply-To: <20120229.153633.249570825230282737.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Feb 2012 21:34:27.0513 (UTC) FILETIME=[E9CCBA90:01CCF729]
X-archive-position: 32583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/29/2012 12:36 PM, David Miller wrote:
> From: David Daney<ddaney.cavm@gmail.com>
> Date: Wed, 29 Feb 2012 11:21:04 -0800
>
>> Currently all paths passed to of_find_node_by_path() must begin with a
>> '/', indicating a full path to the desired node.
>>
>> Augment the look-up code so that if a path does *not* begin with '/',
>> the path is used as the name of an /aliases property.  The value of
>> this alias is then used as the full node path to be found.
>>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>
> But as the caller you sure as hell know whether you have a "/"
> prefixed name or not.

Yes, worst case we could just examine the first character of the string.

>
> Why complicate an incredibly well designed and simple function for
> something you can create another interface for?
>

Because in this message:

http://www.linux-mips.org/archives/linux-mips/2011-02/msg00147.html

Grant explicitly asked me to do it this way when he said:

    of_find_node_by_path() needs to be fixed to also accept alias
    values so that a string that starts with a '/' is a full path, but
    no leading '/' means start with an alias.  This code will lose a
    level of indentation if you can make that change to the common
    code.

And then in follow ups to that conversation, we eventually came up
with this patch.

If you find it particularly objectionable, convince Grant to NACK the 
patch (but please keep me CCed on the conversation), and I will open 
code the equivalent in my drivers.

Thanks,
David Daney
