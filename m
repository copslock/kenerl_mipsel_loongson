Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA21352 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 Aug 1998 10:06:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA49897
	for linux-list;
	Thu, 27 Aug 1998 10:06:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA53491
	for <linux@engr.sgi.com>;
	Thu, 27 Aug 1998 10:06:22 -0700 (PDT)
	mail_from (Arnaud.Le.Neel@cyceron.fr)
Received: from cyceron.fr (ns2.cyceron.fr [192.93.44.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA25000
	for <linux@engr.sgi.com>; Thu, 27 Aug 1998 10:06:21 -0700 (PDT)
	mail_from (Arnaud.Le.Neel@cyceron.fr)
Received: from cyceron.fr (indigo1.cyceron.fr [192.93.44.9])
	by cyceron.fr (8.8.8/8.8.8) with ESMTP id SAA01821
	for <linux@engr.sgi.com>; Thu, 27 Aug 1998 18:04:43 GMT
Message-ID: <35E59FBA.96A1900C@cyceron.fr>
Date: Thu, 27 Aug 1998 19:04:42 +0100
From: Arnaud Le Neel <Arnaud.Le.Neel@cyceron.fr>
Reply-To: Arnaud.Le.Neel@cyceron.fr
Organization: Cyceron PET Center
X-Mailer: Mozilla 4.05 [en] (X11; I; IRIX 6.2 IP20)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: boot problem for Indy
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm quite newbie on SGI/Linux, even if i know Linux and Unix. I'm
trying to boot with HardHat 5.1 (Manhattan) on an Indy (see below)
via a i686/Linux and here is what happens:

>> boot -f bootp()linux.cyceron.fr:vmlinux
Setting $netaddr to 192.93.44.35 (for server server.cyceron.fr)
Obtaining vmlinux from server.cyceron.fr

Cannot reload bootp()server.cyceron.fr:vmlinux
Illegal f_magik number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC
Unable to load bootp()server.cyceron.fr:vmlinux: execute format error

Did anyone ever seen this message, and what is the solution, if there
is one ?

Thanks for your help
arno

PS: Here is the description of the Indy i want to boot Linux:
	IP22 100MHz R4000 with FPU
	Memory size 48 Mb

-- 
       Arnaud Le Néel			Cyceron PET Research Center
Systems and Network administrator	  Bd Becquerel - BP 5229
mailto:Arnaud.Le.Neel@cyceron.fr	   F-14074 Caen - CEDEX
       	ICQ #8852927			Tel :	(+33) (0)231 470 203
  http://www.cyceron.fr/~arno		Fax :	(+33) (0)231 470 222
