Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 20:29:33 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:2513 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225488AbTI3T3B>;
	Tue, 30 Sep 2003 20:29:01 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h8UJNxYY023178;
	Tue, 30 Sep 2003 12:23:59 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.65.120])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA13818;
	Tue, 30 Sep 2003 12:27:36 -0700 (PDT)
Subject: Re: 64 bit operations w/32 bit kernel
From: Michael Uhler <uhler@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	"Finney, Steve" <Steve.Finney@spirentcom.com>,
	linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.3.96.1030930205322.11368E-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1030930205322.11368E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain
Organization: MIPS Technologies, Inc.
Message-Id: <1064950055.12992.99.camel@uhler-linux.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 30 Sep 2003 12:27:36 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-09-30 at 12:10, Maciej W. Rozycki wrote:
> On 30 Sep 2003, Michael Uhler wrote:
> 
> > > What you want really is a 64-bit kernel.  On a 64-bit kernel even for
> > > processes running in 32-bit address spaces (o32, N32) the processor
> > > will run with the UX bit enabled.  o32 userspace still lives in the
> > > assumption that registers are 32-bit so only those bits will be restored
> > > in function calls etc.  N32 (where userspace isn't ready for prime time
> > > yet) does guarantee that.  And N64 (userspace similarly not ready for
> > > prime time) obviously is fully 64-bit everything.
> > 
> > I don't think you want to run o32 processes with the UX bit set.  UX not
> > only enables 64-bit addressing (which you can, in software, make look
> > like 32-bit addressing), it also enables access to the 64-bit opcodes.
> > This means that you are going to get unexpected and potentially
> > unreproducible results.
> 
>  Well, I think this is OK -- 64-bit opcodes are generally useless for
> software built for the o32 ABI, so they should not normally happen in
> regular code.  Perhaps some fancy hand-coded assembly might try to use
> them to get unusual results, including an invalid opcode trap handler for
> the processors that do not support them at all.  But I don't think we
> should try to work hard to prevent broken software from shooting into its
> foot.

I'm not a real fan of architecting software to dismiss broken (or rogue)
programs since it tends to open up a whole lot of holes that cause
O/S crashes.  For instance, an o32 program should never be able to pass
a non-sign-extended value thru a GPR to the O/S in a system call.  How
many places in the O/S implicitly assume this is true?  The architecture
was never intended to run real 32-bit programs with 64-bit ops enabled,
and I would strongly urge you not to do this now.

> 
>  And the advantage is we have a single TLB refill handler.

This hardly seems compelling given how short the handlers are.  Further,
since N64 needs the 64-bit address support anyway, setting UX and PX
correctly will allow you to run the N32 code with the TLB handler
instead of the XTLB handler.  That way the XTLB handler is only
invoked when a real extended address reference happens.  That seems
cleaner to me, but I admit I'm not the one that has to write the
code.

/gmu

> 
>   Maciej
-- 

Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
