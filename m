Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:59:52 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.4]:31127 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8127231AbWCTE7o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2006 04:59:44 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2K59IDZ027120
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Mar 2006 21:09:19 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k2K59IaR004106;
	Sun, 19 Mar 2006 21:09:18 -0800
Date:	Sun, 19 Mar 2006 21:06:17 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Bring linux-mips in sync with Linus' tree
Message-Id: <20060319210617.744338e1.akpm@osdl.org>
In-Reply-To: <20060320043445.GA20171@deprecation.cyrius.com>
References: <20060320043445.GA20171@deprecation.cyrius.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.131 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr <tbm@cyrius.com> wrote:
>
> The following is a series of six patches to bring the linux-mips tree
>  in sync with Linus' tree.  These are changes that have to be made
>  on the linux-mips side.

Confused.  Isn't all this stuff in Ralf's git tree?  It should be.

That way, it all gets merged when Ralf does his next Linus merge.
