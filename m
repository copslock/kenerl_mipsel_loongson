Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2011 19:48:29 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16461 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491763Ab1EERsZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 May 2011 19:48:25 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dc2e3190000>; Thu, 05 May 2011 10:49:13 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 5 May 2011 10:48:12 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 5 May 2011 10:48:12 -0700
Message-ID: <4DC2E2D6.1040502@caviumnetworks.com>
Date:   Thu, 05 May 2011 10:48:06 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/6] MIPS: Octeon: Use Device Tree.
References: <1304614949-30460-1-git-send-email-ddaney@caviumnetworks.com> <BANLkTi=emL85ROThAEz_RsVXL-oJsL6aAQ@mail.gmail.com>
In-Reply-To: <BANLkTi=emL85ROThAEz_RsVXL-oJsL6aAQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2011 17:48:12.0284 (UTC) FILETIME=[9A682BC0:01CC0B4C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/05/2011 10:40 AM, Grant Likely wrote:
> On Thu, May 5, 2011 at 11:02 AM, David Daney<ddaney@caviumnetworks.com>  wrote:
[...]
>>   drivers/of/libfdt/Makefile                         |    8 +
>
> Out of curiosity, how big are the compiled libfdt object files?
>

For my 64-bit mips64 kernel:

[ddaney@dd1 libfdt]$ mips64-linux-size *.o
    text	   data	    bss	    dec	    hex	filename
    7024	      0	      0	   7024	   1b70	built-in.o
    1792	      0	      0	   1792	    700	fdt.o
    4328	      0	      0	   4328	   10e8	fdt_ro.o
     904	      0	      0	    904	    388	fdt_wip.o


David Daney
