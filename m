Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Feb 2005 13:07:22 +0000 (GMT)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:19166 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225003AbVBLNHG>;
	Sat, 12 Feb 2005 13:07:06 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j1CD74gb031268
	for <linux-mips@linux-mips.org>; Sat, 12 Feb 2005 08:07:04 -0500
Received: from firetop.home (vpn50-8.rdu.redhat.com [172.16.50.8])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j1CD6xO20655
	for <linux-mips@linux-mips.org>; Sat, 12 Feb 2005 08:06:59 -0500
Received: from rsandifo by firetop.home with local (Exim 4.34)
	id 1CzwzI-00012g-3r
	for linux-mips@linux-mips.org; Sat, 12 Feb 2005 13:07:04 +0000
To:	linux-mips@linux-mips.org
Subject: Possible thinko in driver/net/sb1250-mac.c?
From:	Richard Sandiford <rsandifo@redhat.com>
Date:	Sat, 12 Feb 2005 13:07:04 +0000
Message-ID: <87wttekjuv.fsf@firetop.home>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

[ As usual, I have a feeling I'm either showing my ignorance or
  going over well-trodden ground, but here goes.. ]

I was looking at driver/net/sb1250-mac.c, and I noticed that it
effectively maintains a gap of _two_ empty buffers in the receive ring.
As expected, sbdma_fillring() sets things up so that the gap is only a
single buffer (assuming enough free memory):

        for (idx = 0; idx < SBMAC_MAX_RXDESCR-1; idx++) {
                if (sbdma_add_rcvbuffer(d,NULL) != 0)
                        break;
        }

but the first time sbdma_rx_process() is called, it fails to replace the
buffer it reads with a new one.  The reason is that sbdma_rx_process()
is structured like this:

        if (packet in sb was received OK) {
                if (sbdma_add_rcvbuffer(d,NULL) == -ENOBUFS) {
                        ... Drop the packet and add sb back to the ring ...
                        sbdma_add_rcvbuffer(d,sb);
                } else {
                        ... Hand sb off to netif_rx ...
                }
        } else {
                ... Record the error and add sb back to the ring ...
                sbdma_add_rcvbuffer(d,sb);
        }
        d->sbdma_remptr = SBDMA_NEXTBUF(d,sbdma_remptr);

where sbdma_remptr is only updated _after_ calling
sbdma_add_rcvbuffer().  But sbdma_add_rcvbuffer() uses
sbdma_remptr to check whether the ring is full:

	dsc = d->sbdma_addptr;
	nextdsc = SBDMA_NEXTBUF(d,sbdma_addptr);
	if (nextdsc == d->sbdma_remptr) {
		return -ENOSPC;
	}

So when sbdma_add_rcvbuffer() is called for the first time after
sbdma_fillring(), the call to sbdma_add_rcvbuffer() will fail
with ENOSPC (verified with various printk()s) and no buffer will
be added.

I guess this doesn't matter much if the first packet is received OK.
But if it isn't, and the receive code takes the error path, I think
it'll end up leaking a buffer.

Richard
