Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2015 19:12:53 +0200 (CEST)
Received: from mail.efficios.com ([78.47.125.74]:52740 "EHLO mail.efficios.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009113AbbI1RMuxAKuH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Sep 2015 19:12:50 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 87E8D3403FD;
        Mon, 28 Sep 2015 17:12:40 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id f6e08Bh4LN7G; Mon, 28 Sep 2015 17:12:32 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7F9913404CB;
        Mon, 28 Sep 2015 17:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oqtRcFPkrg2C; Mon, 28 Sep 2015 17:12:32 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
        by mail.efficios.com (Postfix) with ESMTP id 5970F3403FD;
        Mon, 28 Sep 2015 17:12:32 +0000 (UTC)
Date:   Mon, 28 Sep 2015 17:12:32 +0000 (UTC)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Message-ID: <827141828.6114.1443460352159.JavaMail.zimbra@efficios.com>
In-Reply-To: <1089832901.9282.1442415898500.JavaMail.zimbra@efficios.com>
References: <1441642556-30972-1-git-send-email-mathieu.desnoyers@efficios.com> <1441642556-30972-3-git-send-email-mathieu.desnoyers@efficios.com> <1089832901.9282.1442415898500.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH v2 2/9] mips: allocate sys_membarrier system call number
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.47.125.74]
X-Mailer: Zimbra 8.6.0_GA_1178 (ZimbraWebClient - FF41 (Linux)/8.6.0_GA_1178)
Thread-Topic: mips: allocate sys_membarrier system call number
Thread-Index: gLVOhhrEOL1/t6TvqhdvlZ4vb9l9mzMnRVVz
Return-Path: <compudj@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49391
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

----- On Sep 16, 2015, at 11:04 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Acked-by: Ralf Baechle <ralf@linux-mips.org>

[...]

Hi Andrew,

Since I got the Acked-by from Ralf, my understanding is that he
expects that you can pick up this patch through your tree. Please let
me know if I need to do anything more. It's the same story for
sparc/sparc64.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
