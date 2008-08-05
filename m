Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 17:02:12 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:55630 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20023932AbYHEQCF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 17:02:05 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Tue,  5 Aug 2008 16:01:57 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 05 Aug 2008 11:02:17 -0500
Subject: Re: [PATCH] au1200fb: fixup PM support.
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-fbdev-devel@lists.sf.net, L-M-O <linux-mips@linux-mips.org>
In-Reply-To: <20080805124221.GA27469@roarinelk.homelinux.net>
References: <20080805124221.GA27469@roarinelk.homelinux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Tue, 05 Aug 2008 11:02:17 -0500
Message-Id: <1217952137.23188.2.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Tue, 2008-08-05 at 14:42 +0200, Manuel Lauss wrote:
> Remove last traces of the custom Alchemy linux-2.4 PM code, implement
> suspend/resume callbacks.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/video/au1200fb.c |  164 ++++++++++++----------------------------------
>  1 files changed, 41 insertions(+), 123 deletions(-)
> 
This looks good.  It applied to my tree and appears functional on my
board.  One question: what about dynamic brightness?  It was part of the
old PM interface and you seem to have removed it.  Any ideas about
re-integrating that into the current PM model?

Acked-by: Kevin Hickey <khickey@rmicorp.com>

-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
