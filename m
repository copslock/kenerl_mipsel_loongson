Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAL5WgR31269
	for linux-mips-outgoing; Tue, 20 Nov 2001 21:32:42 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAL5WQo31253
	for <linux-mips@oss.sgi.com>; Tue, 20 Nov 2001 21:32:27 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAL4WLV09253;
	Wed, 21 Nov 2001 15:32:21 +1100
Date: Wed, 21 Nov 2001 15:32:21 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: ellis@spinics.net
Cc: linux-mips@oss.sgi.com
Subject: Re: ns83820
Message-ID: <20011121153221.A30470@dea.linux-mips.net>
References: <200111202208.fAKM8rU23663@spinics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111202208.fAKM8rU23663@spinics.net>; from ellis@spinics.net on Tue, Nov 20, 2001 at 02:08:53PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 20, 2001 at 02:08:53PM -0800, ellis@spinics.net wrote:

> Anybody used the ns83820 driver on a MIPS processor?  I stopped
> working after a few packets when I try to use it.

I've got no reports regarding the ns83820.  From your description the problem
might be some cache coherence problem which might be both an error in
the driver or the MIPS code itself.

  Ralf
