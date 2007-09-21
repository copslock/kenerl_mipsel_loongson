Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 20:44:53 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:16329 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20022036AbXIUTon (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 20:44:43 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8LJi9Zp029963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Sep 2007 12:44:10 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l8LJi9M1019454;
	Fri, 21 Sep 2007 12:44:09 -0700
Date:	Fri, 21 Sep 2007 12:44:09 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac: Driver model & phylib update
Message-Id: <20070921124409.7f3d122b.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64N.0709191811040.24627@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709191811040.24627@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 Sep 2007 12:52:10 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  A driver model and phylib update.

akpm:/usr/src/25> diffstat patches/git-net.patch | tail -n 1
 1013 files changed, 187667 insertions(+), 23587 deletions(-)

Sorry, but raising networking patches against Linus's crufty
old mainline tree just isn't viable at present.
