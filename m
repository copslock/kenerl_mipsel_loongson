Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 16:44:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45729 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821285AbaDHOojpBh4c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Apr 2014 16:44:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s38Eib9H001472;
        Tue, 8 Apr 2014 16:44:37 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s38EiaN8001471;
        Tue, 8 Apr 2014 16:44:36 +0200
Date:   Tue, 8 Apr 2014 16:44:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Remove SMTC Support
Message-ID: <20140408144436.GT17197@linux-mips.org>
References: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1396954750-24762-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39724
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

On Tue, Apr 08, 2014 at 11:59:08AM +0100, Markos Chandras wrote:

> This patchset removes the MIPS SMTC support.

While not really a fix I've applied this to my 3.15 fix branch.  At least
it will avoid us having to fix it up for 3.15 :-)

That said, SMTC was a remarkable hack and ingenious proof of the MT
architecture.

Still a sore spot is CONFIG_MIPS_MT_FPAFF with all its uglyness it
scatters over the tree, in particular the wrapper around the syscall
entry point.  I wonder if nowadays with the work that's been done on
supporting inhomogenous SMP systems (ARM biglittle) there's now a
better way to handle this sort of issue.

  Ralf
