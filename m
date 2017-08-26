Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Aug 2017 12:52:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33994 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994828AbdHZKwg6SX17 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 Aug 2017 12:52:36 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7QAqa0x008778;
        Sat, 26 Aug 2017 12:52:36 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7QAqZan008777;
        Sat, 26 Aug 2017 12:52:35 +0200
Date:   Sat, 26 Aug 2017 12:52:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>
Subject: Re: [PATCH v4 8/8] MIPS: Unselect ARCH_MIGHT_HAVE_PC_SERIO if
 MIPS_GENERIC
Message-ID: <20170826105235.GF7433@linux-mips.org>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-9-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503061833-26563-9-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59810
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

On Fri, Aug 18, 2017 at 03:09:00PM +0200, Aleksandar Markovic wrote:

> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> 
> This effectively disables i8042 driver for MIPS_GENERIC kernel platform.
> Currently, only sead-3, boston and ranchu boards are supported by the
> MIPS generic kernel and none of them require this driver.
> More specifically, kernel would crash if it gets enabled, because
> i8042 driver would try to read from an non-existent IO register.

And many more platforms would beneftig from disabling this option because
let's face it, the i8042's heydays are over.  So rather than spreading
random depenencies on MIPS_GENERIC or other platforms through Kconfig
please push the select of ARCH_MIGHT_HAVE_PC_SERIO to the platforms.

  Ralf
