Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 18:11:09 +0100 (CET)
Received: from p57B0EBE7.dip.t-dialin.net ([87.176.235.231]:51765 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491021Ab0L1RLG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 18:11:06 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBSHB3C0005017;
        Tue, 28 Dec 2010 18:11:03 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBSHB3C7005015;
        Tue, 28 Dec 2010 18:11:03 +0100
Date:   Tue, 28 Dec 2010 18:11:02 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Add LDX and LWX instructions to uasm.
Message-ID: <20101228171102.GG375@linux-mips.org>
References: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
 <1293502077-9196-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293502077-9196-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The same uasm.h fuzz problem with this patch as previously mentioned.
I'll check on the ordering as you suggested on IRC.

Queued for 2.6.38.  Thanks,

  Ralf
