Received:  by oss.sgi.com id <S305163AbQDYUHo>;
	Tue, 25 Apr 2000 13:07:44 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:36873 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305157AbQDYUHc>;
	Tue, 25 Apr 2000 13:07:32 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA09530; Tue, 25 Apr 2000 13:02:45 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA44647; Tue, 25 Apr 2000 13:07:00 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA67838
	for linux-list;
	Tue, 25 Apr 2000 12:23:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA32973
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Apr 2000 12:23:14 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1406379AbQDYTTU>;
	Tue, 25 Apr 2000 12:19:20 -0700
Date:   Tue, 25 Apr 2000 12:19:20 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: /usr/include/statfsbuf.h - undefined __fsid_t
Message-ID: <20000425121920.A1937@uni-koblenz.de>
References: <20000424203806.A1623@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000424203806.A1623@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Apr 24, 2000 at 08:38:06PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 24, 2000 at 08:38:06PM +0200, Florian Lohoff wrote:

> might this be a problem in the current glibc headers ?
> 
> __fsid_t doesnt seem to be defined there ...
> 
> In file included from /usr/include/sys/statfs.h:26,
>                  from /usr/include/sys/vfs.h:4,
>                  from unix/getfree.c:18:
> /usr/include/statfsbuf.h:34: parse error before `__fsid_t'
> /usr/include/statfsbuf.h:34: warning: no semicolon at end of struct or union
> /usr/include/statfsbuf.h:37: parse error before `}'

Yes, <statfsbuf.h> should include <gnu/types.h>.  Fixing ...

  Ralf
