Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 22:07:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48932 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837155AbaDQUHTPHjlF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Apr 2014 22:07:19 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s3HK7GQF010392;
        Thu, 17 Apr 2014 22:07:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s3HK7FWv010391;
        Thu, 17 Apr 2014 22:07:15 +0200
Date:   Thu, 17 Apr 2014 22:07:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Eric Paris <eparis@redhat.com>,
        libseccomp-discuss@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [libseccomp-discuss] [PATCH v3 0/2] Add support for MIPS BE/LE
 and O32 ABI
Message-ID: <20140417200715.GA8190@linux-mips.org>
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com>
 <1397738551.2725.18.camel@localhost>
 <534FCF75.7060708@imgtec.com>
 <4648181.no7KCQCtEi@sifl>
 <534FFBCF.5010800@imgtec.com>
 <1397750939.750.1.camel@localhost>
 <CALCETrVdHuJ-uh1K=4RtVBwctsgU3Y4=6VyNvO_QeGrL21PkXw@mail.gmail.com>
 <5350002F.4080104@imgtec.com>
 <20140417191359.GR11180@linux-mips.org>
 <CALCETrVTptDpPmC_aqL1T10Pm5tTMXJpBLK=osZmc5Vei0bMkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVTptDpPmC_aqL1T10Pm5tTMXJpBLK=osZmc5Vei0bMkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Apr 17, 2014 at 12:38:36PM -0700, Andy Lutomirski wrote:

> > I can't imagine any legitimate reason why an application of a particular
> > ABI would want to try a syscall of another ABI, for example why an N64
> > process would want to call the O32 open(2) syscall.
> 
> I've done it for testing.  And x32 does it because it's x32.

So from that perspective x32 isn't even a new ABI, just a castrated 64 bit
app using the 64 bit ABI.

> > For that reason I've long been contemplating to make syscalls of other ABIs
> > unavailable, even without seccomp.  Would that be useful for seccomp?
> 
> It's still possible to execve something else.

Would that other process then have a different syscall filter or is there only
one global one?

> > One exception though - I've seen a non-O32 application using syscall 4000,
> > the indirect syscall syscall.  Some needs to be the first to be taken out
> > and shot ;-)
> >
> 
> Aargh.  Let me guess: the indirect syscall syscall uses seven argument
> registers.  I guess ARM wasn't the only architecture to make the
> mistake of having one of those :(

Yes, seven arguments.  The sole reason why MIPS has an indirect syscall is that
I followed the the example of earlier MIPS UNIX variants.  And it has interesting
issues such as with 64 bit arguments on 32 bit machines.

  Ralf
