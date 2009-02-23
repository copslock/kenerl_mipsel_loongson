Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2009 22:42:43 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:28851 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808088AbZBWWml (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2009 22:42:41 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1NMgaiw029144;
	Mon, 23 Feb 2009 22:42:37 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1NMgZMD029142;
	Mon, 23 Feb 2009 22:42:35 GMT
Date:	Mon, 23 Feb 2009 22:42:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Finish fixing CVE-2009-0029.
Message-ID: <20090223224235.GD10434@linux-mips.org>
References: <1235410394-18636-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1235410394-18636-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 23, 2009 at 09:33:14AM -0800, David Daney wrote:

> The initial patch for CVE-2009-0029 lacked a couple of changes in the
> syscall tables.  sys32_sysctl and sys32_ipc were renamed.

Thanks.  I applied the IPC part myself just before receiving this patch so
I'll strip out that part from your patch and apply the rest.

  Ralf
