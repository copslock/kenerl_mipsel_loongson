Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2007 01:48:39 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41947 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20023645AbXIGAsb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Sep 2007 01:48:31 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l870lxX7027239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Sep 2007 17:48:04 -0700
Received: from sony (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l870hcUq016089;
	Thu, 6 Sep 2007 17:43:39 -0700
Date:	Thu, 6 Sep 2007 17:41:02 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, ejka@imfi.kspu.ru, jgarzik@pobox.com,
	netdev@vger.kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
	pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
	kaber@coreworks.de
Subject: Re: [PATCH][MIPS][7/7] AR7: ethernet
Message-Id: <20070906174102.cc5a59e5.akpm@linux-foundation.org>
In-Reply-To: <200709070121.42629.technoboy85@gmail.com>
References: <200708201704.11529.technoboy85@gmail.com>
	<200709061734.11170.technoboy85@gmail.com>
	<20070906153025.7cb71cb1.akpm@linux-foundation.org>
	<200709070121.42629.technoboy85@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

> On Fri, 7 Sep 2007 01:21:41 +0200 Matteo Croce <technoboy85@gmail.com> wrote:
> > The patch introduces vast number of volatile structure fields.  Please see
> > Documentation/volatile-considered-harmful.txt.
> 
> Removing them and the kernel hangs at module load

They can't just be removed.  Please see the document.  There are I/O APIs
which, if properly used, make volatile unneeded.
