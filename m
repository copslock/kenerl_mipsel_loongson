Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2009 23:25:08 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52992 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493735AbZG2VZA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Jul 2009 23:25:00 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6TLP7cA007879;
	Wed, 29 Jul 2009 22:25:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6TLP6QY007876;
	Wed, 29 Jul 2009 22:25:06 +0100
Date:	Wed, 29 Jul 2009 22:25:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roel Kluin <roel.kluin@gmail.com>
Cc:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MIPS: Read buffer overflow
Message-ID: <20090729212506.GB3489@linux-mips.org>
References: <4A70AAED.3040404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A70AAED.3040404@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 29, 2009 at 10:02:53PM +0200, Roel Kluin wrote:

> it should tests against ARRAY_SIZE(psp_var_map) instead of sizeof(psp_var_map)

Thanks, applied.

  Ralf
