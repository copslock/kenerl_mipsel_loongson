Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0FKBb330823
	for linux-mips-outgoing; Tue, 15 Jan 2002 12:11:37 -0800
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0FKBVP30820
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 12:11:32 -0800
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (SGI-8.9.3/8.9.3) with ESMTP id UAA76178
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 20:11:22 +0100 (MET)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.33 #1 (Debian))
	id 16QYzS-0007UV-00
	for <linux-mips@oss.sgi.com>; Tue, 15 Jan 2002 20:11:22 +0100
Date: Tue, 15 Jan 2002 20:11:22 +0100
To: linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
Message-ID: <20020115191122.GA28175@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020113211323.A7115@momenco.com> <15426.48692.795968.819750@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15426.48692.795968.819750@gladsmuir.algor.co.uk>
User-Agent: Mutt/1.3.25i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dominic Sweetman wrote:
[snip]
> > I suspect that this is very much a toolchain issue, as I don't think
> > gcc will generate 64-bit addressing code.

gcc does 64bit adressing, but binutils (ld/gas) do only partially yet.

> I suspect that the generic GNU toolchains are pretty buggy when you
> switch on 64-bit MIPS operation; but it's bug-fixes which are needed,
> not wholesale new features.

It needs definitely more than bug fixing. I commited some support
for n64 non-PIC to binutils CVS some time ago, but support for
n64 PIC and n32 still needs to be done.


Thiemo
