Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 18:13:51 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:2824
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224929AbUHRRNq>; Wed, 18 Aug 2004 18:13:46 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BxU0N-0006sO-00; Wed, 18 Aug 2004 19:13:43 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BxU0M-0006JL-00; Wed, 18 Aug 2004 19:13:42 +0200
Date: Wed, 18 Aug 2004 19:13:42 +0200
To: Tim Lai <tinglai@gmail.com>
Cc: Eric DeVolder <eric.devolder@amd.com>, linux-mips@linux-mips.org
Subject: Re: problem with prefetch in user space
Message-ID: <20040818171342.GN23756@rembrandt.csv.ica.uni-stuttgart.de>
References: <e2eac65704081716345c78b7c6@mail.gmail.com> <41235841.6090105@amd.com> <e2eac65704081808061f27cb5a@mail.gmail.com> <20040818153148.GI23756@rembrandt.csv.ica.uni-stuttgart.de> <e2eac657040818094264dc6a3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2eac657040818094264dc6a3b@mail.gmail.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Tim Lai wrote:
> Thanks. 
> I did some search and find no answer. How do I define %0 as a register input and
> assign the value of "addr" to it?

Something like:

        __asm__ __volatile__(
		".set push\n"
		".set mips4\n"
		"pref " PREF_OP ", 0(%0)\n"
		".set pop\n"
		: "=r" (addr));

For more information: "info gcc" and the kernel sources.


Thiemo
