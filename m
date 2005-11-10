Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 14:02:54 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([210.130.0.20]:13026 "EHLO mo01.iij4u.or.jp")
	by ftp.linux-mips.org with ESMTP id S3458217AbVKJOCg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2005 14:02:36 +0000
Received: MO(mo01)id jAAE43d7008599; Thu, 10 Nov 2005 23:04:03 +0900 (JST)
Received: MDO(mdo01) id jAAE42E4014330; Thu, 10 Nov 2005 23:04:02 +0900 (JST)
Received: from stratos (h057.p117.iij4u.or.jp [210.130.117.57])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id jAAE41Q0005306
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Thu, 10 Nov 2005 23:04:01 +0900 (JST)
Date:	Thu, 10 Nov 2005 23:04:00 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	"oski" <oski2001@hotmail.com>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: Compiling a kernel for ibm z50
Message-Id: <20051110230400.18ec5e37.yuasa@hh.iij4u.or.jp>
In-Reply-To: <BAY101-DAV23A6C8A228DAC9FF185F3D2650@phx.gbl>
References: <BAY101-DAV18ABC35208B50E0535A360D2650@phx.gbl>
	<20051108073105.468cd5f4.yuasa@hh.iij4u.or.jp>
	<BAY101-DAV23A6C8A228DAC9FF185F3D2650@phx.gbl>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

The latest MIPS v2.4 kernel has no problem.
Please try the latest one.

On Mon, 7 Nov 2005 22:53:33 -0000
"oski" <oski2001@hotmail.com> wrote:

> Hi,
> 
> I am using linux-2.4.30-mipscvs-20050515.
> 
> oski
> 
> ----- Original Message ----- 
> From: "Yoichi Yuasa" <yuasa@hh.iij4u.or.jp>
> To: "oski" <oski2001@hotmail.com>
> Cc: <linux-mips@linux-mips.org>
> Sent: Monday, November 07, 2005 10:31 PM
> Subject: Re: Compiling a kernel for ibm z50
> 
> 
> > Hi,
> >
> > On Mon, 7 Nov 2005 18:07:42 -0000
> > "oski" <oski2001@hotmail.com> wrote:
> >
> > > Hi,
> > > I am still having problems when compiling thfe kernel.
> > > I get an Error and the last lines are:
> > > init/do_mounts.o: In function "mount_root"
> > > do_mounts.c: (.text.init+0x7e8): undefined reference to "ip_auto_config"
> > > do_mounts.c: (.text.init+0x7e8): relocation truncated to fit:R_MIPS_26
> > > against "ip_auto_config"
> > > make: *** (vmlinux) Error 1
> > >
> > > Any suggestions?
> >
> > Which kernel version do you use?
> >
> > Yoichi
> >
> >
> 
