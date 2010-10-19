Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 17:21:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58706 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491056Ab0JSPVP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Oct 2010 17:21:15 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9JFL1JC014445;
        Tue, 19 Oct 2010 16:21:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9JFL1BN014444;
        Tue, 19 Oct 2010 16:21:01 +0100
Date:   Tue, 19 Oct 2010 16:21:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com,
        jamie.iles@picochip.com, ddaney@caviumnetworks.com,
        matt@console-pimps.org
Subject: Re: [PATCH v8 2/5] MIPS: add support for software performance events
Message-ID: <20101019152101.GC7778@linux-mips.org>
References: <1286883444-31913-1-git-send-email-dengcheng.zhu@gmail.com>
 <1286883444-31913-3-git-send-email-dengcheng.zhu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286883444-31913-3-git-send-email-dengcheng.zhu@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Thanks, queued for 2.6.37.  I fixed up a trivial reject in unaligned.c
due to a conflict with Al's recent signal fixes.

  Ralf
