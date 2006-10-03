Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2006 02:02:15 +0100 (BST)
Received: from p549F5BCD.dip.t-dialin.net ([84.159.91.205]:21705 "EHLO
	p549F5BCD.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20038942AbWJDBCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Oct 2006 02:02:11 +0100
Received: from smtp.osdl.org ([65.172.181.4]:63887 "EHLO smtp.osdl.org")
	by lappi.linux-mips.net with ESMTP id S1100430AbWJCXqR (ORCPT
	<rfc822;linux-mips@linux-mips.org> + 1 other);
	Wed, 4 Oct 2006 01:46:17 +0200
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k93NgsaX021601
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Oct 2006 16:42:56 -0700
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k93NgrP8017346;
	Tue, 3 Oct 2006 16:42:54 -0700
Date:	Tue, 3 Oct 2006 16:42:53 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [patch 4/6] 2.6.18: sb1250-mac: The actual driver update
Message-Id: <20061003164253.62f9d5a3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0610031549270.4642@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0610031549270.4642@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Tue, 3 Oct 2006 16:18:44 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> +	sbmac_state_t		sbm_state;	/* current state */

argh.

The reader looks at this and doesn't know if it's an integer, a void*, a
struct usb_ac_header_descriptor** or what.

	enum sbmac_state	smb_state;

is nicer.  It has information.
