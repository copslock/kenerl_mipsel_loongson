Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 19:29:06 +0000 (GMT)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:13696 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225247AbULGT2z>;
	Tue, 7 Dec 2004 19:28:55 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id iB7JScET021320;
	Tue, 7 Dec 2004 14:28:43 -0500
Received: from localhost (mail@vpn50-84.rdu.redhat.com [172.16.50.84])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id iB7JSbr19818;
	Tue, 7 Dec 2004 14:28:37 -0500
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1Cbl0l-00009C-00; Tue, 07 Dec 2004 19:28:35 +0000
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	Nigel Stephens <nigel@mips.com>, David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
	<16813.39660.948092.328493@doms-laptop.algor.co.uk>
	<20041201123336.GA5612@linux-mips.org>
	<Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl>
	<wvn653epbi1.fsf@talisman.cambridge.redhat.com>
	<20041207125659.GP8714@rembrandt.csv.ica.uni-stuttgart.de>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Tue, 07 Dec 2004 19:28:35 +0000
In-Reply-To: <20041207125659.GP8714@rembrandt.csv.ica.uni-stuttgart.de> (Thiemo
 Seufer's message of "Tue, 7 Dec 2004 13:56:59 +0100")
Message-ID: <87is7d3o2k.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> writes:
> I tried to use "R" in atomic.h but this failed in some (but not all)
> cases with
>
> include/asm/atomic.h:64: error: inconsistent operand constraints in an asm'
>
> where the argument happens to be a member of a global struct.

Doh!  Do you have any testcases handy?  Was it failing with >= 3.4,
or with older toolchains?  3.4 and above should know that 'R' is a
memory-type constraint.

Richard
