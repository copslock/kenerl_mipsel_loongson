Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7L7dMw12447
	for linux-mips-outgoing; Tue, 21 Aug 2001 00:39:22 -0700
Received: from dea.linux-mips.net (u-32-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7L7dF912441
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 00:39:15 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7L6Z8m13437;
	Tue, 21 Aug 2001 08:35:08 +0200
Date: Tue, 21 Aug 2001 08:35:08 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: questions about eret....
Message-ID: <20010821083508.A13302@dea.linux-mips.net>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001501c129dd$8acebb80$8021690a@huawei.com>; from dony.he@huawei.com on Tue, Aug 21, 2001 at 09:06:43AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 21, 2001 at 09:06:43AM +0800, machael thailer wrote:

> > >     I have a question to ask about eret.
> > >
> > >     In RC4xxx/RC32334, after eret finished, does it automatically enable
> IE
> > > bit of STATUS register?
> >
> > ERET does not influence the state of the IE bit.
> 
> I agree with you, but the RC32334 User manual (14-13 section) say  it does
> and say we must run a "CLI" just before eret to disable IE bit in Status
> register .

That has a different reason.  Eret takes the return address from the
EPC register and if you'd take an exception between restoring that and the
eret you'd loose it's content - crash boom bang.

  Ralf
