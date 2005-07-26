Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2005 15:17:25 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:18167 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225733AbVGZORI>;
	Tue, 26 Jul 2005 15:17:08 +0100
Received: MO(mo00)id j6QEJYsA018339; Tue, 26 Jul 2005 23:19:34 +0900 (JST)
Received: MDO(mdo01) id j6QEJXCw007005; Tue, 26 Jul 2005 23:19:34 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j6QEJWGm003046
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 26 Jul 2005 23:19:33 +0900 (JST)
Date:	Tue, 26 Jul 2005 23:19:31 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] vr41xx: update system type
Message-Id: <20050726231931.578aedd7.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050722161558.GB3126@linux-mips.org>
References: <20050722233644.0269a853.yuasa@hh.iij4u.or.jp>
	<20050722161558.GB3126@linux-mips.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 22 Jul 2005 12:15:58 -0400
Ralf Baechle <ralf@linux-mips.org> wrote:

> I assume you did consider the compatibility issues arrising from such
> a change ...
> 
> Was contemplating if some sort of structured system name such as
> vr41xx/workpad would make sense for SOCs.  A software installer could
> use a pattern like vr41xx/* to match all VR41xx systems avoiding the
> need to add all system names to an installer which I believe Debian
> does.  Such a naming scheme would be useful for any family of very
> similar machines, especially SOCs such as the RM9000 family or the
> Sibyte family.

We had never distinguished the one from the system based on
the NEC VR4100 series. I think that this change does not give the impact
to the installer and other software. 

Yoichi
