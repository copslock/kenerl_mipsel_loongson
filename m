Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA649816 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Feb 1998 13:57:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA00189 for linux-list; Thu, 26 Feb 1998 13:56:42 -0800
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA00169 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Feb 1998 13:56:38 -0800
Received: from wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI)
	 id KAA28856; Fri, 27 Feb 1998 10:53:34 +1300
Message-ID: <34F5E45E.3C8881C0@wellington.sgi.com>
Date: Fri, 27 Feb 1998 10:53:34 +1300
From: Alistair Lambie <alambie@wellington.sgi.com>
X-Mailer: Mozilla 4.04C-SGI [en] (X11; I; IRIX 6.5-ALPHA-1274392335 IP22)
MIME-Version: 1.0
To: "William J. Earl" <wje@fir.engr.sgi.com>
CC: Ulf Carlsson <grimsy@varberg.se>, linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
References: <Pine.LNX.3.96.980226120308.3903B-100000@calypso.saturn> <199802261734.JAA25332@fir.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

William J. Earl wrote:
> 
> Ulf Carlsson writes:
>  > Hello again.
>  >
>  > I'm getting pretty tired. No progress at all. Is my configuration special
>  > in any way?
>  >
>  > System: IP22
>  > Processor: 100 Mhz R4000, with FPU
>  > Primary I-cache size: 8 kbytes
>  > Primary d-cache size: 8 kbytes
>  > Secondary cache size: 1024 Kbytes
>  > Memory size: 32 Mbytes
>  > Graphics: Indy 8-bit
>  > SCSI Disk: scsi(0)disk(4)
>  > SCSI Disk: scsi(0)disk(6)
>  >
>  > Are not all indys almost identical? It's very strange IMO that .72 hangs
>  > before it prints anything on the screen. I think I've tested almost
>  > everything by now.
> ...
> 

Wouldn't be a pre newport graphics machine would it?  Has this been tried?  Just
a thought.

Cheers, Alistair

>      No, there are many different CPU types for the Indy, in order
> of appearance:
> 
>         R4000PC, 100 MHZ
>         R4000SC, 100 MHZ
>         R4600PC, 100 and 133 MHZ
>         R4400SC, 150 and 200 MHZ
>         R4600SC, 133 MHZ
>         R5000PC, 150 and 180 MHZ
>         R5000SC, 180 MHZ
> 
> In the above, "PC" means that there is no secondary cache and "SC"
> means that there is.  The R4000 and R4400 are functionally very similar, except
> for cache size.  The R4600 and R5000 are also similar, but with
> a very different cache organization from the R4000 and R4400.  Various
> revision of the processors (and more than one revision was shipped
> for each processor) have different errata, so the kernel must work around
> various processor errata according to the processor type and revision.
> As I understand it, the currently checked-in source must be recompiled
> to provide R4600/R5000 PC and SC versions for Indy, and those versions
> may not be fully tested on all R4000 and R4400 revisions.  In the not
> distant future, a single kernel will likely support all the processors,
> as does the IRIX kernel, but that is more work than just selecting
> the processor type at compile time.

-- 
Alistair Lambie                         alambie@wellington.sgi.com
Silicon Graphics New Zealand                SGI Voicemail: 2431455
Level 5, Cigna House,                           Ph: +64-4-494 6325
40 Mercer St, Wellington, NZ                   Fax: +64-4-494 6321
