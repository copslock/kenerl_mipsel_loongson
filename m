Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 03:11:55 +0100 (CET)
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:32420 "EHLO
	sj-msg-core-1.cisco.com") by linux-mips.org with ESMTP
	id <S1123954AbSKNCLy>; Thu, 14 Nov 2002 03:11:54 +0100
Received: from bbozarth-lnx.cisco.com (bbozarth-lnx.cisco.com [128.107.165.13])
	by sj-msg-core-1.cisco.com (8.12.2/8.12.2) with ESMTP id gAE2BlNf012070;
	Wed, 13 Nov 2002 18:11:47 -0800 (PST)
Received: from localhost (bbozarth@localhost)
	by bbozarth-lnx.cisco.com (8.11.6/8.11.6) with ESMTP id gAE2Blw11125;
	Wed, 13 Nov 2002 18:11:47 -0800
Date: Wed, 13 Nov 2002 18:11:47 -0800 (PST)
From: Bradley Bozarth <bbozarth@cisco.com>
To: linux-mips@linux-mips.org
cc: george@mvista.com
Subject: Re: SEGEV defines
In-Reply-To: <200211080914.KAA14181@pallas.spacetec.no>
Message-ID: <Pine.LNX.4.44.0211131742480.11387-100000@bbozarth-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <bbozarth@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bbozarth@cisco.com
Precedence: bulk
X-list: linux-mips

This presents a problem that I just ran into.  What should the solution 
be?  Either glibc or the kernel needs to change as far as I can tell, in 
order for programs compiled against glibc and using these SIGEV defines to 
work w/ the mips kernel.  Is this file currently wrong?

glibc-2.3.1/sysdeps/unix/sysv/linux/mips/bits/siginfo.h

Would this patch fix it?

--- siginfo.h.orig	Wed Nov 13 18:04:58 2002
+++ siginfo.h	Wed Nov 13 18:11:15 2002
@@ -295,11 +295,11 @@
 /* `sigev_notify' values.  */
 enum
 {
-  SIGEV_SIGNAL = 0,		/* Notify via signal.  */
+  SIGEV_SIGNAL = 129,		/* Notify via signal.  */
 # define SIGEV_SIGNAL	SIGEV_SIGNAL
-  SIGEV_NONE,			/* Other notification: meaningless.  */
+  SIGEV_NONE = 128,		/* Other notification: meaningless.  */
 # define SIGEV_NONE	SIGEV_NONE
-  SIGEV_THREAD			/* Deliver via thread creation.  */
+  SIGEV_THREAD = 131		/* Deliver via thread creation.  */
 # define SIGEV_THREAD	SIGEV_THREAD
 };


On Fri, 8 Nov 2002, Tor Arntsen wrote:

> On Nov 7, 23:11, Daniel Jacobowitz wrote:
> >Presumably they match IRIX... like the rest of MIPS's oddball
> >definitions.  A little hard to change them now.
> 
> FWIW: You are correct, those values come from IRIX.
> 
> >On Thu, Nov 07, 2002 at 12:33:55PM -0800, Bradley Bozarth wrote:
> >> Can these be changed?
> >> 
> >> > Now a question, why does mips use these values:
> >> >  #define SIGEV_SIGNAL   129     /* notify via signal */
> >> >  #define SIGEV_CALLBACK 130     /* ??? */
> >> >  #define SIGEV_THREAD   131     /* deliver via thread
> >> > creation */
> >> >
> >> > It is the only platform that adds anything to the simple
> >> > 1,2,3 values used on other platforms.  The reason I ask, is
> >> > that I would like to change them to conform to all the
> >> > others.
> 
