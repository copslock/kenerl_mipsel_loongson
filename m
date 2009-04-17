Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2009 07:53:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38080 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20024514AbZDQGxf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2009 07:53:35 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3H5rKOK017677;
	Fri, 17 Apr 2009 07:58:41 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3H5rHXr017675;
	Fri, 17 Apr 2009 07:53:17 +0200
Date:	Fri, 17 Apr 2009 07:53:17 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Markus Gothe <nietzsche@lysator.liu.se>
Cc:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
	Brian Foster <brian.foster@innova-card.com>,
	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090417055317.GA6898@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304154418.GA13464@linux-mips.org> <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com> <20090402133855.GC15021@linux-mips.org> <5A24253D-8F6F-46CE-A121-AD5CADC6D7C8@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A24253D-8F6F-46CE-A121-AD5CADC6D7C8@lysator.liu.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 16, 2009 at 05:46:56AM +0200, Markus Gothe wrote:

> That article is a classic one, just the name itself...
>
> However the article itself is based on M68K and Intel x86 IIRC.

There is a variant or extension of it which specifically looks at MIPS
o32 issues.

> Indeed, IRIX < 6.2 was all o32, correct me if I'm wrong.
>
> To get back on track, what about a kernel that can be compiled by  
> MIPSPro C and not relaying on glibc and GNUisms (al right, 'asmlinkage' 
> cracked that idea once and for all a few years ago), but my point is to 
> change the libc as little as possible.

Do you have a MIPSpro compiler that is hosted on a non-IRIX?  Asmlinkage
is just an empty define.

> I hope I brought a grasp of light on the issue (and yes $ra is fun to  
> play with), and as Ralph pointed out: the special stack frame makes the 
> return address traceability disappear after one step as __GNUC__ knows 
> it.

The first problem with the usual stack smashing techniques is that the
return address of a leaf function is not getting stored on the stack at
all, so can't be smashed by a stack overflow.  So the caller's return
address is becoming the new attack target.

  Ralf

PS: Who's that Ralph?
