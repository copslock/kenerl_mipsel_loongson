Received:  by oss.sgi.com id <S305157AbQCRFDl>;
	Fri, 17 Mar 2000 21:03:41 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:37742 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCRFDV>;
	Fri, 17 Mar 2000 21:03:21 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA23760; Fri, 17 Mar 2000 20:58:43 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA31229
	for linux-list;
	Fri, 17 Mar 2000 20:43:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA49475;
	Fri, 17 Mar 2000 20:41:25 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id UAA18778;
	Fri, 17 Mar 2000 20:41:24 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14547.2292.467349.391271@liveoak.engr.sgi.com>
Date:   Fri, 17 Mar 2000 20:41:24 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        SGI Linux Alias <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
In-Reply-To: <20000318010801.B811@uni-koblenz.de>
References: <000e01bf903e$a0e864a0$0ceca8c0@satanas.mips.com>
	<20000318010801.B811@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
...
 > The bits/ subdirectory was introduced for glibc 2.1.

    The bits/ subdirectory is present in 2.1, but at least 2.1.1-7 does
not have a bits/sigaction.h for MIPS in the source, so the generic 
one is used, and that is inconsistent with the kernel.  Which source
for glibc has a MIPS bits/sigaction.h?
