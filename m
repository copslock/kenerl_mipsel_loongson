Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f66IHCr13266
	for linux-mips-outgoing; Fri, 6 Jul 2001 11:17:12 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f66IHBV13263;
	Fri, 6 Jul 2001 11:17:11 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f66IH6021938;
	Fri, 6 Jul 2001 11:17:06 -0700
Message-ID: <3B45FFEA.F8D95F0B@mvista.com>
Date: Fri, 06 Jul 2001 11:14:02 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shaolin Zhang <1&2@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: RTLinux for Mips
References: <004301c10500$be67d820$cd22690a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Shaolin Zhang wrote:
> 
> Hi,
> anyone have experience of rtlinux from fsmlabs ?

Not rtlinux, but I have got the Nigel Gamble's preemptable kernel patch ported
to MIPS.  This patch shrinks the maximum preemption delay of a process to
single digit of milliseconds.

Unless absolutely necessary, I would think preemptable kernel is a better
real-time approach than rtlinux.

Jun
