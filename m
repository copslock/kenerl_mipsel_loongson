Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VDbY927614
	for linux-mips-outgoing; Tue, 31 Jul 2001 06:37:34 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VDbVV27611;
	Tue, 31 Jul 2001 06:37:31 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA21635;
	Tue, 31 Jul 2001 06:37:22 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA26287;
	Tue, 31 Jul 2001 06:37:22 -0700 (PDT)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f6VDa7a26933;
	Tue, 31 Jul 2001 15:36:08 +0200 (MEST)
Message-ID: <3B66B4E6.70B80D21@mips.com>
Date: Tue, 31 Jul 2001 15:38:46 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: r4600 flag
References: <3B664857.4040100@pacbell.net> <20010731092822.L27008@rembrandt.csv.ica.uni-stuttgart.de> <20010731112530.A12409@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
>
> In the past we already had inline assembler fragments that left the assembler
> in .misp3 mode thus resulting the rest of the file bein assembled in
> mips3 mode.

Yes, and I'm sure I fixed that so it worked on MIPS32 CPUs, only leaving the
"eret" instructions.

>
> > > Is there a truly correct -mcpu option for a mips32 cpu?
>
> None is really good, none is really bad ...
>
> > In theory, no -mcpu option (which is to be deprecated in
> > favor of -march/-mtune) and -mips32 as ISA flag _should_ work.
> >
> > In practice, the patch which adds this to gas was discussed on the
> > binutils list the last days and is likely to go in CVS
> > today or tomorrow.
>
>   Ralf
