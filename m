Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 12:21:40 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:16534 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20024655AbXIDLVb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 12:21:31 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l84BL6CT020541;
	Tue, 4 Sep 2007 04:21:06 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l84BLLgN014503;
	Tue, 4 Sep 2007 04:21:22 -0700 (PDT)
Message-ID: <006f01c7eee5$bbe77c60$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"yshi" <yang.shi@windriver.com>
Cc:	<linux-mips@linux-mips.org>
References: <46DD1CD1.5040306@windriver.com> <006901c7eeda$d8049a50$10eca8c0@grendel> <1188901951.4106.16.camel@yshi.CORP>
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
Date:	Tue, 4 Sep 2007 13:21:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> 在 2007-09-04二的 12:03 +0200，Kevin D. Kissell写道：
> > The 4KEc is a MIPS32 Release 2 processor, for which the implementation
> > of the Cause.TI bit (bit 30) is required.  You may have a defective board
> > or a bad FPGA bitfile.  Please work with your support contacts at MIPS
> > to verify that this is not the case.  It may also be that there's something more
> > subtle going on in the interrupt processing, such that the Cause.TI bit is being
> > cleared before it can be sampled by the code you've changed.  But while the
> > patch below presumably solves the symptoms of your problem, I really
> > don't think that a kernel hack based on detecting CoreFPA3 is an appropriate
> > solution.  I work every day with Malta/CoreFPGA3 bitfiles and have not
> > seen Cause.TI fail to function in any of the Release 2 core bitfiles I've used.
>
> My board's core is Release 1 core. So Cause.TI bit always is zero. Maybe
> I need update this patch to reflect this, i.e add #ifdef to distinguish
> Release 1 and Release 2. Thanks.

In that case, your core is a 4Kc and not a 4KEc.  The "r2" value in the
code you're looking at should therefore be zero.  I don't have the rest
of the kernel tree you're using in front of me, but I can't help but suspect
that either cpu_has_mips_r2 has a broken definition, or that handle_iperf_irq()
isn't correctly setting its return value if the r2 argument is zero.  There
should in principle be no need to add more #ifdefs than there already are
in the code in question.

            Regards,

            Kevin K.
