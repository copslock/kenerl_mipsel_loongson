Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VBRCt19554
	for linux-mips-outgoing; Tue, 31 Jul 2001 04:27:12 -0700
Received: from dea.waldorf-gmbh.de (u-145-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.145])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VBR5V19547
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 04:27:06 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6V9PVQ12732;
	Tue, 31 Jul 2001 11:25:31 +0200
Date: Tue, 31 Jul 2001 11:25:31 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: r4600 flag
Message-ID: <20010731112530.A12409@bacchus.dhis.org>
References: <3B664857.4040100@pacbell.net> <20010731092822.L27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010731092822.L27008@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Tue, Jul 31, 2001 at 09:28:22AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 31, 2001 at 09:28:22AM +0200, Thiemo Seufer wrote:

> > The la macro is split into a lui and a daddiu. The daddiu is not correct 
> > for a mips32 cpu. Getting rid of the -mcpu=4600 fixes the problem and 
> > the daddiu is then changed addiu.
> 
> This is IIRC a known bug in at least current binutils CVS, a patch
> to fix it really was already discussed.

Is this macro expaned by the compiler or assembler?  Just -mcpu=r4600
should not make cc1 generate any instructions beyond MIPS I.

In the past we already had inline assembler fragments that left the assembler
in .misp3 mode thus resulting the rest of the file bein assembled in
mips3 mode.

> > Is there a truly correct -mcpu option for a mips32 cpu?

None is really good, none is really bad ...

> In theory, no -mcpu option (which is to be deprecated in
> favor of -march/-mtune) and -mips32 as ISA flag _should_ work.
> 
> In practice, the patch which adds this to gas was discussed on the
> binutils list the last days and is likely to go in CVS
> today or tomorrow.

  Ralf
