Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V7SUL06968
	for linux-mips-outgoing; Tue, 31 Jul 2001 00:28:30 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V7SSV06965
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 00:28:29 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id JAA91378
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 09:28:25 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15RTx0-0008FR-00
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 09:28:22 +0200
Date: Tue, 31 Jul 2001 09:28:22 +0200
To: linux-mips@oss.sgi.com
Subject: Re: r4600 flag
Message-ID: <20010731092822.L27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B664857.4040100@pacbell.net>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:
> in arch/mips/Makefile, we use the -mcpu=r4600 flag for MIPS32. What's 
> interesting is that the use of this flag can cause the toolchain to 
> generate incorrect code.

Which toolchain versions, what patches applied to it?

> For example:
> 
> la k0, 1f
> nop
> 1: nop
> 
> 
> The la macro is split into a lui and a daddiu. The daddiu is not correct 
> for a mips32 cpu. Getting rid of the -mcpu=4600 fixes the problem and 
> the daddiu is then changed addiu.

This is IIRC a known bug in at least current binutils CVS, a patch
to fix it really was already discussed.

> Is there a truly correct -mcpu option for a mips32 cpu?

In theory, no -mcpu option (which is to be deprecated in
favor of -march/-mtune) and -mips32 as ISA flag _should_ work.

In practice, the patch which adds this to gas was discussed on the
binutils list the last days and is likely to go in CVS
today or tomorrow.


Thiemo
