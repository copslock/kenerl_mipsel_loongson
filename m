Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2011 19:14:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34943 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491062Ab1ARSOk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jan 2011 19:14:40 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id p0IIEZKv029621;
        Tue, 18 Jan 2011 19:14:35 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id p0IIEZxK029620;
        Tue, 18 Jan 2011 19:14:35 +0100
Date:   Tue, 18 Jan 2011 19:14:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Malta: enable Cirrus FB console
Message-ID: <20110118181435.GB28395@linux-mips.org>
References: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
 <1295349645-16805-2-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295349645-16805-2-git-send-email-aurelien@aurel32.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 18, 2011 at 12:20:45PM +0100, Aurelien Jarno wrote:

> While most users of a physical Malta board are using the serial port
> as the console, a lot of QEMU users would prefer to interact with a
> graphical console. Enable the Cirrus FB support in the Malta default
> configuration to make that possible. Note that the default console will
> still be the serial port, users have to pass "console=tty0" to the
> kernel to use the Cirrus FB.

Thanks for sorting this out.  Applied,

  Ralf
