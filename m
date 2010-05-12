Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 19:25:17 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13750 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492229Ab0ELRZN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 19:25:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4beae4890000>; Wed, 12 May 2010 10:25:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 12 May 2010 10:25:10 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 12 May 2010 10:25:10 -0700
Message-ID: <4BEAE476.9060606@caviumnetworks.com>
Date:   Wed, 12 May 2010 10:25:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     "Dezhong Diao (dediao)" <dediao@cisco.com>
CC:     linux-mips@linux-mips.org,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
        "Tony Colclough (colclot)" <colclot@cisco.com>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 2/2] The Device Tree Patch for MIPS
References: <7A9214B0DEB2074FBCA688B30B04400DC6413A@XMB-RCD-208.cisco.com>
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400DC6413A@XMB-RCD-208.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2010 17:25:10.0563 (UTC) FILETIME=[12F3C730:01CAF1F8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/10/2010 02:35 PM, Dezhong Diao (dediao) wrote:
> It is the machine-dependent code.
>

Missing 'Signed-off-by:'

The change log entry could be a bit more descriptive as well.

David Daney


> ---
>   arch/mips/configs/powertv_defconfig        |  174 +++++++++++++++------
>   arch/mips/include/asm/mach-powertv/asic.h  |    8 +-
>   arch/mips/include/asm/mach-powertv/mdesc.h |   51 ++++++
>   arch/mips/powertv/Makefile                 |    2 +-
>   arch/mips/powertv/asic/asic_devices.c      |   22 ---
>   arch/mips/powertv/mdesc.c                  |  224
[...]
