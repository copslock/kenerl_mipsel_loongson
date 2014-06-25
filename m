Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 10:13:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7096 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819433AbaFYINBGjtla (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 10:13:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 592CDE6ADE8A3;
        Wed, 25 Jun 2014 09:12:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 25 Jun 2014 09:12:54 +0100
Received: from [192.168.154.28] (192.168.154.28) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 25 Jun
 2014 09:12:53 +0100
Message-ID: <53AA8485.4040805@imgtec.com>
Date:   Wed, 25 Jun 2014 09:12:53 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Alexei Starovoitov <ast@plumgrid.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Network Development" <netdev@vger.kernel.org>
Subject: Re: [PATCH 05/17] MIPS: bpf: Return error code if the offset is a
 negative number
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>      <1403516340-22997-6-git-send-email-markos.chandras@imgtec.com> <CAMEtUuyL8EV3UxS7yaD_ufiAywr7hkgPSC-3etMEYfbAZ_rRew@mail.gmail.com>
In-Reply-To: <CAMEtUuyL8EV3UxS7yaD_ufiAywr7hkgPSC-3etMEYfbAZ_rRew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40791
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

On 06/23/2014 11:09 PM, Alexei Starovoitov wrote:
> On Mon, Jun 23, 2014 at 2:38 AM, Markos Chandras
> <markos.chandras@imgtec.com> wrote:
>> Previously, the negative offset was not checked leading to failures
>> due to trying to load data beyond the skb struct boundaries. Until we
>> have proper asm helpers in place, it's best if we return ENOSUPP if K
>> is negative when trying to JIT the filter or 0 during runtime if we
>> do an indirect load where the value of X is unknown during build time.
>>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Daniel Borkmann <dborkman@redhat.com>
>> Cc: Alexei Starovoitov <ast@plumgrid.com>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> 
> Hi Markos,
> 
> thank you for addressing all of my earlier comments.
> Looks like test_bpf was quite useful in finding all of these bugs :)
> For the patches that reached netdev:
> 
> Acked-by: Alexei Starovoitov <ast@plumgrid.com>
> 

Thank you for the review and your constructive comments in your previous
emails.

-- 
markos
