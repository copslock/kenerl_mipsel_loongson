Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2009 11:46:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50433 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492780AbZFPJqP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jun 2009 11:46:15 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5G9VZ4F010306;
	Tue, 16 Jun 2009 10:36:55 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5G9VYRW010304;
	Tue, 16 Jun 2009 10:31:34 +0100
Date:	Tue, 16 Jun 2009 10:31:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Kroah-Hartman <gregkh@suse.de>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 54/64] mips: remove driver_data direct access of struct
	device
Message-ID: <20090616093134.GA28585@linux-mips.org>
References: <20090616051351.GA23627@kroah.com> <1245131213-24168-54-git-send-email-gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1245131213-24168-54-git-send-email-gregkh@suse.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 15, 2009 at 10:46:43PM -0700, Greg Kroah-Hartman wrote:

> In the near future, the driver core is going to not allow direct access
> to the driver_data pointer in struct device.  Instead, the functions
> dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
> have been around since the beginning, so are backwards compatible with
> all older kernel versions.
> 
> Cc: linux-mips@linux-mips.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks, applied.

  Ralf
