Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA84108 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Nov 1998 00:01:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA57791
	for linux-list;
	Thu, 26 Nov 1998 00:00:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA61286
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 26 Nov 1998 00:00:16 -0800 (PST)
	mail_from (torbjorn.gannholm@fra.se)
Received: from x.fra.se (x.fra.se [193.12.220.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id AAA05218
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Nov 1998 00:00:07 -0800 (PST)
	mail_from (torbjorn.gannholm@fra.se)
Received: from fra.se by x.fra.se via ESMTP (940816.SGI.8.6.9/940406.SGI.AUTO)
	for <linux@cthulhu.engr.sgi.com> id JAA01966; Thu, 26 Nov 1998 09:06:49 +0100
Message-ID: <365D0C17.73AB1509@fra.se>
Date: Thu, 26 Nov 1998 09:06:48 +0100
From: "Torbjörn Gannholm" <torbjorn.gannholm@fra.se>
X-Mailer: Mozilla 4.05 [en] (X11; I; IRIX 5.3 IP12)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: GNU/Hurd
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Have you ever considered the GNU/Hurd for SGI? It has some good points:
1) It is designed to be 100% reentrant from scratch and is also heavily
multithreaded.
2) Basic kernel is minuscule.
3) Added functionality (files, memory, authorization, scheduling, etc)
comes from "servers" which can be replaced at will or even have
different ones running at the same time. The point is you can easily
have a mix of proprietary/freeware/own-design for different
functionalities. Different tasks with conflicting interests could run
against different servers and, above all, totally ignore unused servers.

4) According to the developers it is extremely stable, errors never
resulting in anything worse than an interruptible hang.

A possible minus is the message-passing between the servers which might
be time-consuming.

Still, my feeling is that this could be a real winner on flexibility and
performance. Any comments?

--
/Torbjörn

This message is a personal message from Torbjörn Gannholm
and does not necessarily represent the opinion of my employer.
