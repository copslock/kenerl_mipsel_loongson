Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B6F9Rw012756
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 23:15:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B6F9Ap012755
	for linux-mips-outgoing; Wed, 10 Jul 2002 23:15:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B6EwRw012743;
	Wed, 10 Jul 2002 23:14:59 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6B6JKXb010809;
	Wed, 10 Jul 2002 23:19:20 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA29604;
	Wed, 10 Jul 2002 23:19:19 -0700 (PDT)
Message-ID: <005c01c228a2$fb2bf450$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "H. J. Lu" <hjl@lucon.org>
Cc: "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
References: <3D2CBF73.50001@mvista.com> <20020710164900.A28911@lucon.org> <20020711043601.B3207@dea.linux-mips.net>
Subject: Re: Malta crashes on the latest 2.4 kernel
Date: Thu, 11 Jul 2002 08:19:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.7 required=5.0 tests=PORN_12,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Wed, Jul 10, 2002 at 04:49:00PM -0700, H. J. Lu wrote:
> 
> > > See the crash scene.  Anybody knows the cause?  It is strange to see the 
> > > reserved exception.
> > > 
> > 
> > The 2.4 kernel checked out around Jul  4 09:28 PDT works fine on Malta.
> 
> Jun's patch certainly is correct for some MIPS32 CPUs; others may get
> away without this one.  Previous experience with pipeline hazards on MIPS
> processors has shown that at times hazards may change even between minor
> revisions of a CPU; documentation isn't always trustworthy about such
> minor details of the pipeline.

Excuse me, but I've seen this statement used by others in
the past as an excuse for doing something silly or not doing
something reasonable, and it generally hasn't washed.
In what specific cases have the CP0 pipeline hazards 
changed between minor revisions of any production
MIPS CPU?  The *documentation* may have been
corrected, but these hazards are fairly fundamental
artifacts of the pipeline microarchitecture of a given
processor.

The CP0 hazard between a write of EntryHi
and a subsequent TLBWI instruction is flagged
in the MIPS32 spec and noted as being "typically" 
2 cycles.  I'm not going to spend the time going
through my full set of users manuals, but a representative
sampling shows this hazard as being specified for
every R4xxx and R5xxx CPU I checked.  The fact
that a given CPU *may* get away with it is no
excuse for not protecting common code.

I note that Ralf has, in fact, applied the fix to the
OSS CVS repository.  I also note that "BARRIER"
is still defined to be a string of 6 nops.  I would argue
(again) that those really, really ought to be ssnops,
and that if they *were* ssnops, one could probably
have fewer of them.

            Regards,

            Kevin K.
