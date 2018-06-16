Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2018 22:24:47 +0200 (CEST)
Received: from mail.efficios.com ([167.114.142.138]:40144 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993426AbeFPUYjpn2EG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jun 2018 22:24:39 +0200
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DBBF11AD7B6;
        Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id RKKPk7KMCkag; Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5EB461AD7B2;
        Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5EB461AD7B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529180669;
        bh=tdgF/YaKfS0JtvfhhrbUFXww8Bs4JsXperugGlH2zP8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uUdtV7s/SoHAhLbP1jKrtVr3HiZAqQ7QM00rtPl5SqhH9CIIVmmATi4Y3y+pgX11X
         INIfjfQVqVVLGRtq/2g+xK2Mux6X/G+ZODEd/p8b3E1+orXfmEcSHRIMvk89feYnLe
         dxeFC1NNoLG2sKN3r5iRXuXB24t2B/DTGxUYQmaptukYAAWTZmfTGY/0DtC2w3Eaeg
         MPPBoUsUnE7aGChJXmmtQ5aVR6sH63a7TXB3smLgoUKC5rlE+7gdIkW18m+NOJELgV
         1uZVhaJATwm99h2kHrM7DMk+ozYx9/qGX94LwOuVJbWoPeLPIYSkgvnBn8YdHjYqIH
         eSxNPb/WwS72g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JxS1runpx-Zo; Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4A5641AD79D;
        Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
Date:   Sat, 16 Jun 2018 16:24:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <1265723673.16061.1529180669270.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180614235211.31357-1-paul.burton@mips.com>
References: <20180614235211.31357-1-paul.burton@mips.com>
Subject: Re: [PATCH 0/4] MIPS: Restartable sequences (rseq) support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: MIPS: Restartable sequences (rseq) support
Thread-Index: SIq+dComtRU3KK3IHH2fHjNEax3cmA==
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64326
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

----- On Jun 14, 2018, at 7:52 PM, Paul Burton paul.burton@mips.com wrote:

> This series implements MIPS support for restartable sequences, hooks up
> the rseq syscall & implements MIPS support in the rseq selftests.
> 
> Applies atop Linus' master as of 2837461dbe6f ("Merge tag 'scsi-fixes'
> of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi").
> 

For the entire series:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Unless you ask otherwise, I will expect this patchset to be picked
up through the MIPS maintainer tree.

Thanks!

Mathieu

> Thanks,
>    Paul
> 
> Paul Burton (4):
>  MIPS: Add support for restartable sequences
>  MIPS: Add syscall detection for restartable sequences
>  MIPS: Wire up the restartable sequences (rseq) syscall
>  rseq/selftests: Implement MIPS support
> 
> arch/mips/Kconfig                         |   1 +
> arch/mips/include/uapi/asm/unistd.h       |  15 +-
> arch/mips/kernel/entry.S                  |   8 +
> arch/mips/kernel/scall32-o32.S            |   1 +
> arch/mips/kernel/scall64-64.S             |   1 +
> arch/mips/kernel/scall64-n32.S            |   1 +
> arch/mips/kernel/scall64-o32.S            |   1 +
> arch/mips/kernel/signal.c                 |   3 +
> tools/testing/selftests/rseq/param_test.c |  24 +
> tools/testing/selftests/rseq/rseq-mips.h  | 725 ++++++++++++++++++++++
> tools/testing/selftests/rseq/rseq.h       |   2 +
> 11 files changed, 776 insertions(+), 6 deletions(-)
> create mode 100644 tools/testing/selftests/rseq/rseq-mips.h
> 
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
