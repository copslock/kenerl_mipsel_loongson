Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HBdBs31534
	for linux-mips-outgoing; Fri, 17 Aug 2001 04:39:11 -0700
Received: from dea.waldorf-gmbh.de (u-214-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.214])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HBd8j31531
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 04:39:08 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7HBbEL05267;
	Fri, 17 Aug 2001 13:37:14 +0200
Date: Fri, 17 Aug 2001 13:37:14 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Where is the first entry point for linux-mips boot?
Message-ID: <20010817133714.A5226@bacchus.dhis.org>
References: <000701c11c8b$77e039e0$8021690a@huawei.com> <20010804071016.A1275@bacchus.dhis.org> <001501c126ca$4a5331a0$8021690a@huawei.com> <20010817052635.A2931@bacchus.dhis.org> <000901c12704$bf95c2e0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000901c12704$bf95c2e0$8021690a@huawei.com>; from dony.he@huawei.com on Fri, Aug 17, 2001 at 06:09:48PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 17, 2001 at 06:09:48PM +0800, machael thailer wrote:

> If I load the kernel to RAM address 0x80200000, is this a virtual address or
> physical address at this time? Since my RAM can not be so large, I guess
> this is virtual address,right? Should I enable MMU in my board
> initializations?

A virtual address in KSEG0.  A MIPS MMU has no enable bit, it's always
active.

  Ralf
