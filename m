Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2004 20:07:48 +0000 (GMT)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.196]:45161 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8225426AbULJUHl>;
	Fri, 10 Dec 2004 20:07:41 +0000
Received: by rproxy.gmail.com with SMTP id i8so664161rne
        for <linux-mips@linux-mips.org>; Fri, 10 Dec 2004 12:07:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=VRf2dFN3ZZnQ5xxj//8ZUeOHkON+th9hSBkhxiKLQuBUZdi5G3hDl95YUWkiv0FzdUvX6Q4DAvTLEa5y52P1X3idLPgsGWPT50jQfgaN0TE3LrixRZo2NYKAaZHFx/JEmep+XbERm6ZsfrQRBHFy3WTS3O+IPuttSDGMdmmNLSc=
Received: by 10.38.181.65 with SMTP id d65mr512106rnf;
        Fri, 10 Dec 2004 12:07:40 -0800 (PST)
Received: by 10.38.79.62 with HTTP; Fri, 10 Dec 2004 12:07:40 -0800 (PST)
Message-ID: <842f1e5f04121012074f6ddff0@mail.gmail.com>
Date: Sat, 11 Dec 2004 01:37:40 +0530
From: Deepak V <vdeepak79@gmail.com>
Reply-To: Deepak V <vdeepak79@gmail.com>
To: linux-mips@linux-mips.org
Subject: SIGTRAP Trace/Breakpoint Trap
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vdeepak79@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vdeepak79@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

  I am using insure++ to build a multi-threaded application on RED HAT
Linux 3.2.3-37. (Linux insurertx 2.4.21-15.0.3.ELsmp #1 SMP Tue Jun 29
18:04:47 EDT 2004 i686 i686 i386 GNU/Linux)

  When I am running the application in GDB I am getting a SIGTRAP signal.

### Linux/LinuxThreadSpecific.cc:184: assertion failed
### @(#)$RCSfile: LinuxThreadSpecific.cc,v $ $Revision: 32.18 $ $Date:
2003/06/03 23:29:13 $

Program received signal SIGTRAP, Trace/breakpoint trap.
[Switching to Thread -1232592224 (LWP 30447)]
0xb68d4f01 in kill () from /lib/tls/libc.so.6
(gdb) where
#0  0xb68d4f01 in kill () from /lib/tls/libc.so.6
#1  0xb6bd1ab8 in Insure::Debug::nativeTrap () from
/home/kodiak/ins++/lib.linux2/libinsure.so
#2  0xb6b518d6 in Insure::Debug::trap () from
/home/kodiak/ins++/lib.linux2/libinsure.so
#3  0xb6b94f3a in Insure::Object::assertionFailed () from
/home/kodiak/ins++/lib.linux2/libinsure.so
#4  0xb6bff718 in Insure::PosixThread::setThisThread () from
/home/kodiak/ins++/lib.linux2/libinsure_mt.so
#5  0xb6bfe8e1 in Insure::PosixThread::processWillBecomeMultithreaded
() from /home/kodiak/ins++/lib.linux2/libinsure_mt.so
#6  0xb6bc2cfe in Insure::ThisThread::processWillBecomeMultithreaded
() from /home/kodiak/ins++/lib.linux2/libinsure.so
#7  0xb6bc2caf in Insure::ThisThread::newThread () from
/home/kodiak/ins++/lib.linux2/libinsure.so
#8  0xb6bfeb3b in Insure::PosixThread::willCreateNewThread () from
/home/kodiak/ins++/lib.linux2/libinsure_mt.so
#9  0xb6bc3127 in Insure::ThisThread::willCreateNewThread () from
/home/kodiak/ins++/lib.linux2/libinsure.so
#10 0xb6b9813c in _insure_thread_create () from
/home/kodiak/ins++/lib.linux2/libinsure.so
#11 0xb6c8e76b in pthread_create () from
/home/kodiak/ins++/lib.linux2/libtql_pthread_gcc.so

Can you please suggest what may be going wrong and the possible
solution for this?

  Thanks in advance.

Regards,
Deepak.
