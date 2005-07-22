Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 21:46:03 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:57268 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225370AbVGVUoK>; Fri, 22 Jul 2005 21:44:10 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6MGG1fS015685;
	Fri, 22 Jul 2005 12:16:01 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6MGFw5Q015684;
	Fri, 22 Jul 2005 12:15:58 -0400
Date:	Fri, 22 Jul 2005 12:15:58 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] vr41xx: update system type
Message-ID: <20050722161558.GB3126@linux-mips.org>
References: <20050722233644.0269a853.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722233644.0269a853.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 22, 2005 at 11:36:44PM +0900, Yoichi Yuasa wrote:

> I decided to use common system type on vr41xx. 
> Please apply this patch.

Applied, thanks.

I assume you did consider the compatibility issues arrising from such
a change ...

Was contemplating if some sort of structured system name such as
vr41xx/workpad would make sense for SOCs.  A software installer could
use a pattern like vr41xx/* to match all VR41xx systems avoiding the
need to add all system names to an installer which I believe Debian
does.  Such a naming scheme would be useful for any family of very
similar machines, especially SOCs such as the RM9000 family or the
Sibyte family.

  Ralf
