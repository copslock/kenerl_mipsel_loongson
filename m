Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 05:31:57 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:57085 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224788AbVASFbw>;
	Wed, 19 Jan 2005 05:31:52 +0000
Received: MO(mo00)id j0J5VlAl027728; Wed, 19 Jan 2005 14:31:47 +0900 (JST)
Received: MDO(mdo01) id j0J5VkB1022109; Wed, 19 Jan 2005 14:31:47 +0900 (JST)
Received: 4UMRO01 id j0J5VkCk013108; Wed, 19 Jan 2005 14:31:46 +0900 (JST)
	from rally (localhost [127.0.0.1]) (authenticated)
Date: Wed, 19 Jan 2005 14:31:46 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-Id: <20050119143146.09982d63.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.61L.0501190502070.26851@blysk.ds.pg.gda.pl>
References: <20050115013112Z8225557-1340+1316@linux-mips.org>
	<20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.61L.0501190502070.26851@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Wed, 19 Jan 2005 05:04:32 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Wed, 19 Jan 2005, Yoichi Yuasa wrote:
> 
> > arch/mips/vr41xx/common/giu.c and icu.c need <linux/config.h>
> > I,m going to update 2 files soon.
> 
>  Neither of these uses any CONFIG_* macros.

I'm making patch for giu.c and icu.c.
These patches need it. 

I'll send these patches as soon as possible.

Yoichi
