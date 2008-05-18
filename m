Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 May 2008 05:40:27 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:24559 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28573880AbYEREkZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 May 2008 05:40:25 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4I4e1BM014328;
	Sun, 18 May 2008 06:40:01 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4I4dmpE014319;
	Sun, 18 May 2008 05:39:48 +0100
Date:	Sun, 18 May 2008 05:39:47 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	john stultz <johnstul@us.ibm.com>
cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/4] RTC: Class device support for persistent clock
In-Reply-To: <1f1b08da0805071418q365680bexafb1996dcc77ebb0@mail.gmail.com>
Message-ID: <Pine.LNX.4.55.0805160356570.519@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
 <1f1b08da0805071418q365680bexafb1996dcc77ebb0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi John,

 Sorry about the delay -- I have missed your comment in the flood.

On Wed, 7 May 2008, john stultz wrote:

> >   As rtc_read_persistent_clock() is not available at the time
> >  timekeeping_init() is called, it will now be disabled if the class device
> >  is to be used as a reference.  In this case rtc_hctosys(), already
> >  present, will be used to set up the system time at the late initcall time.
> >  This call has now been rewritten to make use of
> >  rtc_read_persistent_clock().
> 
> Hrmm. So how is this going to work with suspend and resume?

 Hmm, I have never used suspend/resume, so I cannot really comment.  Here
is what I gathered by glancing over the code and some bits of
documentation.

> Ideally, on resume we want to update the clock before interrupts are
> reenabled so we don't get stale time values post-resume.  For systems
> that sleep on reading the persistent clock, I'm open to having them
> fix it up as best they can later (partly why the code can handle
> read_persistent_clock() not returning anything), but unless I'm
> misreading this, it seems you're proposing to make systems that do
> have a safe persistent clock have to have the window where code may
> see the pre-suspend time after resume.

 Right now it looks the time is restored in two places, 
timekeeping_resume() and rtc_resume().  Of course once the transition to 
the new RTC infrastructure has been done, one is going to be redundant.  
For the time being I think it is harmless to have them both.

 That written, both are called from the relevant driver's ->resume()  
method.  My set of patches does not change it and as far as I can tell if
it worked before, it will work afterwards.  As I understand ->resume()  
methods may sleep and are called with interrupts already enabled.
 
> Am I missing something here?

 No idea -- anyone?

  Maciej
