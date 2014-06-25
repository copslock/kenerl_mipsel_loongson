Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 11:31:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41826 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859932AbaFYJb1Q5KRL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 11:31:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3A6201C5318DE;
        Wed, 25 Jun 2014 10:31:19 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 25 Jun 2014 10:31:20 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 25 Jun
 2014 10:31:19 +0100
Message-ID: <53AA96E7.4040609@imgtec.com>
Date:   Wed, 25 Jun 2014 10:31:19 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 8/9] MIPS: KVM: Skip memory cleaning in kvm_mips_commpage_init()
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com> <1403631071-6012-9-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1403631071-6012-9-git-send-email-dengcheng.zhu@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 24/06/14 18:31, Deng-Cheng Zhu wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> 
> The commpage is allocated using kzalloc(), so there's no need of cleaning
> the memory of the kvm_mips_commpage struct and its internal mips_coproc.
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James
