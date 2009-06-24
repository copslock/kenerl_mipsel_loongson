Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 10:04:35 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54568 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492590AbZFXIE2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jun 2009 10:04:28 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5O80l8g019290;
	Wed, 24 Jun 2009 09:00:48 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5O80l0e019288;
	Wed, 24 Jun 2009 09:00:47 +0100
Date:	Wed, 24 Jun 2009 09:00:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, gregkh@suse.de
Subject: Re: [PATCH] Staging: octeon-ethernet: Fix race freeing transmit
	buffers.
Message-ID: <20090624080047.GB9358@linux-mips.org>
References: <1245799256-5095-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1245799256-5095-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 23, 2009 at 04:20:56PM -0700, David Daney wrote:

Thanks, applied.

  Ralf
