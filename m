Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 16:34:55 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:17926
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224929AbUHRPev>; Wed, 18 Aug 2004 16:34:51 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BxSPl-0005tD-00; Wed, 18 Aug 2004 17:31:49 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BxSPk-0005qO-00; Wed, 18 Aug 2004 17:31:48 +0200
Date: Wed, 18 Aug 2004 17:31:48 +0200
To: Tim Lai <tinglai@gmail.com>
Cc: Eric DeVolder <eric.devolder@amd.com>, linux-mips@linux-mips.org
Subject: Re: problem with prefetch in user space
Message-ID: <20040818153148.GI23756@rembrandt.csv.ica.uni-stuttgart.de>
References: <e2eac65704081716345c78b7c6@mail.gmail.com> <41235841.6090105@amd.com> <e2eac65704081808061f27cb5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2eac65704081808061f27cb5a@mail.gmail.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Tim Lai wrote:
> Thanks for the suggestion.
> I tried it, and still got the same error:
> 
> /tmp/cc73TRSF.s:5521: Error: illegal operands `pref'

That's because you use

> > >                         "     pref       4 ,  0(%0)  \n"
> > >
> > >                         ".set pop                   \n");

without defining %0 as a register input.


Thiemo
