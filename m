Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA75420 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 15:04:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA90234
	for linux-list;
	Wed, 19 Aug 1998 15:04:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA75586
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 15:04:17 -0700 (PDT)
	mail_from (Olivier.Galibert@loria.fr)
Received: from lorraine.loria.fr ([152.81.1.17]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07118
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 15:04:15 -0700 (PDT)
	mail_from (Olivier.Galibert@loria.fr)
Received: from renaissance.loria.fr (renaissance.loria.fr [152.81.4.102])
	by lorraine.loria.fr (8.8.7/8.8.7/8.8.7/JCG) with ESMTP id AAA11724;
	Thu, 20 Aug 1998 00:02:39 +0200 (MET DST)
Received: (from galibert@localhost) by renaissance.loria.fr (8.8.2/8.8.2) id AAA11989; Thu, 20 Aug 1998 00:02:37 +0200 (MET DST)
Message-ID: <19980820000237.A11980@loria.fr>
Date: Thu, 20 Aug 1998 00:02:37 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: Debugging emacs
Mail-Followup-To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
References: <19980819235142.36595@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <19980819235142.36595@alpha.franken.de>; from Thomas Bogendoerfer on Wed, Aug 19, 1998 at 11:51:42PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Aug 19, 1998 at 11:51:42PM +0200, Thomas Bogendoerfer wrote:
> Now I'm looking for a way to start a X session with temacs, which has
> a working .mdebug section. I'm able to do a temacs -l loadup, which 
> will give me a "normal" looking emacs. But I haven't found a way to get 
> temacs to create a X session.
> 
> Any hints ?

You're doomed.  At least on XEmacs this hasn't worked for a while, and
I guess FSF Emacs isn't in any better shape  in that area.  Fixing the
undumping code  may  be easier.   Too bad I've   not yet been  able to
install linux on  the indy I  use or I  would probably have fixed that
myself for XEmacs.

  OG.
