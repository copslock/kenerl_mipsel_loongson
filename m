Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34GCne22644
	for linux-mips-outgoing; Wed, 4 Apr 2001 09:12:49 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34GCmM22641
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 09:12:48 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id SAA89916
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 18:12:47 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.12 #1 (Debian))
	id 14kpti-0002Xi-00
	for <linux-mips@oss.sgi.com>; Wed, 04 Apr 2001 18:12:42 +0200
Date: Wed, 4 Apr 2001 18:12:42 +0200
To: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
Message-ID: <20010404181242.H5099@rembrandt.csv.ica.uni-stuttgart.de>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <3AC90E16.AEF59359@cotw.com> <20010403041740.G5099@rembrandt.csv.ica.uni-stuttgart.de> <20010403102608.A30531@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010403102608.A30531@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Apr 03, 2001 at 10:26:09AM +0200
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
>On Tue, Apr 03, 2001 at 04:17:40AM +0200, Thiemo Seufer wrote:
>
>> >Without the binutils patch, all binaries compiled for MIPS/Linux
>> >will be IRIX flavored which was the whole problem.
>> 
>> Please may You elaborate about this? AFAICS, the IRIX flavour
>> can't be a problem by itself.
>
>> Changing the MIPS/Linux ABI to circumvent a toolchain bug seems
>> to be a bit extremistic. Am I missing some important details?
>
>IRIX ELF orders the symbol table of object files in a way that violates
>the ABI.  Worse, these IRIX specialities are not documented anywhere.

That would be ok, but, according to the source, there are also
different maximum offsets for ELF_MIPS_GP_OFFSET, which is hardcoded
to IRIX standard in gas, and different section namings like
.MIPS.options vs. .options. 

>Changing to ABI ELF only makes them look as they're supposed to ...

At least the section naming is specified different.


Thiemo
