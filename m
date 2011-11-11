Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 14:35:02 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58374 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903966Ab1KKNeq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 14:34:46 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pABDYi8A012400;
        Fri, 11 Nov 2011 13:34:44 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pABDYiZG012398;
        Fri, 11 Nov 2011 13:34:44 GMT
Date:   Fri, 11 Nov 2011 13:34:44 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 6/8] MIPS: Add NMI notifier
Message-ID: <20111111133444.GA12174@linux-mips.org>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
 <598dabc28eb6fdbd820ea80c0a57e87d@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598dabc28eb6fdbd820ea80c0a57e87d@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10294

On Thu, Nov 10, 2011 at 10:30:29PM -0800, Kevin Cernekee wrote:

> + * No lock; only written during early bootup by CPU 0.

And if that wasn't the case, an NMI might come at any time, even with the
lock already being held which would result in a deadlock.  NMIs are
nasty stuff - and on MIPS they're just slightly more evil.

  Ralf
