Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UJvGnC001173
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 12:57:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UJvGaU001172
	for linux-mips-outgoing; Thu, 30 May 2002 12:57:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms2.broadcom.com (mms2.broadcom.com [63.70.210.59])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UJvDnC001169
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 12:57:14 -0700
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS-2 SMTP Relay (MMS v4.7)); Thu, 30 May 2002 12:57:00 -0700
X-Server-Uuid: 2a12fa22-b688-11d4-a6a1-00508bfc9626
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4UJwj1S016616; Thu, 30 May 2002 12:58:45 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4UJwj619434; Thu, 30 May 2002 12:58:45 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: Re: Function pointers and #defines
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: "Daniel Jacobowitz" <dan@debian.org>
cc: linux-mips@oss.sgi.com
In-Reply-To: <20020530195052.GA10587@branoic.them.org>
References: <1022787167.14210.472.camel@ldt-sj3-022.sj.broadcom.com>
 <20020530195052.GA10587@branoic.them.org>
X-Mailer: Ximian Evolution 1.0.5
Date: 30 May 2002 12:58:44 -0700
Message-ID: <1022788724.7890.475.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10E85B8659714-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-05-30 at 12:50, Daniel Jacobowitz wrote:
> > but the latter is both clearer and shorter.  Is there some deep,
> > mystical C reason that we use the former, or did someone do it that way
> > a long time ago and no one has changed it?
> 
> At a guess, this prevents taking the address of the function
> unintentionally...

But if you're writing code in such a way that the compiler type checking
doesn't flag this, you deserve what you get.  (IMHO, of course.  :)

-Justin
