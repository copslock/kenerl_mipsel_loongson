Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 16:44:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58689 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491139Ab1INOoR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Sep 2011 16:44:17 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8EEiFW6011135;
        Wed, 14 Sep 2011 16:44:15 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8EEiFCx011134;
        Wed, 14 Sep 2011 16:44:15 +0200
Date:   Wed, 14 Sep 2011 16:44:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: i8259: Mark cascade interrupt non-threaded
Message-ID: <20110914144415.GA9572@linux-mips.org>
References: <alpine.LFD.2.02.1109121334460.2723@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1109121334460.2723@ionos>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7164

On Mon, Sep 12, 2011 at 01:36:29PM +0200, Thomas Gleixner wrote:

> From: Liming Wang <liming.wang@windriver.com>
> Date: Fri, 26 Aug 2011 23:00:04 +0800
> 
> Cascade interrupts cannot be threaded.

Applied.  Thanks!

  Ralf
