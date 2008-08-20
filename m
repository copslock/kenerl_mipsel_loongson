Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 18:58:30 +0100 (BST)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:34984 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S28584849AbYHTR6T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 18:58:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 2C56680B4;
	Wed, 20 Aug 2008 12:58:11 -0500 (CDT)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veSy+Esy4M4G; Wed, 20 Aug 2008 12:58:09 -0500 (CDT)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 9A61F806E;
	Wed, 20 Aug 2008 12:58:09 -0500 (CDT)
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Parisc List <linux-parisc@vger.kernel.org>
In-Reply-To: <s5hzln7vd9d.wl%tiwai@suse.de>
References: <s5hk5eezcfe.wl%tiwai@suse.de>
	 <1219249633.3258.18.camel@localhost.localdomain>
	 <s5hzln7vd9d.wl%tiwai@suse.de>
Content-Type: text/plain
Date:	Wed, 20 Aug 2008 12:58:08 -0500
Message-Id: <1219255088.3258.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-08-20 at 18:53 +0200, Takashi Iwai wrote:
> > I'm afraid there are several problems.  The first is that it doesn't do
> > what you want.  You can't map a coherent page to userspace (which is at
> > a non congruent address on parisc) and still expect it to be
> > coherent ... there's going to have to be fiddling with the page table
> > caches to make sure coherency isn't destroyed by aliasing effects
> 
> Hmm...  how bad would be the coherency with such a simple mmap method?
> In most cases, we don't need the "perfect" coherency.  Usually one
> process mmaps the whole buffer and keep reading/writing.  There is
> another use case (sharing the mmapped buffer by multiple processes),
> but this can be disabled if we know it's not feasible beforehand.

Unfortunately, the incoherency is between the user and the kernel.
That's where the aliasing effects occur, so realistically, even though
you've mapped coherent memory to the user, the coherency of that memory
is only device <-> kernel.  When the any single user space process
writes to it, the device won't see the write unless the user issues a
flush.

James
