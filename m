Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2009 23:02:32 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55471 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493603AbZLSWC3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2009 23:02:29 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBJM2LSQ023445;
        Sat, 19 Dec 2009 22:02:21 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBJM2KP2023443;
        Sat, 19 Dec 2009 22:02:20 GMT
Date:   Sat, 19 Dec 2009 22:02:19 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Two-level pagetables for 64-bit kernels with 64KB
 pages.
Message-ID: <20091219220219.GB19780@linux-mips.org>
References: <1259963556-6876-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259963556-6876-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 04, 2009 at 01:52:36PM -0800, David Daney wrote:

> For 64-bit kernels with 64KB pages and two level page tables, there
> are 42 bits worth of virtual address space This is larger than the 40
> bits of virtual address space obtained with the default 4KB Page size
> and three levels, so there are no draw backs for using two level
> tables with this configuration.

Queued for 2.6.34,

  Ralf
