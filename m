Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2004 17:05:39 +0000 (GMT)
Received: from web40413.mail.yahoo.com ([IPv6:::ffff:66.218.78.110]:61761 "HELO
	web40413.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225384AbUCERFi>; Fri, 5 Mar 2004 17:05:38 +0000
Message-ID: <20040305170349.86540.qmail@web40413.mail.yahoo.com>
Received: from [67.169.188.20] by web40413.mail.yahoo.com via HTTP; Fri, 05 Mar 2004 09:03:49 PST
Date: Fri, 5 Mar 2004 09:03:49 -0800 (PST)
From: Long Li <long21st@yahoo.com>
Subject: Re: gcc support of mips32 release 2
To: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>
Cc: Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
In-Reply-To: <16456.21112.570245.1011@arsenal.mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <long21st@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: long21st@yahoo.com
Precedence: bulk
X-list: linux-mips

Thanks for the email. Could you give me a link to your
3.4 evolution tree?

Thanks,


Long

--- Dominic Sweetman <dom@mips.com> wrote:
> 
> > > Seems to me, this mips32 release 2 is an
> extension of
> > > mips32, added some new instructions, eg. EHB,
> etc. So
> > > would it be necessary that gcc be updated, like
> what
> > > gnu as has done, in the future to reflect this
> > > extension?
> > 
> > It will be in the soon to be released 3.4.
> Contributed by Chris
> > Demetriou of Broadcom.
> 
> We added patterns to let our (old) GCC use the new
> rotates and
> bit-insert/extracts, at least in simple cases.  I'm
> not sure whether
> we've put those in our 3.4 evolution tree yet, but
> if we have we
> should push those out.
> 
> --
> Dominic Sweetman
> MIPS Technologies.
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
