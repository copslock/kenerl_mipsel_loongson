Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 05:27:36 +0200 (CEST)
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:36231 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006783AbbFDD1efHQ0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 05:27:34 +0200
Received: from resomta-ch2-05v.sys.comcast.net ([69.252.207.101])
        by resqmta-ch2-07v.sys.comcast.net with comcast
        id c3TT1q0052Bo0NV013TTP0; Thu, 04 Jun 2015 03:27:27 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-05v.sys.comcast.net with comcast
        id c3TS1q00L42s2jH013TTQz; Thu, 04 Jun 2015 03:27:27 +0000
Message-ID: <556FC593.1040203@gentoo.org>
Date:   Wed, 03 Jun 2015 23:27:15 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: R12000: Enable branch prediction global history
References: <556E2C6D.6070802@gentoo.org> <20150603082124.GH9839@linux-mips.org>
In-Reply-To: <20150603082124.GH9839@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433388447;
        bh=ArYSZH0YPDJftukQPSj868+N6u7jpscIbJgkGeiCCWQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=jUKxEBjjumNIHP4PMH7utWxaCGjH8O6NrzRUZ98FpQbpj7zW3kQAdg3r48Jzadrkw
         C/ZqTnkHQxxJJLMyjUGUld7Vn50WzBDyaf4h9t9otFkfntxNgg/qkThCtkiPN94eFO
         uTrCchlNGZ6c8tFBovbKQgriri7uCYkCEU5E/rQoFkrHHX/hwj3TZZNeMIr5ENDpYg
         VaU/PXq/cC0anPmii/0vIHEXtbjJ3Vlltg2KayIy7XBOZmj5TX3YXfnPbryu60NElp
         X8/0OAJ2rbX4qrNFvt/dq4Xkw/g7LDTl79YGNq/yGK/ck6h0E7azjWx0X+Q5Bi9Uy/
         6E4jOcPBVzYcA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/03/2015 04:21, Ralf Baechle wrote:
> On Tue, Jun 02, 2015 at 06:21:33PM -0400, Joshua Kinard wrote:
> 
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> The R12000 added a new feature to enhance branch prediction called
>> "global history".  Per the Vr10000 Series User Manual (U10278EJ4V0UM),
>> Coprocessor 0, Diagnostic Register (22):
>>
>> """
>> If bit 26 is set, branch prediction uses all eight bits of the global
>> history register.  If bit 26 is not set, then bits 25:23 specify a count
>> of the number of bits of global history to be used. Thus if bits 26:23
>> are all zero, global history is disabled.
>>
>> The global history contains a record of the taken/not-taken status of
>> recently executed branches, and when used is XOR'ed with the PC of a
>> branch being predicted to produce a hashed value for indexing the BPT.
>> Some programs with small "working set of conditional branches" benefit
>> significantly from the use of such hashing, some see slight performance
>> degradation.
>> """
>>
>> This patch enables global history on R12000 CPUs and up by setting bit
>> 26 in the branch prediction diagnostic register (CP0 $22) to '1'.  Bits
>> 25:23 are left alone so that all eight bits of the global history
>> register are available for branch prediction.
> 
> Will apply but could you also submit a patch to set cpu_has_bp_ghist to
> 0/1 as applicable in all cpu-feature-overrides.h?

I can, though at that point, the R10000 Kconfig item needs to be split to
differentiate between R10000 and R12000/R14000/R16000.  I sent a patch in to do
that a few weeks ago, but it was rejected.  Can you outline your specific
issues with it and I'll re-submit it, then the 'cpu_has_bp_ghist' define can be
'0' for R10000's and '1' for R12K-R16K?

That'll also set things up for the potential discovery of bits specific to
R14K/R16K that may be useful, but aren't known/understood just.


> Also the manual suggests this CPU feature may not always be neneficial
> for performance so I'm wondering if we should add a way to modify it
> at runtime.

I thought about this, too.  It'd also allow for R12K+ options to control the
Disable Branch Target Address Cache (BTAC, Bit 27) and the Disable Branch
Return Cache (Bit 22).  For global history, I just set Bit 26 so all of the
ghistory bits are available, but even this could become a Kconfig item to
control Bits 25:23.  Would probably require some benchmarking to see what the
effects of this are, but the entry in the manual suggests that the benefits
outweigh the penalties in the end.


> I'm curious, have you checked the default setting of the global history
> on kernel entry?

Yup, it's disabled by default:

[    0.000000] DEBUG: CPU0: c0_diag #1: 0x000400001030c000
[    0.000000] DEBUG: CPU0: c0_diag #2: 0x0004000014148000
[    7.798066] DEBUG: CPU1: c0_diag #1: 0x00000000103c8000
[    7.798092] DEBUG: CPU1: c0_diag #2: 0x0000000014144000


              I                     B     G       -BRC-   -----------BP----------
              T                     S   B H  H  D | | |   M  S                   
              L                     I   T I  I  B | | |   o  t         I         
              B                     d   A S  S  R | | | M d  a         d       O 
      0       M           0         x   C T  T  C V W H P e  t  **     x     0 p 
xxxxxxxxxxxx xxxx xxxxxxxxxxxxxxxx xxxx x x xxx x x x x x xx xx xx xxxxxxxxx x xx
---------------------------------------------------------------------------------
000000000000 0100 0000000000000000 0001 0 0 000 0 1 1 0 0 00 11 00 000000000 0 00  CPU0 Before
000000000000 0100 0000000000000000 0001 0 1 000 0 0 1 0 1 00 10 00 000000000 0 00  CPU0 After
000000000000 0000 0000000000000000 0001 0 0 000 0 1 1 1 1 00 10 00 000000000 0 00  CPU1 Before
000000000000 0000 0000000000000000 0001 0 1 000 0 0 1 0 1 00 01 00 000000000 0 00  CPU1 After
---------------------------------------------------------------------------------
     12       4          16         4   1 1  3  1 1 1 1 1 2  2  2      9     1 2

** R12000 and up: Upper-two bits of BP-Idx.


--J
