Received:  by oss.sgi.com id <S553746AbQJXLbx>;
	Tue, 24 Oct 2000 04:31:53 -0700
Received: from fileserv2.cologne.de ([195.227.25.6]:33616 "HELO
        fileserv2.Cologne.DE") by oss.sgi.com with SMTP id <S553681AbQJXLbb>;
	Tue, 24 Oct 2000 04:31:31 -0700
Received: from localhost (2944 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m13o2IQ-0006vBC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Tue, 24 Oct 2000 13:31:10 +0200 (CEST)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id NAA02750;
	Tue, 24 Oct 2000 13:15:23 +0200
Message-ID: <20001024131523.A2431@excalibur.cologne.de>
Date:   Tue, 24 Oct 2000 13:15:23 +0200
From:   Karsten Merker <karsten@excalibur.cologne.de>
To:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: process lockups
Mail-Followup-To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
References: <20001024044736.B3397@bacchus.dhis.org> <200010240551.HAA02069@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91i
In-Reply-To: <200010240551.HAA02069@sparta.research.kpn.com>; from Houten K.H.C. van (Karel) on Tue, Oct 24, 2000 at 07:51:42AM +0200
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 07:51:42AM +0200, Houten K.H.C. van (Karel) wrote:
> 
> Ralf Baechle wrote:
[hanging processes in status "D"]
> > I observe similar stuck processes on Origins - even without massive I/O
> > load.  I'm trying to track them but little success aside of fixing a few
> > unrelated little bugs.  Do you observe those on your R4k box also?
> On my DEC 5000/260 (R4k) I have no stuck processes, but I should mention
> that I am running without swap (I have 192Mb RAM).

Having swap or not does not seem to influence the behaviour - I also get
hangs with swap disabled. Good candidates for hangig are either tar or
gcc.

> > Another things which I'm observing is that I occasinally can't unmount
> > a filesystem.  umount then says the fs is still in use.  Sometimes it's
> > at least possible to remount the fs r/o.  Have you also observed this one?
> Yes, but only the root FS. I thought I might have to upgrade to a newer
> mount program for the 2.4 kernel, or is the system call returning the error?

Similar effect here - sometimes unmounting the root fs on shutdown is
successfull, sometimes I get "/ is busy" without being able to find a
reason for that. Possibly it is a bug in the mount (I am still running
mount-2.9o).

> > > Another thing I see on my 5000/150 (and only there - this is my only
> > > R4K-machine, so I do not know whether this is CPU- or machine-type-bound)
> > > is "top" going weird, eating lots of CPU cycles and spitting messages
> > > "schedule_timeout: wrong timeout value fffbd0b2 from 800900f8; Setting
> > > flush to zero for top". I know Florian also has this on his 5000/150.
> > > Anyone else with the same behavoiur or any idea about the cause for this?
> > 
> > Setting flush to zero for <process name> means that the floating point
> > approximator is now enabled ;-)

???

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
