Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 10:23:26 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:26613 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225265AbSLEJXZ>;
	Thu, 5 Dec 2002 10:23:25 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB59NCNf028392;
	Thu, 5 Dec 2002 01:23:12 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA07377;
	Thu, 5 Dec 2002 01:23:08 -0800 (PST)
Message-ID: <009d01c29c40$85ccd9b0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>,
	"Carsten Langgaard" <carstenl@mips.com>
Cc: <linux-mips@linux-mips.org>, <jsun@mvista.com>
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <3DEDD414.3854664F@mips.com> <20021204141900.U4363@mvista.com>
Subject: Re: possible Malta 4Kc cache problem ...
Date: Thu, 5 Dec 2002 10:27:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Wed, Dec 04, 2002 at 11:08:20AM +0100, Carsten Langgaard wrote:
> > I have just tried your test on a 4Kc and I see no problems.
> > However I'm running on our internal kernel sources, and as Kevin mention we have
> > changed a fixed a few things in this area.
> > As Kevin also mention it sure look more like a I-cache invalidation problem,
> > rather than a D-cache flush problem, as the 4Kc has a write-through cache.
> > One think you could try, is our latest kernel release. You can find it here:
> > ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/images/
> >
> 
> Yes, the problem still exists with this kernel.
> 
> Try to move the source tree to /root/, rename top dir to "try18", 
> re-make the binary, and try again.
> 
> This problem is tricky to reproduce.  The location of the tree
> definitely matters.  I am testing 32bit LE version.  Have not
> tried BE.
> 
> I think I have pinned down the problem.  See my other follow-up posting.

Your results are certainly interesting and suspicious.
Before I take it up with the designers as a possible
hardware bug, I would really like to know if there
is more than one chip which exhibits this behavior.
In principle, it *could* be a manufacturing defect.
And while I acknowledge that your trace info
would seem to argue on the face of it that the
hardware didn't do what it should have done,
there is a remarkable similarity between what
you report and something that Carsten saw on
a couple of completely different CPUs a week
or two ago, which makes me wonder if there isn't
still some subtle software failure behind all this.
Thank you very, very, much for digging into
this as deeply as you have.

            Kevin K.
