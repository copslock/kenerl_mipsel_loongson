Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2011 15:06:40 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40562 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491110Ab1G0NGg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jul 2011 15:06:36 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6RD6XBl005489;
        Wed, 27 Jul 2011 14:06:34 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6RD6Xj5005488;
        Wed, 27 Jul 2011 14:06:33 +0100
Date:   Wed, 27 Jul 2011 14:06:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [patch 3/7] mips: Enable interrupts in do_signal()
Message-ID: <20110727130633.GI23769@linux-mips.org>
References: <20110723123948.573545817@linutronix.de>
 <20110723124016.118094411@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110723124016.118094411@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19692

On Sat, Jul 23, 2011 at 12:41:23PM -0000, Thomas Gleixner wrote:

Uwh..  This one affects master and all -stable branches.  But as discussed
on IRC I"ve placed the call directly into do_notify_resume - the less code
running with interrutps disabled the better.

  Ralf
