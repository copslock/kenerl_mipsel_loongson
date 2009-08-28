Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Aug 2009 01:02:13 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55965 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493389AbZH1XCG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 29 Aug 2009 01:02:06 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n7SN36NR000492;
	Sat, 29 Aug 2009 00:03:06 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n7SN364W000490;
	Sat, 29 Aug 2009 00:03:06 +0100
Date:	Sat, 29 Aug 2009 00:03:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH v2] Alchemy: override loops_per_jiffy detection
Message-ID: <20090828230305.GB30518@linux-mips.org>
References: <1251393678-28607-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1251393678-28607-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 27, 2009 at 07:21:18PM +0200, Manuel Lauss wrote:

> loops_per_jiffy depends on coreclk speed;  preset it instead of
> letting the kernel waste precious microseconds trying to approximate it.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks, applied.

  Ralf
