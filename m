Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7LBJwi17549
	for linux-mips-outgoing; Tue, 21 Aug 2001 04:19:58 -0700
Received: from dea.linux-mips.net (u-137-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7LBJp917545
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 04:19:51 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7LBHLe14564;
	Tue, 21 Aug 2001 13:17:21 +0200
Date: Tue, 21 Aug 2001 13:17:21 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: questions about eret....
Message-ID: <20010821131721.F13302@dea.linux-mips.net>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com> <20010821083508.A13302@dea.linux-mips.net> <001201c12a29$57f3b660$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001201c12a29$57f3b660$8021690a@huawei.com>; from dony.he@huawei.com on Tue, Aug 21, 2001 at 06:09:19PM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 21, 2001 at 06:09:19PM +0800, machael thailer wrote:

> Yes.
> But in the sourece codes, when we finish the exception handlers , we will
> run "ret_from_irq" (ret_from_sys_call) in the entry.S and then run macro
> "RESTORE_ALL_AND_RET".  The macro does restore all registers and then ERET.
> But there is not a "CLI" just before ERET as the user manual suggested. Why?
> so when we handle a syscall exception, we do "STI" in the handle_sys(). and
> when ret_from_sys_call and we will run this macro "RESTORE_ALL_AND_RET".
> because there is not a "CLI" just before ERET , is it possible to have some
> problems?

Look again.

  Ralf
