Received:  by oss.sgi.com id <S305192AbQDXTAy>;
	Mon, 24 Apr 2000 12:00:54 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:61218 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305191AbQDXTAc>; Mon, 24 Apr 2000 12:00:32 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA04524; Mon, 24 Apr 2000 12:04:39 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA28584
	for linux-list;
	Mon, 24 Apr 2000 11:47:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA31196
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 24 Apr 2000 11:47:11 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02576
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Apr 2000 11:47:10 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id EBE60853; Mon, 24 Apr 2000 20:47:11 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7AEFE8FFD; Mon, 24 Apr 2000 20:38:06 +0200 (CEST)
Date:   Mon, 24 Apr 2000 20:38:06 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: /usr/include/statfsbuf.h - undefined __fsid_t
Message-ID: <20000424203806.A1623@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
might this be a problem in the current glibc headers ?

__fsid_t doesnt seem to be defined there ...

In file included from /usr/include/sys/statfs.h:26,
                 from /usr/include/sys/vfs.h:4,
                 from unix/getfree.c:18:
/usr/include/statfsbuf.h:34: parse error before `__fsid_t'
/usr/include/statfsbuf.h:34: warning: no semicolon at end of struct or union
/usr/include/statfsbuf.h:37: parse error before `}'

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
