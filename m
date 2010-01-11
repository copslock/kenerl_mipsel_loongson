Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2010 11:20:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34544 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492060Ab0AKKUc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2010 11:20:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0BAKOxG014899;
        Mon, 11 Jan 2010 11:20:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0BAKNs5014897;
        Mon, 11 Jan 2010 11:20:23 +0100
Date:   Mon, 11 Jan 2010 11:20:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Use non-overflowing arithmetic in
 sched_clock
Message-ID: <20100111102023.GE13886@linux-mips.org>
References: <1262990856-8300-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1262990856-8300-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6955

On Fri, Jan 08, 2010 at 02:47:36PM -0800, David Daney wrote:

> With typical mult and shift values, the calculation for Octeon's
> sched_clock overflows when using 64-bit arithmetic.  Use 128-bit
> calculations instead.

Applied though my first thought whenever I see extended precission math
is gross - maybe we're going to find a better solution.  Hopefully!

  Ralf
