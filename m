Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 10:29:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47531 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011002AbbASJ3ezgG6z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 10:29:34 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 479B0F530734C;
        Mon, 19 Jan 2015 09:29:25 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 09:29:27 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Mon, 19 Jan 2015 09:29:26 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <Paul.Burton@imgtec.com>,
        "Maciej W. Rozycki (macro@linux-mips.org)" <macro@linux-mips.org>
Subject: RE: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI
 and FPU mode checks
Thread-Topic: [PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall
 ABI and FPU mode checks
Thread-Index: AQHQMXrA9oeMJlZFEEijQwuHHAdWD5zHL64g
Date:   Mon, 19 Jan 2015 09:29:24 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FAAEED@LEMAIL01.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-69-git-send-email-markos.chandras@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

> The previous implementation did not cover all possible FPU combinations
> and it silently allowed ABI incompatible objects to be loaded with the
> wrong ABI. For example, the previous logic would set the FP_64 ABI as
> the matching ABI for an FP_XX object combined with an FP_64A object.
> This was wrong, and the matching ABI should have been FP_64A.
> The previous logic is now replaced with a new one which determines
> the appropriate FPU mode to be used rather than the FP ABI. This has
> the advantage that the entire logic is much simpler since it is the FPU
> mode we are interested in rather than the FP ABI resulting to code
> simplifications.

Markos,

Can you confirm that the o32 abiflags testsuite has been run on a 64-bit
kernel? I know that the o32 testsuite has run on a 32-bit kernel and the
n64 testsuite has run on a 64-bit kernel. It is certainly worth checking
given the fixes that are being made to 3.19.

Is it worth updating the CONFIG_MIPS_O32_FP64_SUPPORT option to no longer
be experimental and also default on? This option could then guard the new
logic from this patch as a safety measure. Once the code has been proven
I'd suggest removing the option and making the code unconditional.

Maciej: The comments you made here http://patchwork.linux-mips.org/patch/8932/
should be addressed by this patch. 

Thanks,
Matthew
