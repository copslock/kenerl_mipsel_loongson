Received:  by oss.sgi.com id <S553952AbRA1CzZ>;
	Sat, 27 Jan 2001 18:55:25 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:53510 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S553946AbRA1CzK>;
	Sat, 27 Jan 2001 18:55:10 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA08402
	for <linux-mips@oss.sgi.com>; Sat, 27 Jan 2001 18:55:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870777AbRA0TQi>; Sat, 27 Jan 2001 11:16:38 -0800
Date: 	Sat, 27 Jan 2001 11:16:38 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Pete Popov" <ppopov@mvista.com>,
        "Steve Johnson" <stevej@ridgerun.com>, <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
Message-ID: <20010127111638.H867@bacchus.dhis.org>
References: <3A6F8F66.6258801@mvista.com> <0101241833281Q.00834@plugh.sibyte.com> <3A6F9814.3E39027@mvista.com> <0101241917341S.00834@plugh.sibyte.com> <3A703E3C.360FB4FF@ridgerun.com> <3A706A22.6B760617@mvista.com> <010601c08780$d0b8a7a0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <010601c08780$d0b8a7a0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Jan 26, 2001 at 11:14:38AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 11:14:38AM +0100, Kevin D. Kissell wrote:

> I had essentially the same problem at MIPS a year or two ago,
> and I could have *sworn* that my fix, which ORed ST0_FR into
> the initial Status register value set in the startup assembly code,
> had made it into the standard distributions.  It's at about line 530
> of head.S, where a term is added to make the instruction
> 
> li t1,~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX|ST0_FR)

It's not in the CVS 2.2 kernel.  I've added this patch to my kernel and
will commit it when I'm online again.

  Ralf
