Received:  by oss.sgi.com id <S553756AbQKIKPy>;
	Thu, 9 Nov 2000 02:15:54 -0800
Received: from mx.mips.com ([206.31.31.226]:33671 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553724AbQKIKP1>;
	Thu, 9 Nov 2000 02:15:27 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA05039
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 02:15:02 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA21641
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 02:15:19 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id LAA16868
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 11:15:13 +0100 (MET)
Message-ID: <3A0A7930.BC924ECF@mips.com>
Date:   Thu, 09 Nov 2000 11:15:12 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Problems with egcs-1.0.3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I wanted to upgrade my compiler, so I just install the following
packages:

binutils-2.8.1-4lm.mips.rpm
egcs-1.0.3a-10lm.mips.rpm
egcs-c++-1.0.3a-10lm.mips.rpm
egcs-g77-1.0.3a-10lm.mips.rpm
egcs-objc-1.0.3a-10lm.mips.rpm
glibc-2.0.6-5lm.mips.rpm
glibc-debug-2.0.6-5lm.mips.rpm
glibc-devel-2.0.6-5lm.mips.rpm
glibc-profile-2.0.6-5lm.mips.rpm

But when I try to compile the 2.4.0 kernel it simply hangs forever when
I try to compile driver/scsi/scsi_merge.c.
As anyone seen this ?

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
