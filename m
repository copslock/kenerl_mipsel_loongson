Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 22:48:13 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:46265 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007274AbbBYVsKiyW3V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 22:48:10 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 9CFD81538A; Wed, 25 Feb 2015 21:48:04 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
Subject: Re: 4.0-rc1 breakage in FPE?
References: <20150225182048.GC31062@paulmartin.codethink.co.uk>
        <yw1xh9u97k5c.fsf@unicorn.mansr.com> <54EE4134.2050501@gmail.com>
Date:   Wed, 25 Feb 2015 21:48:04 +0000
In-Reply-To: <54EE4134.2050501@gmail.com> (David Daney's message of "Wed, 25
        Feb 2015 13:40:04 -0800")
Message-ID: <yw1xd24x7je3.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

David Daney <ddaney.cavm@gmail.com> writes:

> On 02/25/2015 01:31 PM, Måns Rullgård wrote:
>> Paul Martin <paul.martin@codethink.co.uk> writes:
>>
>>> Some change between 3.19 and 4.0-rc1 has broken the FPE such that some
>>> code running on an Octeon II is subtly not working.
>>>
>
> Can you say where your userspace comes from, so we can try to
> reproduce the issue?
>
>>> eg.
>>>
>>>    $ echo "1 2" | gawk '{ print $1 }'
>>>    1 2
>>>
>>> which should output (and does output on 3.19)
>>>
>>>    $ echo "1 2" | gawk '{ print $1 }'
>>>    1
>>>
>>> I'm going to try bisecting this over the next few days.
>>
>> Are you running a 32-bit userland?  If so, enabling
>> MIPS_O32_FP64_SUPPORT should fix this.
>
> ??
>
> 32-bit userland (Debian for instance) typically shouldn't need special
> "Exprimental" config options enabled.

Indeed, it should not.  Someone made a mistake.

> If we can identify the offending patch, we should revert it.

The offending patch is 46490b57 "MIPS: kernel: elf: Improve the overall
ABI and FPU mode checks"

There is no need for a full revert.  This is enough to make things work:

diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index d2c09f6..57f0353 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -148,9 +148,6 @@ int arch_check_elf(void *_ehdr, bool has_interpreter,
 	struct mode_req prog_req, interp_req;
 	int fp_abi, interp_fp_abi, abi0, abi1, max_abi;
 
-	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
-		return 0;
-
 	fp_abi = get_fp_abi(state->fp_abi);
 
 	if (has_interpreter) {
@@ -245,9 +242,6 @@ void mips_set_personality_fp(struct arch_elf_state *state)
 	 * not be worried about N32/N64 binaries.
 	 */
 
-	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
-		return;
-
 	switch (state->overall_fp_mode) {
 	case FP_FRE:
 		set_thread_fp_mode(1, 0);

-- 
Måns Rullgård
mans@mansr.com
