Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2009 00:36:13 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38352 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493555AbZHJWft (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2009 00:35:49 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7AMYdiu024259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Aug 2009 15:34:40 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n7AMYc1i023953;
	Mon, 10 Aug 2009 15:34:38 -0700
Date:	Mon, 10 Aug 2009 15:34:38 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	ralf@linux-mips.org, torvalds@linux-foundation.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/2] New hardware RNG for Octeon SOCs.
Message-Id: <20090810153438.542f55e0.akpm@linux-foundation.org>
In-Reply-To: <4A806529.3060609@caviumnetworks.com>
References: <4A806529.3060609@caviumnetworks.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Aug 2009 11:21:29 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> Behold the Random Number Generator driver for Octeon!

Hail!

> The first patch adds some port definitions and the octeon_rng platform
> device.  The second is the driver.
> 
> I am copying AKPM and Linus as there seems to be no hw_random maintainer.
> 
> Since Octeon is a mips port, we might want to merge both patches via
> Ralf's tree.
> 
> Comments?

Looks OK to me - I had a couple of minor comments.  Please send the
patches to Herbert and Ralf - I'd normally expect one of those two
gents to be the merge path for this work.
