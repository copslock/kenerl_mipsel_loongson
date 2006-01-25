Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 00:15:08 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:4280 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S8133576AbWAYAOv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2006 00:14:51 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k0P0JcYi021761;
	Wed, 25 Jan 2006 00:19:39 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k0P0Jcfa021760;
	Wed, 25 Jan 2006 00:19:38 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH 2.6] Cobalt IDE fix, again
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20060125001303.GA2569@colonel-panic.org>
References: <20060125001303.GA2569@colonel-panic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Wed, 25 Jan 2006 00:19:36 +0000
Message-Id: <1138148377.21723.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Mer, 2006-01-25 at 00:13 +0000, Peter Horton wrote:
> Fix long delay during Cobalt boot whilst scanning non-existent
> interfaces. The logic is copied from i386 i.e. we only scan 2 legacy
> ports if we have PCI IDE.

Looks good to me now.

Alan
