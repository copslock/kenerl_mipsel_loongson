Received:  by oss.sgi.com id <S42210AbQGTNdy>;
	Thu, 20 Jul 2000 06:33:54 -0700
Received: from u-51.karlsruhe.ipdial.viaginterkom.de ([62.180.18.51]:32775
        "EHLO u-51.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42199AbQGTNdd>; Thu, 20 Jul 2000 06:33:33 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639436AbQGTMTD>;
        Thu, 20 Jul 2000 14:19:03 +0200
Date:   Thu, 20 Jul 2000 14:19:03 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Analysis of Samba configure oops
Message-ID: <20000720141903.B26191@bacchus.dhis.org>
References: <20000716182428.A972@foobazco.org> <20000717100534.D6424@chem.unr.edu> <20000718051828.A12440@bacchus.dhis.org> <20000718213310.A27016@chem.unr.edu> <20000719161012.B13006@bacchus.dhis.org> <20000719164012.B21310@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000719164012.B21310@chem.unr.edu>; from wesolows@chem.unr.edu on Wed, Jul 19, 2000 at 04:40:15PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 19, 2000 at 04:40:15PM -0700, Keith M Wesolowski wrote:

> > Funny.  It's unobvious why this happend but I gratefully accept this
> > bug being fixed as well.  Now that this cure was so successful I'll have
> > to research if mips64 is also affected.
> 
> Klaus and I have investiagated further. Apparently the problem does
> not manifest itself with cp -rd or similar, but using tar cf - | tar
> xf - does trigger it. It's not clear why this is.

I don't see why this should make a difference to SCSI.  But the tar variant
that's two processes and lots of context switching between them.

  Ralf
