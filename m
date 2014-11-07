Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 03:02:08 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59877 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012855AbaKGCCHG-kPf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Nov 2014 03:02:07 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sA7225nt024588;
        Fri, 7 Nov 2014 03:02:05 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sA7225eh024587;
        Fri, 7 Nov 2014 03:02:05 +0100
Date:   Fri, 7 Nov 2014 03:02:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
Message-ID: <20141107020204.GA24423@linux-mips.org>
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43889
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

On Fri, Oct 31, 2014 at 05:03:14PM +0100, Manuel Lauss wrote:

With this patch applied and binutils 2.24 I'm getting this:

[...]
{standard input}: Assembler messages:
{standard input}:4248: Error: opcode not supported on this processor: mips1
+(mips1) `cfc1 $2,$31'
make[1]: *** [arch/mips/math-emu/cp1emu.o] Error 1
make: *** [arch/mips/math-emu] Error 2
make: *** Waiting for unfinished jobs....

for all defconfigs.

  Ralf
