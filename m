Received:  by oss.sgi.com id <S305166AbQA0FSH>;
	Wed, 26 Jan 2000 21:18:07 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:43831 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbQA0FRp>; Wed, 26 Jan 2000 21:17:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id VAA06765; Wed, 26 Jan 2000 21:22:32 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA15354
	for linux-list;
	Wed, 26 Jan 2000 19:01:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA88579
	for <linux@relay.engr.sgi.com>;
	Wed, 26 Jan 2000 19:01:37 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id TAA11995
	for linux@engr.sgi.com; Wed, 26 Jan 2000 19:01:27 -0800
Date:   Wed, 26 Jan 2000 19:01:27 -0800
Message-Id: <200001270301.TAA11995@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Bootmem / 2.3.23
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

The new bootmem memory detection stuff did break most of the supported
platforms.  Right now I only ensured that the IP22 compiles and IP27
actually works again.  Patches, please :-)

  Ralf
