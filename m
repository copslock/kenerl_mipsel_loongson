Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 21:10:25 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:43546
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225777AbUERUKU>; Tue, 18 May 2004 21:10:20 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BQAug-0003Hw-00
	for <linux-mips@linux-mips.org>; Tue, 18 May 2004 22:10:10 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BQAug-0005rT-00
	for <linux-mips@linux-mips.org>; Tue, 18 May 2004 22:10:10 +0200
Date: Tue, 18 May 2004 22:10:10 +0200
To: linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518201010.GD31535@rembrandt.csv.ica.uni-stuttgart.de>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Bob Breuer wrote:
[snip]
> From browsing the debian-mips mailing list archives,
> it appears that they have not had a stable mips kernel since 2.4.19,
> could this bug be the cause?  Are the recent Debian mips kernels still
> unstable?

The latest 2.4.25/2.4.26 (Debian-)Kernels seem to work well on all
Debian-supported machines. They include some cobalt patch which
isn't in the linux-mips.org CVS (yet).


Thiemo
