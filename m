Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 03:13:31 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60888 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491037Ab0D2BN2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Apr 2010 03:13:28 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3T1DLmK002973;
        Thu, 29 Apr 2010 02:13:21 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3T1DITe002971;
        Thu, 29 Apr 2010 02:13:18 +0100
Date:   Thu, 29 Apr 2010 02:13:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: Use uasm_i_ds{r,l}l_safe() instead of
 uasm_i_ds{r,l}l() in tlbex.c
Message-ID: <20100429011317.GB1704@linux-mips.org>
References: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
 <1272482178-4712-3-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1272482178-4712-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 28, 2010 at 12:16:17PM -0700, David Daney wrote:

> This makes the code somewhat cleaner while reducing the risk of shift
> amount overflows when various page table related options are changed.

Applied.  Thanks!

  Ralf
