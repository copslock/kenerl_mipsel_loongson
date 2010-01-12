Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2010 11:20:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44641 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492298Ab0ALKUX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jan 2010 11:20:23 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0CAKKWi022453;
        Tue, 12 Jan 2010 11:20:21 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0CAKJPk022451;
        Tue, 12 Jan 2010 11:20:19 +0100
Date:   Tue, 12 Jan 2010 11:20:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Remove unused macros from barrier.h
Message-ID: <20100112102019.GA22088@linux-mips.org>
References: <1262903610-21663-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1262903610-21663-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7725

On Thu, Jan 07, 2010 at 02:33:30PM -0800, David Daney wrote:

> The smp_llsc_rmb() and smp_llsc_wmb() macros are not used in the tree,
> remove them.

Yes, I don't think these macros are going to be used anytime soon.  Queued
for 2.6.34.

  Ralf
