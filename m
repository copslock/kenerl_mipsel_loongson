Received:  by oss.sgi.com id <S305155AbQAHBme>;
	Fri, 7 Jan 2000 17:42:34 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:3921 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbQAHBmT>;
	Fri, 7 Jan 2000 17:42:19 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03471; Fri, 7 Jan 2000 17:42:57 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA20384
	for linux-list;
	Fri, 7 Jan 2000 17:30:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA29096;
	Fri, 7 Jan 2000 17:30:28 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id RAA32079;
	Fri, 7 Jan 2000 17:30:04 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14454.37660.212667.920493@liveoak.engr.sgi.com>
Date:   Fri, 7 Jan 2000 17:30:04 -0800 (PST)
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Cc:     linux@cthulhu.engr.sgi.com, Florian Lohoff <flo@rfc822.org>,
        "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
In-Reply-To: <XFMail.000107200905.Harald.Koerfgen@home.ivm.de>
References: <14452.58782.750095.352886@liveoak.engr.sgi.com>
	<XFMail.000107200905.Harald.Koerfgen@home.ivm.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Harald Koerfgen writes:
 > 
 > On 06-Jan-00 William J. Earl wrote:
 > >      Note that the SVR4 MIPS ABI assumes FR=0 (R3000-compatible), as
 > > do SGI IRIX "-32" ("O32") binaries (and, I believe, default gcc
 > > binaries).  SGI IRIX "-n32" and "-n64" binaries assumes FR=1
 > > (R4000-compatible), and also have a somewhat different register calling
 > > convention (which affects where arguments to system calls reside).
 > 
 > Wouldn't it make sense then if we made FR=0 the default for Linux/MIPS?

      FR should be tied to the compilation model, which is reflected
in the magic number of the executable.  For "-32" ("O32"), FR must be 0.
That is, there is no need for default; exec should set FR appropriately.
