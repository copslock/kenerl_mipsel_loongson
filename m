Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 18:20:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9168 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133712AbWCGSU3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2006 18:20:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k27ISsOK016998;
	Tue, 7 Mar 2006 18:28:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k27ISjJt016997;
	Tue, 7 Mar 2006 18:28:45 GMT
Date:	Tue, 7 Mar 2006 18:28:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg KH <gregkh@suse.de>
Cc:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>, Greg KH <greg@kroah.com>,
	Martin Michlmayr <tbm@cyrius.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [PATCH] Buglet in Alchemy OHCI driver
Message-ID: <20060307182845.GA16685@linux-mips.org>
References: <DAF42D2FFC65A146BAB240719E4AD214EE459A@gbrwgceumf02.eu.xerox.net> <20060307165445.GA6623@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307165445.GA6623@suse.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 07, 2006 at 08:54:45AM -0800, Greg KH wrote:

Again that's been a bug report against the wrong tree - it was broken in
the MIPS tree only and is fixed since this morning.

  Ralf
