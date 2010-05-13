Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2010 22:24:47 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5255 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492088Ab0EMUYn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 May 2010 22:24:43 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bec60160000>; Thu, 13 May 2010 13:24:54 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 13 May 2010 13:24:16 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 13 May 2010 13:24:16 -0700
Message-ID: <4BEC5FEA.70101@caviumnetworks.com>
Date:   Thu, 13 May 2010 13:24:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     "Dezhong Diao (dediao)" <dediao@cisco.com>
CC:     linux-mips@linux-mips.org,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
        "Tony Colclough (colclot)" <colclot@cisco.com>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/2] The Device Tree Patch for MIPS
References: <7A9214B0DEB2074FBCA688B30B04400DC64936@XMB-RCD-208.cisco.com>
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400DC64936@XMB-RCD-208.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2010 20:24:16.0055 (UTC) FILETIME=[422D7C70:01CAF2DA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/13/2010 11:50 AM, Dezhong Diao (dediao) wrote:
>>> +/* which is compatible with the flattened device tree (FDT) */
>>> +#define cmd_line arcs_cmdline
>
>> What is this #define floating in space?
>
> The variable "cmd_line" is being used in generic code of device tree,
> most of platforms (ARM, POWERPC
> , etc) have its definition, but it isn't present in MIPS. Actually there
> is a variable "arcs_cmdline" to be used as the same purpose in MIPS,
> that is the reason "arcs_cmdline" is given a new name.
>

Really I was referring to the way the patch got horked up when you 
e-mailed it.  It was very difficult to understand what the intent was.

I have no problem using #define, just make sure it doesn't have other 
garbage preceding the '#'
