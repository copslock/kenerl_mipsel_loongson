Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 13:17:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50447 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011794AbbASMRf2TE00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 13:17:35 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0AFF224154A7B;
        Mon, 19 Jan 2015 12:17:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 12:17:29 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 19 Jan
 2015 12:17:27 +0000
Message-ID: <54BCF5D7.1020907@imgtec.com>
Date:   Mon, 19 Jan 2015 12:17:27 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        "Maciej W. Rozycki (macro@linux-mips.org)" <macro@linux-mips.org>
Subject: Re: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI
 and FPU mode checks
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235320FAAEED@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FAAEED@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/19/2015 09:29 AM, Matthew Fortune wrote:
>> The previous implementation did not cover all possible FPU combinations
>> and it silently allowed ABI incompatible objects to be loaded with the
>> wrong ABI. For example, the previous logic would set the FP_64 ABI as
>> the matching ABI for an FP_XX object combined with an FP_64A object.
>> This was wrong, and the matching ABI should have been FP_64A.
>> The previous logic is now replaced with a new one which determines
>> the appropriate FPU mode to be used rather than the FP ABI. This has
>> the advantage that the entire logic is much simpler since it is the FPU
>> mode we are interested in rather than the FP ABI resulting to code
>> simplifications.
> 
> Markos,
> 
> Can you confirm that the o32 abiflags testsuite has been run on a 64-bit
> kernel? I know that the o32 testsuite has run on a 32-bit kernel and the
> n64 testsuite has run on a 64-bit kernel. It is certainly worth checking
> given the fixes that are being made to 3.19.


They all pass with my R6 64-bit kernel + R6 userland + R2 O32 testsuite.

> 
> Is it worth updating the CONFIG_MIPS_O32_FP64_SUPPORT option to no longer
> be experimental and also default on? This option could then guard the new
> logic from this patch as a safety measure. Once the code has been proven
> I'd suggest removing the option and making the code unconditional.

Paul?

Initially thought of having 32-bit R6 select this symbol but then I
dropped it. But maybe it make sense now?

-- 
markos
