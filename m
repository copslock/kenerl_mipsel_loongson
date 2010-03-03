Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 18:37:28 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18061 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491942Ab0CCRhX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 18:37:23 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8e9e550000>; Wed, 03 Mar 2010 09:37:25 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 09:36:17 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 09:36:17 -0800
Message-ID: <4B8E9E0C.4050809@caviumnetworks.com>
Date:   Wed, 03 Mar 2010 09:36:12 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100225 Fedora/3.0.2-1.fc12 Thunderbird/3.0.2
MIME-Version: 1.0
To:     Maxim Uvarov <muvarov@gmail.com>
CC:     linux-mips@linux-mips.org, kexec@lists.infradead.org,
        horms@verge.net.au, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS kexec,kdump support
References: <20100303110527.11233.20400.stgit@muvarov>
In-Reply-To: <20100303110527.11233.20400.stgit@muvarov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2010 17:36:17.0245 (UTC) FILETIME=[0768E0D0:01CABAF8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/03/2010 03:05 AM, Maxim Uvarov wrote:
> Hello folks,
>
> Please find here MIPS crash and kdump patches.
> This is patch set of 3 patches:
> 1. generic MIPS changes (kernel);
> 2. MIPS Cavium Octeon board kexec/kdump code (kernel);
> 3. Kexec user space MIPS changes.
>
> Patches were tested on the latest linux-mips@ git kernel and the latest
> kexec-tools git on Cavium Octeon 50xx board.
>
> I also made the same code working on RMI XLR/XLS boards for both
> mips32 and mips64 kernels.
>
> Best regards,
> Maxim Uvarov.
>
>
> ---
>
>   arch/mips/Kconfig                  |   24 ++++++++++
[...]
>
>
> Signed-off-by: Maxim Uvarov<muvarov@gmail.com>
>

That Signed-off-by: needs to be just above the '---' not at the end.

David Daney
