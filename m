Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 10:26:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10172 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007354AbbFEI05fsFeO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 10:26:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C6C9786870881;
        Fri,  5 Jun 2015 09:26:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 5 Jun 2015 09:26:51 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 5 Jun
 2015 09:26:51 +0100
Message-ID: <55715D4B.9020703@imgtec.com>
Date:   Fri, 5 Jun 2015 09:26:51 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Alexei Starovoitov <ast@plumgrid.com>, <linux-mips@linux-mips.org>
CC:     <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Daniel Borkmann" <dborkman@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] MIPS/BPF fixes for 4.3
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com> <557081A6.5010407@plumgrid.com>
In-Reply-To: <557081A6.5010407@plumgrid.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47875
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

On 06/04/2015 05:49 PM, Alexei Starovoitov wrote:
> On 6/4/15 3:56 AM, Markos Chandras wrote:
>> Here are some fixes for MIPS/BPF. The first 5 patches do some cleanup
>> and lay the groundwork for the final one which introduces assembly
>> helpers
>> for MIPS and MIPS64. The goal is to speed up certain operations that do
>> not need to go through the common C functions. This also makes the
>> test_bpf
>> testsuite happy with all 60 tests passing. This is based in 4.1-rc6.
> 
> looks like these patches actually fix two real bugs, right?
> If so, I think you probably want them in 'net' tree ?

I was thinking to have them in the MIPS tree to be honest. The original
MIPS/BPF went via the MIPS tree as well. It also makes it easier for me
to work with Ralf on minor fixes, merge conflicts etc.

> 
> Different arch maintainers take different stance towards bpf jit
> changes. x86, arm and s390 are ok with them going through Dave's trees,
> since often there are dependencies on bpf core parts.
> So please state clearly what tree you want these patches to go in.
> 
> btw, in the net-next tree bpf testsuite has 246 tests and the last
> ten are very stressful for JITs.

Interesting. Thanks. I will rebase my tree shortly after 4.2-rc1 then
and run the testsuite again. I will post a v2 if I spot more problems
with it.

-- 
markos
