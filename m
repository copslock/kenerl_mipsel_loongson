Received:  by oss.sgi.com id <S553755AbQKCAVZ>;
	Thu, 2 Nov 2000 16:21:25 -0800
Received: from u-240.karlsruhe.ipdial.viaginterkom.de ([62.180.21.240]:23313
        "EHLO u-240.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553793AbQKCAVQ>; Thu, 2 Nov 2000 16:21:16 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869098AbQKBMz3>;
        Thu, 2 Nov 2000 13:55:29 +0100
Date:   Thu, 2 Nov 2000 13:55:29 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@mvista.com>
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: rm7000/orion board
Message-ID: <20001102135528.A19967@bacchus.dhis.org>
References: <3A00EEDF.7C5E6BD5@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A00EEDF.7C5E6BD5@mvista.com>; from ppopov@mvista.com on Wed, Nov 01, 2000 at 08:34:39PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 01, 2000 at 08:34:39PM -0800, Pete Popov wrote:

> There's some R7000 support, apparently added for an "Orion" board.  Has
> any one had any experience with this board, or with linux on the R7000
> in general?

The Orion is an embedded application based on the RM7000, not an evaluation
board.

The RM7000 as is in CVS isn't currently completly supported.  In particular
that code doesn't handle the L2 and L3 caches, so as is no DMA I/O is
supported for RM7000.  Aside of that it's fine CPU with Linux - and one
of the few 64-bit MIPSes with sane caches.  I got some RM7000 code in the
queue - but I will not commit it before it's tested on something better
than vapor hardware.

  Ralf
