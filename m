Received:  by oss.sgi.com id <S305160AbQAXUFd>;
	Mon, 24 Jan 2000 12:05:33 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:64277 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305158AbQAXUFL>;
	Mon, 24 Jan 2000 12:05:11 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09498; Mon, 24 Jan 2000 12:07:13 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA50835
	for linux-list;
	Mon, 24 Jan 2000 11:39:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA21099
	for <linux@relay.engr.sgi.com>;
	Mon, 24 Jan 2000 11:39:50 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id LAA11957
	for linux@engr.sgi.com; Mon, 24 Jan 2000 11:39:40 -0800
Date:   Mon, 24 Jan 2000 11:39:40 -0800
Message-Id: <200001241939.LAA11957@liveoak.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux@cthulhu.engr.sgi.com
Subject: Unimplemented exception
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


I get

| Unimplemented exception for insn 4620a0a4 at 0x0046f084 in install-info.

in my kernel messages, using 2.3.21 from cvs last week.

BTW, is it normal that 2.3.22 (from cvs today) doesn't work? I get tons of

| kmem_alloc: Bad slab magic (corrupt) (name=dentry_cache)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
