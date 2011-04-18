Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2011 19:33:01 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3063 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493100Ab1DRRc4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2011 19:32:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dac76020001>; Mon, 18 Apr 2011 10:33:54 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Apr 2011 10:32:54 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 18 Apr 2011 10:32:54 -0700
Message-ID: <4DAC75C6.2060504@caviumnetworks.com>
Date:   Mon, 18 Apr 2011 10:32:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
In-Reply-To: <7aa38c32b7748a95e814e5bb0583f967@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2011 17:32:54.0540 (UTC) FILETIME=[A65DCCC0:01CBFDEE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/16/2011 09:44 AM, Kevin Cernekee wrote:
> Reuse more of the same definitions for the non-RIXI and RIXI cases.  This
> avoids having special cases for kernel_uses_smartmips_rixi cluttering up
> the pgtable*.h files.
>
> On hardware that does not support RI/XI, EntryLo bits 31:30 / 63:62 will
> remain unset and RI/XI permissions will not be enforced.
>
> Signed-off-by: Kevin Cernekee<cernekee@gmail.com>
> ---
>   arch/mips/include/asm/pgtable-bits.h |   23 ++++++++---------------
>   arch/mips/include/asm/pgtable.h      |   21 ++++++++-------------
>   arch/mips/mm/tlbex.c                 |   17 +++++------------
>   3 files changed, 21 insertions(+), 40 deletions(-)
>
[...]

I like this patch.

How much testing have you done on non-RI/XI CPUs?

David Daney
