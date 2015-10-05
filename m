Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 11:51:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29715 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009381AbbJEJvPhMgH5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 11:51:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D31EE77AD2F7C
        for <linux-mips@linux-mips.org>; Mon,  5 Oct 2015 10:51:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 5 Oct 2015 10:51:09 +0100
Received: from [192.168.154.83] (192.168.154.83) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 5 Oct
 2015 10:51:09 +0100
Subject: Re: [PATCH] MIPS: BPF: Disable JIT on R3000 (MIPS-I)
To:     <linux-mips@linux-mips.org>
References: <1441481368.15927.0.camel@decadent.org.uk>
 <20151005092440.GA1389@linux-mips.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <5612480C.2040006@imgtec.com>
Date:   Mon, 5 Oct 2015 10:51:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151005092440.GA1389@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.83]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49423
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

On 10/05/2015 10:24 AM, Ralf Baechle wrote:
> On Sat, Sep 05, 2015 at 08:29:28PM +0100, Ben Hutchings wrote:
> 
>> The JIT does not include the load delay slots required by MIPS-I
>> processors.
> 
> See 0c5d187828588dd1b36cb93b4481a8db467ef3e8 (MIPS: BPF: Fix load delay
> slots.) for a proper fix.

Since this patch didn't make it to the LMO and never discussed, i must
say that it's probably not complete. The bpf_jit.c code also emits load
instructions (for example see emit_load_imm). So I guess you need to
extend your patch to cover the C code as well.

-- 
markos
