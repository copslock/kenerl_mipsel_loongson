Received:  by oss.sgi.com id <S42289AbQGaJ4o>;
	Mon, 31 Jul 2000 02:56:44 -0700
Received: from u-38.karlsruhe.ipdial.viaginterkom.de ([62.180.19.38]:13833
        "EHLO u-38.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42233AbQGaJ41>; Mon, 31 Jul 2000 02:56:27 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868834AbQGaJ3Q>;
        Mon, 31 Jul 2000 11:29:16 +0200
Date:   Mon, 31 Jul 2000 11:29:16 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Cache changes
Message-ID: <20000731112916.A19263@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I've cleaned some of the r4xx0.c cache functions yesterday.  Aside of shaving
off almost 50% of lat_mmap benchmark results we now also properly assymetric
cache line sizes as seen on the R4300 or used by certain configurations of
the M700 and Mips Magnum.

One of the next things I'll kill is support for split data and instruction
second level caches on R4000 and R4400; I haven't ever heared of such a
configuration actually being used in practice and anyway, it's a runtime
configurable feature so we could get rid of it if we ever run into it.

  Ralf
