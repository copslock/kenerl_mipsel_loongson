Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2010 13:33:13 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58969 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492427Ab0AMMdJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jan 2010 13:33:09 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0DCX0ti020646;
        Wed, 13 Jan 2010 13:33:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0DCWwwQ020645;
        Wed, 13 Jan 2010 13:32:58 +0100
Date:   Wed, 13 Jan 2010 13:32:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: New macro smp_mb__before_llsc.
Message-ID: <20100113123258.GA20354@linux-mips.org>
References: <4B47D8ED.1020006@caviumnetworks.com>
 <1262999864-2353-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1262999864-2353-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8517

On Fri, Jan 08, 2010 at 05:17:43PM -0800, David Daney wrote:

> Replace some instances of smp_llsc_mb() with a new macro
> smp_mb__before_llsc().  It is used before ll/sc sequences that are
> documented as needing write barrier semantics.
> 
> The default implementation of smp_mb__before_llsc() is just
> smp_llsc_mb(), so there are no changes in semantics.
> 
> Also simplify definition of smp_mb(), smp_rmb(), and smp_wmb() to be
> just barrier() in the non-SMP case.

Queued for 2.6.34.  Thanks!

  Ralf
