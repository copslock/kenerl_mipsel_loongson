Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2010 02:32:00 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42156 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492491Ab0EKAb5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 May 2010 02:31:57 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4B0Vrjn025787;
        Tue, 11 May 2010 01:31:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4B0Vp5P025785;
        Tue, 11 May 2010 01:31:51 +0100
Date:   Tue, 11 May 2010 01:31:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org,
        Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Use compat version for n32 sys_ppoll.
Message-ID: <20100511003150.GA22990@linux-mips.org>
References: <1273536714-27535-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1273536714-27535-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 10, 2010 at 05:11:54PM -0700, David Daney wrote:

> From: Chandrakala Chavva <cchavva@caviumnetworks.com>
> 
> The sys_ppoll() takes struct 'struct timespec'. This is different
> for n32 and n64 abi. Use the compat version to do the proper conversions.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Sigh, this sort of fix has a long tradition.  I'm glad we're maintaining
it ;-)  Patch applied.

Thanks,

  Ralf
