Received:  by oss.sgi.com id <S553805AbRAVAns>;
	Sun, 21 Jan 2001 16:43:48 -0800
Received: from mms1.broadcom.com ([63.70.210.58]:41993 "HELO mms1.broadcom.com")
	by oss.sgi.com with SMTP id <S553798AbRAVAnn>;
	Sun, 21 Jan 2001 16:43:43 -0800
Received: from 127.0.0.1 by mms1.broadcom.com with SMTP (Broadcom MMS-1
 SMTP Relay (MMS v4.7)); Sun, 21 Jan 2001 16:27:36 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from 63.70.210.40 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Sun, 21 Jan 2001 16:08:19 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from oss.sgi.com (IDENT:root@oss.sgi.com [216.32.174.190]) by
 dns1.broadcom.com (8.9.3/8.9.3/FW03) with ESMTP id QAA25625 for
 <gmo@broadcom.com>; Sun, 21 Jan 2001 16:08:14 -0800 (PST)
Received: by oss.sgi.com id <S553797AbRAVAH6>; Sun, 21 Jan 2001 16:07:58
 -0800
Received: from f69.law3.hotmail.com ([209.185.241.69]:521
 "EHLO hotmail.com") by oss.sgi.com with ESMTP id <S553789AbRAVAHl>;
 Sun, 21 Jan 2001 16:07:41 -0800
Received: from mail pickup service by hotmail.com with Microsoft
 SMTPSVC; Sun, 21 Jan 2001 16:07:32 -0800
Received: from 24.25.8.235 by lw3fd.law3.hotmail.msn.com with HTTP; Mon,
 22 Jan 2001 00:07:32 GMT
X-Originating-IP: [24.25.8.235]
From:   "James McD" <vile8@hotmail.com>
To:     linux-mips@oss.sgi.com
Subject: Fwd: pthread in glibc 2.2.1
Date:   Mon, 22 Jan 2001 00:07:32
MIME-Version: 1.0
Message-ID: <F69IBJYduiFPUEOYMui000010a7@hotmail.com>
X-OriginalArrivalTime: 22 Jan 2001 00:07:32.0617 (UTC)
 FILETIME=[51125F90:01C08407]
X-WSS-ID: 1675A1F24246-01-01
Content-Type: multipart/mixed; 
 boundary="----=_NextPart_000_1656_4a88_499f"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing
Message-ID: <20010122004348.G-I3aS1OpfOfGOofZOv242ZP1zVURgyjnFajsUg1RL4@z>

This is a multi-part message in MIME format.

------=_NextPart_000_1656_4a88_499f
Content-Type: text/plain; 
 charset=us-ascii; 
 format=flowed
Content-Transfer-Encoding: 7bit

>From what I have seen the gdb bombs out on 90% of pthread programs as
well. This includes all platforms as far as I am aware. There is a fix
posted on bugzilla stating you need to recompile the gdb from the cvs tree 
and that should fix. However I have had mixed luck.
Hope that helps somewhat!

Sincerely,

James McDermott
>
>Hi,
>even the simplest pthread-program dies with a bus error(see attachment)
>on my I2.  glibc is 2.2.1(same for 2.1.97), kernel is 2.4.0-test9.
>Interesting enough I can't even get a core dump. Any starting points to
>track this down?
>Regards,
>  -- Guido

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

------=_NextPart_000_1656_4a88_499f
Content-Type: text/plain; 
 charset=us-ascii
Content-Description: pthread_create.c
Content-Disposition: attachment; 
 filename=pthreadcreate.c.orig
Content-Transfer-Encoding: 7bit

#include <pthread.h>
#ifndef NULL
#define NULL (void*)0
#endif

static void *task(p)
	void *p;
{
	return (void *) (p == NULL);
}

int main(argc, argv)
	int argc;
	char **argv;
{
	pthread_t t;
	exit(pthread_create(&t, NULL, task, NULL));
}



------=_NextPart_000_1656_4a88_499f--
