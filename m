Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 23:09:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15825 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab0JNVJw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 23:09:52 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb771c10001>; Thu, 14 Oct 2010 14:10:25 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 14:10:05 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 14 Oct 2010 14:10:05 -0700
Message-ID: <4CB7719D.9030405@caviumnetworks.com>
Date:   Thu, 14 Oct 2010 14:09:49 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org
CC:     benh@kernel.crashing.org, dediao@cisco.com,
        linux-mips@linux-mips.org, monstr@monstr.eu, dvomlehn@cisco.com,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 2/2 RFC] of/mips: Add device tree support to MIPS
References: <20101013064352.2743.80378.stgit@localhost6.localdomain6> <20101013064416.2743.42892.stgit@localhost6.localdomain6>
In-Reply-To: <20101013064416.2743.42892.stgit@localhost6.localdomain6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2010 21:10:05.0164 (UTC) FILETIME=[2C63BAC0:01CB6BE4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/12/2010 11:48 PM, Grant Likely wrote:
> From: Dezhong Diao<dediao@cisco.com>
>
> Add the ability to enable CONFIG_OF on the MIPS architecture.
>
> Signed-off-by: Dezhong Diao<dediao@cisco.com>
> [grant.likely@secretlab.ca: cleared out obsolete hooks,
> 	removed ARCH_HAS_DEVTREE_MEM from being manually selected,
> 	remove __init tags from header file]
> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
> Cc: linux-mips@linux-mips.org
> Cc: David Daney<ddaney@caviumnetworks.com>
> Cc: David VomLehn<dvomlehn@cisco.com>

As I mentioned in my reply to 1/2, this seems to work,


Tested-by: David Daney <ddaney@caviumnetworks.com>


> ---
>
> I've not tested this on anything, but I picked up the MIPS device tree
> patch written by Dezhong and updated it to match the changes in
> mainline.  I also half-heartedly tried to rebase the powertv support
> patch, didn't get very far due to the refactoring in
> arch/mips/powertv/memory.c
>
> Anyway, please take a look and give it a spin.  If it looks good, then
> I can add it into my -next branch.
>
> g.
>
[...]
