Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 01:53:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17808 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492265Ab0BKAx2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2010 01:53:28 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7355040000>; Wed, 10 Feb 2010 16:53:24 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 16:53:11 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 16:53:11 -0800
Message-ID: <4B7354F5.8080002@caviumnetworks.com>
Date:   Wed, 10 Feb 2010 16:53:09 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/6] MIPS Read Inhibit/eXecute Inhibit support (v2).
References: <4B733C71.8030304@caviumnetworks.com> <20100210235649.GA7975@linux-mips.org>
In-Reply-To: <20100210235649.GA7975@linux-mips.org>
Content-Type: multipart/mixed;
 boundary="------------020709000000020608050108"
X-OriginalArrivalTime: 11 Feb 2010 00:53:11.0401 (UTC) FILETIME=[9596E590:01CAAAB4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020709000000020608050108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2010 03:56 PM, Ralf Baechle wrote:
> On Wed, Feb 10, 2010 at 03:08:33PM -0800, David Daney wrote:
>
>> This patch set adds execute and read inhibit support.  By default glibc
>> based tool chains will create mappings for data areas of a program and
>> shared libraries with PROT_EXEC cleared.  With this patch applied, a
>> SIGSEGV is correctly sent if an attempt is made to execute from data
>> areas.
>>
>> The first three patch just make a few tweaks in preperation for the
>> main body of the patch in 4/6.  The last two turn on the feature for
>> some Octeon CPUs.
>>
>> I will reply with the six patches.
>>
>> David Daney (6):
>>    MIPS: Use 64-bit stores to c0_entrylo on 64-bit kernels.
>>    MIPS: Add accessor functions and bit definitions for c0_PageGrain
>>    MIPS: Add TLBR and ROTR to uasm.
>>    MIPS: Implement Read Inhibit/eXecute Inhibit
>>    MIPS: Give Octeon+ CPUs their own cputype.
>>    MIPS: Enable Read Inhibit/eXecute Inhibit for Octeon+ CPUs
>
> Hangs on IP27 after
>
> [...]
> Calibrating delay loop... 178.17 BogoMIPS (lpj=89088)
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
>
Try the attached patch.

David Daney

--------------020709000000020608050108
Content-Type: text/plain;
 name="rixi-ralf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rixi-ralf.patch"

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ec60bd5..5ea0af8 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -749,11 +749,11 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
 		UASM_i_ROTR(p, ptep, ptep, ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
 	} else {
-		UASM_i_SRL(p, tmp, tmp, 6); /* convert to entrylo0 */
+		UASM_i_SRL(p, tmp, tmp, ilog2(_PAGE_GLOBAL)); /* convert to entrylo0 */
 		if (r4k_250MHZhwbug())
 			UASM_i_MTC0(p, 0, C0_ENTRYLO0);
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0); /* load it */
-		UASM_i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
+		UASM_i_SRL(p, ptep, ptep, ilog2(_PAGE_GLOBAL)); /* convert to entrylo1 */
 		if (r45k_bvahwbug())
 			uasm_i_mfc0(p, tmp, C0_INDEX);
 	}

--------------020709000000020608050108--
