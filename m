Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 13:58:31 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59584 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491195Ab0KXM62 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Nov 2010 13:58:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oAOCsL8Z002399;
        Wed, 24 Nov 2010 12:54:21 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oAOCsC6o002362;
        Wed, 24 Nov 2010 12:54:13 GMT
Date:   Wed, 24 Nov 2010 12:54:12 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-m68k@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Hirokazu Takata <takata@linux-m32r.org>,
        linux-m32r@ml.linux-m32r.org, linux-mips@linux-mips.org,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
        Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH v3 22/22] bitops: remove minix bitops from asm/bitops.h
Message-ID: <20101124125412.GA1876@linux-mips.org>
References: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
 <1290519504-3958-23-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290519504-3958-23-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 10:38:24PM +0900, Akinobu Mita wrote:

> minix bit operations are only used by minix filesystem and useless
> by other modules. Because byte order of inode and block bitmaps is
> defferent on each architecture like below:
  ^^^^^ different

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
