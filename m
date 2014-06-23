Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 13:06:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1264 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817546AbaFWLGXGL4nl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 13:06:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5DD712FF58114;
        Mon, 23 Jun 2014 12:06:14 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 23 Jun
 2014 12:06:16 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 12:06:16 +0100
Received: from [192.168.154.28] (192.168.154.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 23 Jun
 2014 12:06:15 +0100
Message-ID: <53A80A27.5090503@imgtec.com>
Date:   Mon, 23 Jun 2014 12:06:15 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 14/17] MIPS: bpf: Prevent kernel fall over for >=32bit
 shifts
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com> <1403516340-22997-15-git-send-email-markos.chandras@imgtec.com> <063D6719AE5E284EB5DD2968C1650D6D1726096C@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1726096C@AcuExch.aculab.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40675
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

On 06/23/2014 10:44 AM, David Laight wrote:
> From: Markos Chandras
>> Remove BUG_ON() if the shift immediate is >=32 to avoid
>> kernel crashes due to malicious user input. Since the micro-assembler
>> will not allow an immediate greater or equal to 32, we will use the
>> maximum value which is 31. This will do the correct thing on either 32-
>> or 64-bit cores since no 64-bit instructions are being used in JIT.
> 
> I'm not sure that bounding the shift to 31 bits 'is the correct thing'.
> I'd have thought that emulating the large shift or masking the shift
> to 5 bits are equally 'correct'.
> 
> ...
Hi David,

Since we use 32-bit registers (or rather, we ignore the top 32bits on
MIPS64), shifting >= 32 will always result to 0.
Alexei suggested [1] to allow large shifts and emulate them, so this
patch aims to do that by treating >=32 shift values as 31. Please tell
me if I got this wrong.

[1] http://www.linux-mips.org/archives/linux-mips/2014-06/msg00212.html


-- 
markos
