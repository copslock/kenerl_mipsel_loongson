Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 16:42:53 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:33249 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225007AbUGSPmt>; Mon, 19 Jul 2004 16:42:49 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DC323477EF; Mon, 19 Jul 2004 17:42:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id BD9834762E; Mon, 19 Jul 2004 17:42:42 +0200 (CEST)
Date: Mon, 19 Jul 2004 17:42:42 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: cgd@broadcom.com
Cc: binutils@sources.redhat.com, ddaney@avtrex.com,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@redhat.com>
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <yov5k6x0vxca.fsf@ldt-sj3-010.sj.broadcom.com>
Message-ID: <Pine.LNX.4.55.0407191735570.3667@jurand.ds.pg.gda.pl>
References: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com>
 <Pine.LNX.4.55.0407191612160.3667@jurand.ds.pg.gda.pl> <mailpost.1090246948.15046@news-sj1-1>
 <yov5k6x0vxca.fsf@ldt-sj3-010.sj.broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 Jul 2004 cgd@broadcom.com wrote:

> At Mon, 19 Jul 2004 14:22:29 +0000 (UTC), "Maciej W. Rozycki" wrote:
> > (this has led to an address shift enlarging the
> > patch significantly, unfortunately).
> 
> maybe add nops to pad, instead?

 Well, addresses have been shifted down, so you'd have to remove 
something.  I suppose the break tests could be moved to the end of file, 
but I fail to see an advantage.  Test cases that embed addresses in output 
patterns are doomed to suffer from such changes.

  Maciej
