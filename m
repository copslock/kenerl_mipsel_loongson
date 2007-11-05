Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 11:47:15 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:23484 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029905AbXKELrN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Nov 2007 11:47:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA5BkvWC029814;
	Mon, 5 Nov 2007 11:46:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA5BkuSa029777;
	Mon, 5 Nov 2007 11:46:56 GMT
Date:	Mon, 5 Nov 2007 11:46:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use strchr instead of strstr in mips/fw/arc/cmdline.c
Message-ID: <20071105114655.GF27893@linux-mips.org>
References: <472B7379.4030003@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472B7379.4030003@tiscali.nl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 02, 2007 at 07:59:05PM +0100, Roel Kluin wrote:

> Use strchr instead of strstr when searching for a single character
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Thanks, queued for 2.6.25.

  Ralf
