Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 16:41:16 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:33639
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225220AbTDYPlO>; Fri, 25 Apr 2003 16:41:14 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 1995K4-000ksm-00
	for linux-mips@linux-mips.org; Fri, 25 Apr 2003 17:41:12 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1995K4-0008IK-00
	for <linux-mips@linux-mips.org>; Fri, 25 Apr 2003 17:41:12 +0200
Date: Fri, 25 Apr 2003 17:41:12 +0200
To: linux-mips@linux-mips.org
Subject: Re: [patch] wait instruction on vr4181
Message-ID: <20030425154112.GK19131@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030424190355.GB19131@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030425165319.14121A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030425165319.14121A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 24 Apr 2003, Thiemo Seufer wrote:
> 
> > I have missed this word, but I still can't see how it is relevant to
> > the problem. AFAICS adding '-Wa,-4100' to CFLAGS should solve it,
> > even in the case of a very old gcc.
> 
>  But if I try to build for anything else, say for R3k or MIPS64, there
> will be "-mcpu=r3000" or "-mcpu=r4600" passed and an assembly will fail as
> the "standby" instruction won't magically disappear.  That's why
> r4k_wait() and au1k_wait() use ".set mips3" for "wait". 

The relevant function was #ifdef'ed.

>  BTW, "-m4100" and friends are deprecated and their interaction with
> "-mcpu=", "-march=" and "-mtune=" is unobvious; I have no idea why they
> haven't been banished from the trunk, yet.

True, but as long as people prefer to combine outdated compilers
with the latest binutils this sort of problems will remain.


Thiemo
