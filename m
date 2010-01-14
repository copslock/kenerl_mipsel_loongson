Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2010 18:25:51 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15198 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492250Ab0ANRZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2010 18:25:47 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b4f53820001>; Thu, 14 Jan 2010 09:25:27 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 14 Jan 2010 09:24:30 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 14 Jan 2010 09:24:30 -0800
Message-ID: <4B4F534B.5050007@caviumnetworks.com>
Date:   Thu, 14 Jan 2010 09:24:27 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/24] MAINTAINERS: Add "Q" patchwork entries
References: <cover.1263452908.git.joe@perches.com>
In-Reply-To: <cover.1263452908.git.joe@perches.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2010 17:24:30.0139 (UTC) FILETIME=[6E1D10B0:01CA953E]
X-archive-position: 25589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9381

Joe Perches wrote:
> Keep the patchwork site entries in MAINTAINERS
> 
> Joe Perches (24):
>   MAINTAINERS: Document new "Q:" patchwork queue type
>   MAINTAINERS: 9P FILE SYSTEM - Add "Q" patchwork entry
>   MAINTAINERS: ACPI - Add "Q" patchwork entry
>   MAINTAINERS: BTRFS FILE SYSTEM - Add "Q" patchwork entry
>   MAINTAINERS: CIFS - Add "Q" patchwork entry
>   MAINTAINERS: DEVICE-MAPPER - Add "Q" patchwork entry
>   MAINTAINERS: EXT4 FILE SYSTEM - Add "Q" patchwork entry
>   MAINTAINERS: IDE SUBSYSTEM - Add "Q" patchwork entry
>   MAINTAINERS: INFINIBAND SUBSYSTEM - Add "Q" patchwork entry
>   MAINTAINERS: INPUT DRIVERS - Add "Q" patchwork entry
>   MAINTAINERS: KCONFIG - Add "Q" patchwork entry
>   MAINTAINERS: LINUX FOR POWERPC - Add "Q" patchwork entry
>   MAINTAINERS: V4L/DVB - Add "Q" patchwork entry
>   MAINTAINERS: MTD - Add "Q" patchwork entry
>   MAINTAINERS: NETWORKING [WIRELESS] - Add "Q" patchwork entry
>   MAINTAINERS: OMAP - Add "Q" patchwork entry
>   MAINTAINERS: PARISC ARCHITECTURE - Add "Q" patchwork entry
>   MAINTAINERS: PCI SUBSYSTEM - Add "Q" patchwork entry
>   MAINTAINERS: REAL TIME CLOCK - Add "Q" patchwork entry
>   MAINTAINERS: TI DAVINCI - Add "Q" patchwork entry
>   MAINTAINERS: SPARC - Add "Q" patchwork entry
>   MAINTAINERS: SPI SUBSYSTEM - Add "Q" patchwork entry
>   MAINTAINERS: SUPERH - Add "Q" patchwork entry
>   MAINTAINERS: THE REST (LKML) - Add "Q" patchwork entry
> 
>  MAINTAINERS |   26 +++++++++++++++++++++++++-
>  1 files changed, 25 insertions(+), 1 deletions(-)
> 

I wonder if the MIPS patchwork site should also be included:

http://patchwork.linux-mips.org/project/linux-mips/list/


David Daney
