Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 19:37:39 +0200 (CEST)
Received: from mail.efficios.com ([IPv6:2607:5300:60:7898::beef]:59344 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993029AbeFORha3e1hJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 19:37:30 +0200
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B828622B412;
        Fri, 15 Jun 2018 13:37:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id qtk03QvMmmau; Fri, 15 Jun 2018 13:37:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 451D522B40F;
        Fri, 15 Jun 2018 13:37:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 451D522B40F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529084239;
        bh=EaDSR6aNKInsrOpzhKzh57NIKqnBCH6lcbQa6v9j4wE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Q75W1KEYx6wmlA9EWvFQAwg5NtevO8zTVCOuOYW58NOXzYY7YgpM9zj2vuBKxMfwc
         +lLh7x/bKq5E90uZ124cSpzcKU2Hmsu3XUdf3Cre/wP+SBGI5ZRqiYF2GKhCLYzKin
         zpOG3AepNgHpQ1nAwklV8Mupl+tWPqpLSQRgvFx/GITYMvBE3r1wirgoQUCTSB5tDN
         AkIKGi7iWPLhrx81ubm9YiRW6dj8kzgFH8ZhNYD53aWTyM4Sxj5YQdix5bXrVYGSxJ
         KgI1SXsOvm/IytpqK64u4g9rB2rn9yVSRIyRmPnv+AiU5wKoyBKUXu6/RMIoD4wLXB
         83XUA5hdhcl/Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id OmnmOT05UXnl; Fri, 15 Jun 2018 13:37:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3036622B408;
        Fri, 15 Jun 2018 13:37:19 -0400 (EDT)
Date:   Fri, 15 Jun 2018 13:37:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <1373980460.14412.1529084239034.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180615105809.GB7603@jamesdev>
References: <20180614235211.31357-1-paul.burton@mips.com> <20180614235211.31357-5-paul.burton@mips.com> <20180615105809.GB7603@jamesdev>
Subject: Re: [PATCH 4/4] rseq/selftests: Implement MIPS support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq/selftests: Implement MIPS support
Thread-Index: sJDkoLXztL0rd01o4PFqQYpfV3YGlA==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@efficios.com
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

----- On Jun 15, 2018, at 6:58 AM, James Hogan jhogan@kernel.org wrote:

> On Thu, Jun 14, 2018 at 04:52:10PM -0700, Paul Burton wrote:
>> +#define __RSEQ_ASM_DEFINE_TABLE(version, flags,	start_ip,			\
> 
> Nit: technically all these \'s are on 81st column...
> 
>> +#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,			\
>> +				abort_label, version, flags,			\
>> +				start_ip, post_commit_offset, abort_ip)		\
>> +		".balign 32\n\t"						\
> 
> ARM doesn't do this for DEFINE_ABORT. Is it intentional that we do for
> MIPS?

Given that include/uapi/linux/rseq.h declares struct rseq_cs as
__attribute__((aligned(4 * sizeof(__u64)))), and considering this
comment:

/*
 * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
 * contained within a single cache-line. It is usually declared as
 * link-time constant data.
 */

The .balign 32 is the right thing to do here. I will add a .balign 32
to ARM selftests code as well.

Thanks,

Mathieu

> 
> Thanks
> James

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
