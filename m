Received:  by oss.sgi.com id <S305166AbQBNTlK>;
	Mon, 14 Feb 2000 11:41:10 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:44329 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBNTku>;
	Mon, 14 Feb 2000 11:40:50 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA27832; Mon, 14 Feb 2000 11:36:18 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA42996; Mon, 14 Feb 2000 11:40:18 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA37228
	for linux-list;
	Mon, 14 Feb 2000 10:40:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA89845
	for <linux@relay.engr.sgi.com>;
	Mon, 14 Feb 2000 10:40:21 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA13024
	for linux@engr.sgi.com; Mon, 14 Feb 2000 10:39:57 -0800
Date:   Mon, 14 Feb 2000 10:39:57 -0800
Message-Id: <200002141839.KAA13024@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From:   geert@linux-m68k.org
To:     linux@cthulhu.engr.sgi.com
Subject: -fno-strict-aliasing
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

	Hi,

The test for -fno-strict-aliasing in the main Makefile (cvs 2.3.38):

| # use '-fno-strict-aliasing', but only if the compiler can take it
| CFLAGS += $(shell if $(CC) -fno-strict-aliasing -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-strict-aliasing"; fi)

doesn't work for me. -fno-strict-aliasing is still enabled, while my compiler
doesn't understand it. I'm using gcc version egcs-2.90.27 980315 (egcs-1.0.2
release).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
