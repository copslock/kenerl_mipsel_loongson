Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jun 2004 11:40:16 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:15059 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225722AbUFXKkL>;
	Thu, 24 Jun 2004 11:40:11 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i5OAdje1019773;
	Thu, 24 Jun 2004 06:39:45 -0400
Received: from localhost (mail@vpn50-12.rdu.redhat.com [172.16.50.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i5OAdh020462;
	Thu, 24 Jun 2004 06:39:43 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BdRdu-0002UQ-00; Thu, 24 Jun 2004 11:39:42 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: cgd@broadcom.com, David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
	<40C9F7F0.50501@avtrex.com>
	<Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
	<mailpost.1086981251.16853@news-sj1-1>
	<yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
	<Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Thu, 24 Jun 2004 11:39:42 +0100
In-Reply-To: <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl> (Maciej
 W. Rozycki's message of "Tue, 22 Jun 2004 23:30:48 +0200 (CEST)")
Message-ID: <87y8mdgryp.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:
>  Or should we get rid of the 20-bit "break" completely?  The two-argument
> version provides the same functionality, although the 10-bit codes to be
> used do not map to the 20-bit equivalent "optically" very well.  
> Especially if decimal notation is used.

I notice no-one's really responded to this question yet.  FWIW, on gut
instinct, I'd personally prefer to drop the 20-bit break than introduce
a new, non-standard name for it.

Just an opinion though.  I won't argue against anyone saying different. ;)

Richard
