Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2018 15:12:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46752 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993515AbeGBNMvQPAdk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Jul 2018 15:12:51 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id w62DBxR3431706;
        Mon, 2 Jul 2018 15:11:59 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id w62DBw0f431705;
        Mon, 2 Jul 2018 15:11:58 +0200
Date:   Mon, 2 Jul 2018 15:11:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC] MIPS: Align vmlinuz load address to a page boundary
Message-ID: <20180702131158.GA431230@linux-mips.org>
References: <20180610182056.GA15738@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610182056.GA15738@localhost.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64538
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

On Sun, Jun 10, 2018 at 08:20:58PM +0200, Fredrik Noring wrote:

> The kexec system call seems to require that the vmlinuz loading address is
> aligned to a page boundary. 4096 bytes is a fairly common page size, but
> perhaps not the only possibility? Does kexec require additional alignments?

Basically MIPS supports page sizes 4k, 8k, 16k, 32k, 64k.  Not every system
supports all page sizes.  4k is the safe bet while larger systems prefer 16k
or 64k.  Details are complicated.

And of course with kexec the kexecing and the kexecuted kernels do not even
have to have the same page size.  It would appear that the userland code you
were refering to in your 2nd email in

  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kexec/kexec.c?id=HEAD#n343

might erroneously fail if pagesize on the kexecing kernel is larger than of
the kernel being kexed.

  Ralf
