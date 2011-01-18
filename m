Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2011 19:13:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34742 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491062Ab1ARSNy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jan 2011 19:13:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id p0IIDmdD029581;
        Tue, 18 Jan 2011 19:13:50 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id p0IIDk9O029572;
        Tue, 18 Jan 2011 19:13:46 +0100
Date:   Tue, 18 Jan 2011 19:13:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: add CONFIG_VIRTUALIZATION for virtio support
Message-ID: <20110118181346.GA28395@linux-mips.org>
References: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295349645-16805-1-git-send-email-aurelien@aurel32.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 18, 2011 at 12:20:44PM +0100, Aurelien Jarno wrote:

> Add CONFIG_VIRTUALIZATION to the MIPS architecture and include the
> the virtio code there. Used to enable the virtio drivers under QEMU.

Good one.  Even though a "feature" it may deserve backporting to -stable.

Applied,

  Ralf

  Ralf
