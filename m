Received:  by oss.sgi.com id <S305160AbPLBARa>;
	Wed, 1 Dec 1999 16:17:30 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:14132 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbPLBARD>;
	Wed, 1 Dec 1999 16:17:03 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA17690; Wed, 1 Dec 1999 16:18:23 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA27471
	for linux-list;
	Wed, 1 Dec 1999 16:00:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA77007
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Dec 1999 16:00:23 -0800 (PST)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04132
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Dec 1999 16:00:22 -0800 (PST)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (freakshow.cobaltnet.com [10.9.24.15])
	by mail.cobaltnet.com (8.9.2/8.9.2) with ESMTP id QAA30619;
	Wed, 1 Dec 1999 16:00:20 -0800 (PST)
Message-ID: <3845B67C.4720FD2F@cobaltnet.com>
Date:   Wed, 01 Dec 1999 15:59:56 -0800
From:   Tim Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Khaled Labib <labibk@taec.toshiba.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Problems with glibc RPM
References: <199912012320.PAA14951@stafford.taec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Khaled Labib wrote:
 
> unpacking of archive failed on file glibc-2.0.6.tar.gz: cpio: read failed -
> Success
> 
> Can someone help ? I really need these sources from the rpm.
> 
> I am using RedHat Linux 6.0 on a PC.
> 
> Thank you for your help.
> 
> Khaled

might you have a) run out of disk space?  b) retrieved teh file in ASCII
(as opposed to BIN) mode?

I'd guess 'a'

-- 
Tim Hockin
Software Engineer / OS Engineer
Cobalt Networks
thockin@cobalt.com
