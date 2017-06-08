Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:52:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49424 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994231AbdFHNlQG-ucT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 15:41:16 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v58Df7ox011853;
        Thu, 8 Jun 2017 15:41:07 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v58Df7Br011852;
        Thu, 8 Jun 2017 15:41:07 +0200
Date:   Thu, 8 Jun 2017 15:41:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips/kprobes: flush_insn_slot should flush only if probe
 initialised
Message-ID: <20170608134107.GA11304@linux-mips.org>
References: <1496928032-561-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496928032-561-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Jun 08, 2017 at 03:20:32PM +0200, Marcin Nowakowski wrote:

> When ftrace is used with kprobes, it is possible for a kprobe to contain
> an invalid location (ie. only initialised to 0 and not to a specific
> location in the code). Trying to perform a cache flush on such location
> leads to a crash r4k_flush_icache_range().

Cute, 2.6.36+ ...

Applied,

  Ralf
