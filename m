Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 11:05:19 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:53157 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123891AbSJAJFS>;
	Tue, 1 Oct 2002 11:05:18 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g91958rZ001701;
	Tue, 1 Oct 2002 02:05:08 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA18692;
	Tue, 1 Oct 2002 02:05:32 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g91957b28748;
	Tue, 1 Oct 2002 11:05:07 +0200 (MEST)
Message-ID: <3D996542.A66BDA70@mips.com>
Date: Tue, 01 Oct 2002 11:05:06 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Nugent <mips@illuminatus.org>
CC: linux-mips@linux-mips.org
Subject: Re: scatterlist.h
References: <1033462118.13267.97.camel@templar>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Try to check out the latest sources, I believe this has been fixed already.

/Carsten




Mike Nugent wrote:

> Next problem  ( I know you all love my by now :)
>
> in drivers/scsi/scsi_merge.c
>
> scsi_merge.c:939: structure has no member named `page'
>
> line 939: sgpnt[count - 1].page = NULL;
>
> (struct scatterlist *sgpnt;  included from scsi.h, which includes
> asm/scatterlist.h)
>
> struct scatterlist {
>     char *  address;    /* Location data is to be transferred to */
>     unsigned int length;
>
>     __u32 dvma_address;
> };
>
> Yes!  It's right!  No member page!
>
> >From 2.4.16:
>
> struct scatterlist {
>         char * address;         /* Location data is to be transferred to */
>         struct page * page;     /* Location for highmem page, if any */
>         unsigned int length;
>         __u32 dvma_address;
> };
>
> I suggest we put that variable back into the structure.
>
> There's more to come, but it's almost 2 am and it's bedtime.  I'll send
> the next one out tomorrow if no one writes me back to tell me I'm
> nuts/not using the right code/can't reproduce the error/etc.
>
> --
> Mike Nugent
> Programmer/Author
> mike@illuminatus.org
> "I believe the use of noise to make music will increase until we reach a
> music produced through the aid of electrical instruments which will make
> available for musical purposes any and all sounds that can be heard."
>  -- composer John Cage, 1937

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
