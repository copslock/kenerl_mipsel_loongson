Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 02:53:50 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:5058 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225204AbTCGCxt>;
	Fri, 7 Mar 2003 02:53:49 +0000
Received: (qmail 31558 invoked by uid 6180); 7 Mar 2003 02:53:45 -0000
Date: Thu, 6 Mar 2003 18:53:45 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: linux-mips@linux-mips.org
Subject: Kernel Debugging on the DBAu1500
Message-ID: <20030306185345.W20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hi all:

I've been trying to get a kernel debugger running on my AMD DBAu1500.  It boots
up over a serial console. I enable "Remote GDB kernel debugging," and "Console
output to GDB."

Here's what I tell YAMON to do:

    go . gdb gdbttyS=0 gdbbaud=115200

And on my x86 machine, I:

    stty ispeed 115200 ospeed 115200 < /dev/ttyS1

    /opt/hardhat/devkit/mips/fp_le/bin/mips_fp_le-gdb vmlinux
    (gdb) target remote /dev/ttyS1 

GDB seems not to communicate. Here's what it says:

    Ignoring packet error, continuing...
    Ignoring packet error, continuing...
    Ignoring packet error, continuing...
    Couldn't establish connection to remote target
    Malformed response to offset query, timeout

Suggestions?

Thanks in advance!

-Jeff

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
