Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 14:31:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33828 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993888AbdDDMbN6QjHi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Apr 2017 14:31:13 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v34CUPCp030278;
        Tue, 4 Apr 2017 14:30:25 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v34CUOvn030276;
        Tue, 4 Apr 2017 14:30:24 +0200
Date:   Tue, 4 Apr 2017 14:30:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [ADMIN] kernel tarball users?
Message-ID: <20170404123024.GG7681@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Years ago tarballs were the standard way to download the kernel, in
particular by those users such as distributions who need something well
defined to base their work on.

Times have changed.  Git came finally allowing MIPS to become fully merged
upstream into the kernel.org kernel, CVS faded away into obscurity and
the immense growth of a kernel tarball - a .xz compressed kernel tarball
is now about 90MiB, a .gz compressed kernel even 138MiB.  Combined that
is even 228MiB!

Which means at the same time that the tarballs are melting the diskspace
at exponentional speed, their usefulness has diminished.

So the question is, is there still any value in continuing to generate
tarballs from every -rc, every stable kernel release?  Should I just
stop?  Is everybody happiert with a git than with tarballs?

Note that this not about discontinuing ftp service such as kernel.org
recently did.  kernel.org is a much bigger site and has considerations
with ftp which linux-mips.org doesn't have.  For me continuing ftp service
would be a very minor burden.

Thanks,

  Ralf
