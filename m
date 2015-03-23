Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 15:07:30 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:10861 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008858AbbCWOH1T3RGD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 15:07:27 +0100
Received: from [80.240.102.213] (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Mon, 23 Mar
 2015 17:07:20 +0300
Message-ID: <55101D39.3080201@auriga.com>
Date:   Mon, 23 Mar 2015 17:03:37 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
CC:     Paul Martin <paul.martin@codethink.co.uk>
Subject: Re: [PATCH 2/3] MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
References: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com> <1426867920-7907-3-git-send-email-aleksey.makarov@auriga.com>
In-Reply-To: <1426867920-7907-3-git-send-email-aleksey.makarov@auriga.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> On Fri, Mar 20, 2015 at 07:11:57PM +0300, Aleksey Makarov wrote:
>> From: David Daney <david.daney@cavium.com>
>> 
>> Needed for little-endian ioport access.
>> This fixes NOR flash in little-endian mode
>> 
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> ---
>>  .../include/asm/mach-cavium-octeon/mangle-port.h   | 74 
>> ++++++++++++++++++++++
> 
> This seems to be a new header file that's not used anywhere else.

arch/mips/include/asm/io.h:#include <mangle-port.h>

Also note the compiler flags:

-I./arch/mips/include/asm/mach-cavium-octeon -I./arch/mips/include/asm/mach-generic 

> I get the feeling that there should be at least another three patches
> in this series which have been omitted.
> 
> Certainly, the Octeon peripherals won't work with just the three part
> patch set presented here.

With these patches the cn7000 board boots in little-endian mode with 
all peripherials supported on this board working fine.  The peripherials
on other boards should probably be fixed separately.

> PS. Don't forget the missing htons() in drivers/staging/octeon/ethernet-tx.c

Thanks.  A patch would be appreciated.

Thanks
Aleksey Makarov
