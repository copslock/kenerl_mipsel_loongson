Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 18:27:18 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:64720 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366066AbZA3S1Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2009 18:27:16 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0UIREkb024835;
	Fri, 30 Jan 2009 18:27:14 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0UIR8T8024821;
	Fri, 30 Jan 2009 18:27:08 GMT
Date:	Fri, 30 Jan 2009 18:27:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/3] Alchemy: provide cpu feature overrides.
Message-ID: <20090130182708.GB22790@linux-mips.org>
References: <1233336611-6450-1-git-send-email-mano@roarinelk.homelinux.net> <1233336611-6450-2-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1233336611-6450-2-git-send-email-mano@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 30, 2009 at 06:30:10PM +0100, Manuel Lauss wrote:

> +#define cpu_has_pindexed_cache		0

cpu_has_pindexed_cache does no longer exist.

  Ralf
