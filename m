Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2004 13:29:44 +0000 (GMT)
Received: from pD956202C.dip.t-dialin.net ([IPv6:::ffff:217.86.32.44]:63013
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224896AbUKQN3k>; Wed, 17 Nov 2004 13:29:40 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAHDTccs003896;
	Wed, 17 Nov 2004 14:29:38 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAHDTcl7003895;
	Wed, 17 Nov 2004 14:29:38 +0100
Date: Wed, 17 Nov 2004 14:29:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH]: R52x0 -> RM52xx
Message-ID: <20041117132937.GA23812@linux-mips.org>
References: <4196FE87.5050606@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4196FE87.5050606@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 14, 2004 at 01:43:19AM -0500, Kumba wrote:

> 
> Attached is a minor cosmetic patch for 2.6 that just changes menuconfig to 
> show the RM52xx CPU by the name it's known by on Systems that use it 
> (Cobalt (RM5231), O2 RM5200).
> 
> It's a really minor thing, but afaict, it doesn't look to be incorrect.

The CPU core is originally a QED (today PMC-Sierra) core but there are
licenses are selling it too such as IDT.  I'm not sure if all of them
are using the RM prefix or not but I usually stick to whatever the
original name was.

  Ralf
