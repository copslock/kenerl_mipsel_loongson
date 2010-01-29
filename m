Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 13:29:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60221 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492641Ab0A2M33 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 13:29:29 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0TCTbfP014931;
        Fri, 29 Jan 2010 13:29:38 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0TCTadO014927;
        Fri, 29 Jan 2010 13:29:36 +0100
Date:   Fri, 29 Jan 2010 13:29:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Allow the auxv's elf_platform entry to be set.
Message-ID: <20100129122935.GA5685@linux-mips.org>
References: <1264726333-26599-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264726333-26599-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18801

On Thu, Jan 28, 2010 at 04:52:12PM -0800, David Daney wrote:

> The userspace runtime linker uses the elf_platform to find the
> libraries optimized for the current CPU archecture variant.  First we
> need to allow it to be set to something other than NULL.  Follow-on
> patches will set some values for specific CPUs.
> 
> GLIBC already does the right thing.  The kernel just needs to supply
> good data.

Thanks, queued for 2.6.34.

  Ralf
