Received:  by oss.sgi.com id <S42276AbQHIVfp>;
	Wed, 9 Aug 2000 14:35:45 -0700
Received: from u-22.karlsruhe.ipdial.viaginterkom.de ([62.180.19.22]:37125
        "EHLO u-22.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42278AbQHIVf2>; Wed, 9 Aug 2000 14:35:28 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868928AbQHIJGQ>;
        Wed, 9 Aug 2000 11:06:16 +0200
Date:   Wed, 9 Aug 2000 11:06:16 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Adrian Bunk <bunk@fs.tum.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Problem with recent mips kernel from CVS
Message-ID: <20000809110616.A9918@bacchus.dhis.org>
References: <Pine.NEB.4.21.0008082252310.10793-100000@neptun.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.NEB.4.21.0008082252310.10793-100000@neptun.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Tue, Aug 08, 2000 at 10:55:34PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Aug 08, 2000 at 10:55:34PM +0200, Adrian Bunk wrote:

> I wasn't able to configure the kernel 2.4.0-test6-pre7 from CVS without
> creating the (empty) file linux/drivers/mtd/Config.in . After I created
> this file, configuring worked.

Strange.  The current pre8 kernel has this file and it should be 3331 bytes.
Just try cvs update.

  Ralf
