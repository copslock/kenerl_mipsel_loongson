Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VCwsq25415
	for linux-mips-outgoing; Tue, 31 Jul 2001 05:58:54 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VCwqV25411
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 05:58:52 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id OAA94906
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 14:58:50 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15RZ6o-00006w-00
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 14:58:50 +0200
Date: Tue, 31 Jul 2001 14:58:50 +0200
To: linux-mips@oss.sgi.com
Subject: Re: r4600 flag
Message-ID: <20010731145850.N27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010731112530.A12409@bacchus.dhis.org>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Tue, Jul 31, 2001 at 09:28:22AM +0200, Thiemo Seufer wrote:
> 
> > > The la macro is split into a lui and a daddiu. The daddiu is not correct 
> > > for a mips32 cpu. Getting rid of the -mcpu=4600 fixes the problem and 
> > > the daddiu is then changed addiu.
> > 
> > This is IIRC a known bug in at least current binutils CVS, a patch
> > to fix it really was already discussed.
> 
> Is this macro expaned by the compiler or assembler?  Just -mcpu=r4600
> should not make cc1 generate any instructions beyond MIPS I.

It's the assembler, -mcpu does not only affect scheduling in gas.
To clean this up -march and -tune were introduced recently to
obsolete -mcpu and -m<cpu> (in both binutils and gcc).


Thiemo
