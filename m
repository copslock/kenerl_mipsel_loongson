Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2011 17:33:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51604 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491753Ab1JUPdF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Oct 2011 17:33:05 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p9LFX4IV029863;
        Fri, 21 Oct 2011 16:33:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p9LFX4Wm029861;
        Fri, 21 Oct 2011 16:33:04 +0100
Date:   Fri, 21 Oct 2011 16:33:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Nathan Lynch <ntl@pobox.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: call oops_enter, oops_exit in die
Message-ID: <20111021153303.GA29591@linux-mips.org>
References: <1317408575-14855-1-git-send-email-ntl@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1317408575-14855-1-git-send-email-ntl@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15819

On Fri, Sep 30, 2011 at 01:49:35PM -0500, Nathan Lynch wrote:

> This allows pause_on_oops and mtdoops to work.

I've applied this to the master branch when you sent it and now finally
also to the -stable branches.

Thanks!

  Ralf
