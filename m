Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 10:40:48 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:37096 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20026438AbYFRJkp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 10:40:45 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5I9eIhF031482;
	Wed, 18 Jun 2008 05:40:18 -0400
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5I9eHVR012805;
	Wed, 18 Jun 2008 05:40:17 -0400
Received: from warthog.cambridge.redhat.com (devserv.devel.redhat.com [10.10.36.72])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id m5I9eFtP023909;
	Wed, 18 Jun 2008 05:40:15 -0400
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K8u9G-0005Co-VG; Wed, 18 Jun 2008 10:40:15 +0100
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From:	David Howells <dhowells@redhat.com>
In-Reply-To: <20080617223332.GM25911@cs181133002.pp.htv.fi>
References: <20080617223332.GM25911@cs181133002.pp.htv.fi>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	dhowells@redhat.com, jbarnes@virtuousgeek.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	gerg@uclinux.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
	lethal@linux-sh.org, linux-sh@vger.kernel.org,
	Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] remove pcibios_update_resource() functions
X-Mailer: MH-E 8.0.3+cvs; nmh 1.2-20070115cvs; GNU Emacs 23.0.50
Date:	Wed, 18 Jun 2008 10:40:14 +0100
Message-ID: <20013.1213782014@redhat.com>
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips

Adrian Bunk <bunk@kernel.org> wrote:

> This patch removes the unused pcibios_update_resource() functions the 
> kernel gained since.

Fine for FRV, since it's #if'd out anyway.

Acked-by: David Howells <dhowells@redhat.com>
