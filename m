Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 18:59:21 +0000 (GMT)
Received: from p549F5309.dip.t-dialin.net ([84.159.83.9]:37217 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S8133470AbVLUS7E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 18:59:04 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.4/8.13.1) with ESMTP id jBLJ0EYj014806
	for <linux-mips@linux-mips.org>; Wed, 21 Dec 2005 20:00:14 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.4/8.13.4/Submit) id jBLJ0E2A014805
	for linux-mips@linux-mips.org; Wed, 21 Dec 2005 20:00:14 +0100
Date:	Wed, 21 Dec 2005 20:00:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Message-ID: <20051221190014.GA1918@linux-mips.org>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com> <1135155432.9009.18.camel@localhost.localdomain> <50c9a2250512210106h7bca5c7fu5714ea3aa16cde8a@mail.gmail.com> <20051221092207.GU13985@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221092207.GU13985@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 21, 2005 at 10:22:08AM +0100, Jan-Benedict Glaw wrote:

> On Wed, 2005-12-21 17:06:36 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
> > i am not sure which toolchain can work for the 2.6 kernel
> > can you suggest one?
> 
> That's a hard question... 2.95.x compilers used to work and were quite
> fast, but newer GCC's features are incorporated into the kernel
> sources so it probably will no longer work.

There are still users building the kernel with gcc 2.95 and 2.96
successfully.

  Ralf
