Received:  by oss.sgi.com id <S553761AbQLOPex>;
	Fri, 15 Dec 2000 07:34:53 -0800
Received: from wn42-146.sdc.org ([209.155.42.146]:12532 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S553740AbQLOPer>;
	Fri, 15 Dec 2000 07:34:47 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S870691AbQLOPcI>;
	Fri, 15 Dec 2000 08:32:08 -0700
Date:	Fri, 15 Dec 2000 16:32:08 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
Message-ID: <20001215163208.D28594@bacchus.dhis.org>
References: <3A379CBC.ED1D9F@mips.com> <20001214215933.C28871@bacchus.dhis.org> <3A39CC1F.8FE7B2FE@mips.com> <007001c06670$7345d2e0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <007001c06670$7345d2e0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Dec 15, 2000 at 09:24:22AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Dec 15, 2000 at 09:24:22AM +0100, Kevin D. Kissell wrote:

> In the absence of the SGI people being directed to do a
> clean job, I suppose the problem falls to those who have
> an interest in a clean and portable 64-bit MIPS kernel.
> That would include MIPS, of course.  But what about the
> rest of you - could we see a show of virtual hands?  I
> know that TI has both 4K and 5K licenses, and may
> want to be able to exploit the 64-bit capability of the 5K
> under Linux.  And the guys doing the Vr41xx ports may
> also be interested.  Anyone else?  Those of you with
> R4K-based DECstations, perhaps?  Software shops
> looking to support high-end embedded MIPS in set-tops?
> 
> Another aspect of this is that, in the newer MIPS
> designs that conform to the MIPS64 architecture spec,
> it is finally possible to cleanly seperate the use of
> 64-bit data types from the use of 64-bit virtual addresses.
> The processors in the SGI platforms do not have this
> capability, and it would be a lot to ask of the people
> doing 64-bit Linux for Origin etc. to treat the addressing
> and data aspects orthogonally.  I haven't checked the
> code, but I would imagine that we will have to go in
> and redo things from that perspective as well.

That's one of the plans I have; even in the absense of these new MIPS64
features separation of these new features makes sense.  One of the plans
on my agenda is for example the introduction of 2-level pagetables for
mips64 which will eleminate much of the extra price the 64-bit kernel
currently has to pay.

  Ralf
