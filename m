Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 May 2015 07:00:34 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:56037 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006531AbbE3FAcVlCUw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 May 2015 07:00:32 +0200
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id a50U1q0052S2Q5R0150UUu; Sat, 30 May 2015 05:00:28 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-16v.sys.comcast.net with comcast
        id a50T1q00F42s2jH0150THr; Sat, 30 May 2015 05:00:28 +0000
Message-ID: <556943D9.7020502@gentoo.org>
Date:   Sat, 30 May 2015 01:00:09 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: IP27: R14000: Unexpected General Exception in cpu_set_fpu_fcsr_mask()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432962028;
        bh=gZptEOolLtzqZt12dbRUAXDO8HxhKFUtCGV1bBnIZ28=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=obftUl6Idi73uZYdfIahPTkYsPGXoKUq8idYZTZbO0UVBC4MHdTUlXBoPNkP5g6N8
         VffF/xU+LMu8cISAsdcHJdKpEaJO0IebY5jldMlS4cJpUuoJRqQSWaIJh841paCPJE
         1BIqsAEN9E6x2YZf+UA7N1gpGA8h/FJh/e3TLIu9t244Pjk2FymzAqr9JJNGF9esRs
         hDZa+lGVV9muxBG9LdZYLq0y9nZVH+rTAY1G00TjQNioJ57RPoqAozaWhFWlTHUL5P
         t7oe97u1hKp12tvi+bj/HL1S1pIMevdwikPFPXxRSCiLxG/t6vW8XJuGt6b0vRZmdw
         YPxO4UX9RNTyA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Booting a recent kernel on an IP27 system with R14K nodeboards causes the PROM
to bail:

ttyS0:
Command Monitor.  Type "exit" to return to the menu.
>> bootp(): console=ttyS0,9600 root=/dev/md0
Setting $netaddr to 192.168.1.x (from server )
Obtaining  from server
9036672+495920 entry: 0xa800000000689300

MMC:
2A 000: *** General Exception on node 0
2A 000: *** EPC: 0xa800000000022178 (0xa800000000022178)
2A 000: *** Press ENTER to continue.
2A 000: POD MSC Unc> why
2A 000:  EPC    : 0xa800000000022178 (0xa800000000022178)
2A 000:  ERREPC : 0xffffffffbfc00ee0 (0xc00000001fc00ee0)
2A 000:  CACERR : 0x00000000d6d7ff21
2A 000:  Status : 0x0000000024407c80
2A 000:  BadVA  : 0x0000000000000000 (0x0)
2A 000:  RA     : 0xa8000000008771cc (0xa8000000008771cc)
2A 000:  SP     : 0xa80000000081be00
2A 000:  A0     : 0x00000000000051a1
2A 000:  Cause  : 0x000000000000c03c (INT:87------ <Float Pt. Exc>)
2A 000:  Reason : 242 (Unexpected General Exception.)
2A 000:  POD mode was called from: 0xc00000001fc027ec (0xc00000001fc027ec)
2A 000: POD MSC Unc>

Address 0xa800000022178 centers around line 85 in 4.1.0-rc4's
arch/mips/cpu-probe.c:

85:         write_32bit_cp1_register(CP1_STATUS, fcsr0);
    a80000000002216c:       3c020003        lui     v0,0x3
    a800000000022170:       3445ffff        ori     a1,v0,0xffff
    a800000000022174:       00851024        and     v0,a0,a1
--> a800000000022178:       44c2f800        ctc1    v0,$31
    a80000000002217c:       00000000        nop

Looks like cpu_set_fpu_fcsr_mask() was added in April sometime:

http://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/kernel/cpu-probe.c?id=9b26616c8d9dae53fbac7f7cb2c6dd1308102976

Not sure what else can be gleaned.  Seems this version of the R14K (v1.4)
doesn't like that FCSR mask.  Don't recall the Octane complaining about this,
but I'll try to double-check tomorrow.  It's got a newer rev of R14K silicon.
Might be an errata.

--J
