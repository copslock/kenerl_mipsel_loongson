Received:  by oss.sgi.com id <S305180AbQADV5j>;
	Tue, 4 Jan 2000 13:57:39 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:36202 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQADV51>; Tue, 4 Jan 2000 13:57:27 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA01967; Tue, 4 Jan 2000 14:00:16 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA29948
	for linux-list;
	Tue, 4 Jan 2000 13:48:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA13262
	for <linux@engr.sgi.com>;
	Tue, 4 Jan 2000 13:48:27 -0800 (PST)
	mail_from (indy.j@seznam.cz)
Received: from pingu.kastner.net (as1-34.plzen.iol.cz [194.228.131.162]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA05523
	for <linux@engr.sgi.com>; Tue, 4 Jan 2000 13:48:20 -0800 (PST)
	mail_from (indy.j@seznam.cz)
Received: from pingu.kastner.net (IDENT:root@pingu.kastner.net [192.168.1.1])
	by pingu.kastner.net (8.9.3/8.8.7) with SMTP id WAA01058
	for <linux@engr.sgi.com>; Tue, 4 Jan 2000 22:48:02 +0100
From:   "Jiri Kastner jr." <indy@arcom.cz>
To:     linux@cthulhu.engr.sgi.com
Subject: XFree86-FBDev and /dev/fb0
Date:   Tue, 4 Jan 2000 22:40:27 +0100
X-Mailer: KMail [version 1.0.20]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00010422480200.01013@pingu.kastner.net>
Content-Transfer-Encoding: 8bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I have installed XFree86-FBDev, but everytime, when I want to start X, I get
message, that is missing /dev/fb0, and I dont know, how to make it (MAKEDEV
dont know anything about fb* devices).

Jiri Kastner.
