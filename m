Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2004 16:36:35 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:900 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225428AbUF1Pgb>; Mon, 28 Jun 2004 16:36:31 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 133B749D0A; Mon, 28 Jun 2004 17:36:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id F34AA47C5C; Mon, 28 Jun 2004 17:36:24 +0200 (CEST)
Date: Mon, 28 Jun 2004 17:36:24 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: cgd@broadcom.com
Cc: binutils@sources.redhat.com, ddaney@avtrex.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org, rsandifo@redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
In-Reply-To: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com>
Message-ID: <Pine.LNX.4.55.0406281734560.23162@jurand.ds.pg.gda.pl>
References: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 28 Jun 2004 cgd@broadcom.com wrote:

> personally, i'd make the comment on the 'break' testcase in mips32.s a bit
> clearer and more explicit.  e.g. "for a while, break for mips32 
> took a 20 bit code.  But that was incompatible and caused problems, so
> now it's back to the old 10 bit code, or two comma-separated 10 bit codes."

 No problem.

> Otherwise, people might look and say "huh?"

 ;-)
