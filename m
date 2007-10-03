Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 11:32:10 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57062 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022395AbXJCKcI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 11:32:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l93AW7L5029479;
	Wed, 3 Oct 2007 11:32:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l93AW6je029478;
	Wed, 3 Oct 2007 11:32:06 +0100
Date:	Wed, 3 Oct 2007 11:32:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071003103206.GA29244@linux-mips.org>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <Pine.LNX.4.64N.0710021651490.32726@blysk.ds.pg.gda.pl> <20071003010053.GA25603@linux-mips.org> <Pine.LNX.4.64.0710030905030.14583@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710030905030.14583@anakin>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 03, 2007 at 09:05:43AM +0200, Geert Uytterhoeven wrote:

> On Wed, 3 Oct 2007, Ralf Baechle wrote:
> > Anyway, queued for 2.6.24.  That is if 2.6.23 is ever released ;-)
> 
> Any scripts relying on -rcX being single-digit? ;-)

        if ($tag =~ /linux-([0-9]+\.[0-9]).*-.*/) {
                $final = "/pub/linux/mips/kernel/v$1/testing/$tag.tar.gz";
        } elsif ($tag =~ /linux-([0-9]+\.[0-9])/) {
                $final = "/pub/linux/mips/kernel/v$1/$tag.tar.gz";


No :-)

  Ralf
