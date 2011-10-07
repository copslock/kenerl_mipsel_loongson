Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2011 18:33:36 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53101 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491194Ab1JGQdc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Oct 2011 18:33:32 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p97GXVkA027763;
        Fri, 7 Oct 2011 17:33:31 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p97GXUa6027761;
        Fri, 7 Oct 2011 17:33:30 +0100
Date:   Fri, 7 Oct 2011 17:33:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2] MIPS: Alchemy: redo PCI as platform driver
Message-ID: <20111007163330.GA26918@linux-mips.org>
References: <1317908261-25608-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1317908261-25608-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4833

On Thu, Oct 06, 2011 at 03:37:41PM +0200, Manuel Lauss wrote:

> V2: changed PM to use syscore_ops instead of the platform_driver PM callbacks.
>     syscore_ops are called much earlier during the resume process which
>     makes restoring the wired entry much more straightforward.

Shouldn't the handling of wired entries rather be done in
arch/mips/power/cpu.c?

  Ralf
