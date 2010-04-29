Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 02:52:50 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35677 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491037Ab0D2Awq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Apr 2010 02:52:46 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3T0qdj9002362;
        Thu, 29 Apr 2010 01:52:39 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3T0qbDk002360;
        Thu, 29 Apr 2010 01:52:37 +0100
Date:   Thu, 29 Apr 2010 01:52:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS:  Add uasm_i_dsrl_safe() and uasm_i_dsll_safe()
 to uasm.
Message-ID: <20100429005234.GA1704@linux-mips.org>
References: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
 <1272482178-4712-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1272482178-4712-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 28, 2010 at 12:16:16PM -0700, David Daney wrote:

> This allows us to clean up the code by not having to explicitly code
> checks for shift amounts greater than 32.

Thanks, applied.

  Ralf
