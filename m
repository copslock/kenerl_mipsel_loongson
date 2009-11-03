Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:25:00 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47516 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493363AbZKCPYy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:24:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA3FQEP3001798;
	Tue, 3 Nov 2009 16:26:15 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA3FQDM6001796;
	Tue, 3 Nov 2009 16:26:13 +0100
Date:	Tue, 3 Nov 2009 16:26:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	David Woodhouse <David.Woodhouse@intel.com>
Subject: Re: [PATCH] MIPS: Alchemy: physmap-flash for all devboards
Message-ID: <20091103152613.GA1742@linux-mips.org>
References: <1255949617-22943-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255949617-22943-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 19, 2009 at 12:53:37PM +0200, Manuel Lauss wrote:

> Replace the devboard NOR MTD mapping driver with physmap-flash support.
> Also honor the "swapboot" switch settings wrt. to the layout of the
> NOR partitions.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks, with David's Ack (from IRC) queued for -2.6.33.

  Ralf
