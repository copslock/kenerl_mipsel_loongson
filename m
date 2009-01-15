Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 19:59:22 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10562 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365965AbZAOT7T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 19:59:19 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496f95910001>; Thu, 15 Jan 2009 14:59:13 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 11:58:50 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 11:58:49 -0800
Message-ID: <496F9579.7050300@caviumnetworks.com>
Date:	Thu, 15 Jan 2009 11:58:49 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 06/14] MIPS: print irq handler description
References: <cover.1229846410.git.mano@roarinelk.homelinux.net> <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net> <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net> <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net> <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net> <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net> <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net> <496F90AA.7070407@caviumnetworks.com> <20090115194921.GB8656@roarinelk.homelinux.net>
In-Reply-To: <20090115194921.GB8656@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2009 19:58:49.0781 (UTC) FILETIME=[AEED4E50:01C9774B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
[...]
> Or how about this?
> 
[...]  		seq_printf(p, " %14s", irq_desc[i].chip->name);
> -		seq_printf(p, "-%-8s", irq_desc[i].name);
> +		if (irq_desc[i].name)
> +			seq_printf(p, "-%-8s", irq_desc[i].name);
>  		seq_printf(p, "  %s", action->name);

I will let you and Ralf decide.  However it would be nice if 
action->name lined up with a mixture of NULL and non-NULL 
irq_desc[i].name.  It is not clear to me if this is the case with your 
patch.

David Daney
