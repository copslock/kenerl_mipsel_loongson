Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7LBGq817443
	for linux-mips-outgoing; Tue, 21 Aug 2001 04:16:52 -0700
Received: from dea.linux-mips.net (u-137-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7LBGh917435
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 04:16:48 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7LBEG314545;
	Tue, 21 Aug 2001 13:14:16 +0200
Date: Tue, 21 Aug 2001 13:14:16 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: questions about some bits of STATUS register and exception priority...
Message-ID: <20010821131416.E13302@dea.linux-mips.net>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001901c129e1$5aaaadc0$8021690a@huawei.com> <20010821085353.B13302@dea.linux-mips.net> <001901c12a2f$8626be00$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001901c12a2f$8626be00$8021690a@huawei.com>; from dony.he@huawei.com on Tue, Aug 21, 2001 at 06:53:34PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 21, 2001 at 06:53:34PM +0800, machael thailer wrote:

> > In the Linux kernel CU0 is used to indicate that we're running on the
> > kernel stack.
> 
> Yes, when CU0 is 1, we can see we are running on the kernel stack.
> But when CU0 is 0, can we say it is in User mode?

No, think of the tlb exception handlers for example.

  Ralf
