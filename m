Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA2216002 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 16:16:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA17636439
	for linux-list;
	Wed, 29 Apr 1998 16:15:09 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA18277335
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 16:15:05 -0700 (PDT)
Received: from lorraine.loria.fr (lorraine.loria.fr [152.81.1.17]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id QAA29639
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 16:15:04 -0700 (PDT)
	mail_from (Olivier.Galibert@loria.fr)
Received: from renaissance.loria.fr (renaissance.loria.fr [152.81.4.102])
	by lorraine.loria.fr (8.8.7/8.8.7/8.8.7/JCG) with ESMTP id BAA19021
	for <linux@cthulhu.engr.sgi.com>; Thu, 30 Apr 1998 01:14:03 +0200 (MET DST)
Received: (from galibert@localhost) by renaissance.loria.fr (8.8.2/8.8.2) id BAA16280; Thu, 30 Apr 1998 01:14:02 +0200 (MET DST)
Message-ID: <19980430011402.A16267@loria.fr>
Date: Thu, 30 Apr 1998 01:14:02 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Rex and the Newport.
Mail-Followup-To: linux@cthulhu.engr.sgi.com
References: <19980430004501.A16187@loria.fr> <m0yUfkH-000aNhC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <m0yUfkH-000aNhC@the-village.bc.nu>; from Alan Cox on Wed, Apr 29, 1998 at 11:54:32PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 29, 1998 at 11:54:32PM +0100, Alan Cox wrote:
> As of about now KGI provides accelerator and mode switching modules to
> fbcon/abscon. Whatever the peanut gallery may be doing the KGI heads
> _are_ clueful

I do  think so   too  actually.  They  just  have  a  "let's  reinvent
everything" tendancy that plays against them. And very very bad PR.

The only problem I have seen with GGI (reading thier documentation) is
that  non-framebuffer    devices   does   not seem   to     be  really
supported... if  I'm wrong it may  be easier to  use KGI/GGI for video
support on sgi instead of filling the gaps in XFree86.

This would have the additional side effect to allow the use of SVGAlib
programs and maybe open the way to a nice Mesa integration.

  OG.
