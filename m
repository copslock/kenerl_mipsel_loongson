Received:  by oss.sgi.com id <S42331AbQINBfp>;
	Wed, 13 Sep 2000 18:35:45 -0700
Received: from u-247.karlsruhe.ipdial.viaginterkom.de ([62.180.10.247]:61959
        "EHLO u-247.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42279AbQINBf3>; Wed, 13 Sep 2000 18:35:29 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868897AbQINBfA>;
        Thu, 14 Sep 2000 03:35:00 +0200
Date:   Thu, 14 Sep 2000 03:35:00 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Greg McGary <greg@mcgary.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: do_page_fault crash on Indigo2
Message-ID: <20000914033500.A9395@bacchus.dhis.org>
References: <200009120107.SAA31731@kayak.mcgary.org> <msk8cgsrz8.fsf@mcgary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <msk8cgsrz8.fsf@mcgary.org>; from greg@mcgary.org on Tue, Sep 12, 2000 at 11:53:15PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 12, 2000 at 11:53:15PM -0700, Greg McGary wrote:

> Here's the call trace.  I'm sure the symbol-table corresponds to the
> crashed system, but the trace looks bogus to me.  I should have a look
> at the call-trace dumping code in linux.  Since I have already written
> one of these things for an embedded system, I painfully aware that
> tracing the stack at runtime for MIPS is fraught with peril.

Backtracing a MIPS stack is tricky; this is about as good as it can get.

  Ralf
