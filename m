Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 12:37:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32947 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823426Ab3EVKhlArSPR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 May 2013 12:37:41 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4MAbYGM020662;
        Wed, 22 May 2013 12:37:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4MAbUlq020661;
        Wed, 22 May 2013 12:37:30 +0200
Date:   Wed, 22 May 2013 12:37:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Victor Kamensky <kamensky@cisco.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Maneesh Soni <manesoni@cisco.com>,
        yrl.pp-manager.tt@hitachi.com, systemtap@sourceware.org
Subject: Re: [PATCH 2/2] [BUGFIX] kprobes/mips: Fix to check double free of
 insn slot
Message-ID: <20130522103730.GC10769@linux-mips.org>
References: <20130522093409.9084.63554.stgit@mhiramat-M0-7522>
 <20130522093413.9084.33395.stgit@mhiramat-M0-7522>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130522093413.9084.33395.stgit@mhiramat-M0-7522>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36520
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

Thanks, applied.

  Ralf
