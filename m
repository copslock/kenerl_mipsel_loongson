Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Aug 2004 07:58:51 +0100 (BST)
Received: from drum.kom.e-technik.tu-darmstadt.de ([IPv6:::ffff:130.83.139.190]:19383
	"EHLO mailserver.KOM.e-technik.tu-darmstadt.de") by linux-mips.org
	with ESMTP id <S8224837AbUHMG6q>; Fri, 13 Aug 2004 07:58:46 +0100
Received: from KOM.tu-darmstadt.de by mailserver.KOM.e-technik.tu-darmstadt.de (8.7.5/8.7.5) with ESMTP id IAA06809; Fri, 13 Aug 2004 08:57:36 +0200 (MEST)
Date: Fri, 13 Aug 2004 08:59:20 +0200 (CEST)
From: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
X-X-Sender: rac@shofar.kom.e-technik.tu-darmstadt.de
To: Michael Stickel <michael.stickel@4g-systems.biz>,
	michael@cubic.org, Pete Popov <ppopov@mvista.com>
cc: linux-mips@linux-mips.org, Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Subject: Q: aty_nobiosinit.patch - to pre 2.4.24 kernel?
Message-ID: <Pine.LNX.4.58.0408130847400.16128@shofar.kom.e-technik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Ralf.Ackermann@KOM.tu-darmstadt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rac@KOM.tu-darmstadt.de
Precedence: bulk
X-list: linux-mips

Hello Michael, hello all,

Looks like I need to make a custom (pre 2.4.24) kernel for the MeshCube.

Pete Popov pointed me to the patch - see below (many thanks!!). Have you 
been running pre 2.4.24 kernels on the MeshCube (AFAIK the CVS starts with 
2.4.24 already).

Otherwise - how to proceed for a MIPS or MTX1 specific kernel? Is that
	- starting with the standard kernel source from www.kernel.org
	- applying a patch (where from?) to it (I have only done this
		for ARM systems so far - where this procedure is the
		standard way)

Again - any hints highly welcome
 regards Ralf

PS: I'll finally document all the answers I got within the process in the 
Wiki => so we'll hopefully all profit from it.

----
original message:

I don't know which ATI Rage card you have exactly, but there is a patch 
for the RageXL (tested on a MIPS board) on 
ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.4/aty_nobiosinit.patch.

The problem is that at kernel version 2.4.24 or .25, don't remember 
which one, the aty code was restructured and the patch does not apply 
anymore.

Pete
