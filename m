Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id TAA13758
	for linuxmips-outgoing; Tue, 26 Oct 1999 19:51:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id TAA13755
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 19:51:38 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA03965
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 19:56:27 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA73389
	for linux-list;
	Tue, 26 Oct 1999 19:29:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA84992
	for <linux@engr.sgi.com>;
	Tue, 26 Oct 1999 19:29:34 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA5223835
	for <linux@engr.sgi.com>; Tue, 26 Oct 1999 19:29:30 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (freakshow.cobaltnet.com [10.9.24.15])
	by mail.cobaltnet.com (8.9.2/8.9.2) with ESMTP id TAA29628
	for <linux@engr.sgi.com>; Tue, 26 Oct 1999 19:29:29 -0700 (PDT)
Message-ID: <381661A5.7744EB96@cobaltnet.com>
Date: Tue, 26 Oct 1999 19:21:25 -0700
From: Tim Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: MIPS Linux Mailing List <linux@cthulhu.engr.sgi.com>
Subject: Access io space from userland
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

Do we have any mechanism to access IO space from userland?  Something
analogous to ioperm or iopl is what I want.  


-- 
Tim Hockin
Software Engineer / OS Engineer
Cobalt Networks
thockin@cobaltnet.com
