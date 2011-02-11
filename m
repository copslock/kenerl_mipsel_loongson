Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 15:55:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39093 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491059Ab1BKOzD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 15:55:03 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p1BEtoXL008813;
        Fri, 11 Feb 2011 15:55:50 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1BEtonP008811;
        Fri, 11 Feb 2011 15:55:50 +0100
Date:   Fri, 11 Feb 2011 15:55:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A" <anoop.pa@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] MIPS MT kernel modes ( VSMP/SMTC ) support for MSP
 platforms.
Message-ID: <20110211145550.GD23348@linux-mips.org>
References: <1295943663-20192-1-git-send-email-anoop.pa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295943663-20192-1-git-send-email-anoop.pa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@duck.linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Queued for 2.6.39 - but you really should run your patches through 
checkpatch.pl before posting them.  I also removed the inclusion of sched.h
which appeared unnecessary.

  Ralf
