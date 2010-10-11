Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 15:03:26 +0200 (CEST)
Received: from mx2.mail.elte.hu ([157.181.151.9]:38334 "EHLO mx2.mail.elte.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491027Ab0JKNDX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Oct 2010 15:03:23 +0200
Received: from elvis.elte.hu ([157.181.1.14])
        by mx2.mail.elte.hu with esmtp (Exim)
        id 1P5I28-0004MN-Gh
        from <mingo@elte.hu>; Mon, 11 Oct 2010 15:03:18 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
        id 8CAED3E22F7; Mon, 11 Oct 2010 15:03:12 +0200 (CEST)
Date:   Mon, 11 Oct 2010 15:03:12 +0200
From:   Ingo Molnar <mingo@elte.hu>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        a.p.zijlstra@chello.nl, paulus@samba.org, acme@redhat.com
Subject: Re: [PATCH v3] Perf-tool/MIPS: support cross compiling of tools/perf
 for MIPS
Message-ID: <20101011130312.GA7482@elte.hu>
References: <4CB300A2.2070101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CB300A2.2070101@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=BAYES_40 autolearn=no SpamAssassin version=3.2.5
        0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
        [score: 0.3562]
Return-Path: <mingo@elte.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@elte.hu
Precedence: bulk
X-list: linux-mips


* Deng-Cheng Zhu <dengcheng.zhu@gmail.com> wrote:

> 
> 
> This version fixed the cosmetic issue pointed out by Ralf. If it looks ok,
> 
> Ralf, please help Ack it.

Please dont strip changelogs from (re-)submitted patches!

	Ingo
