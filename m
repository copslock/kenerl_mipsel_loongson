Received:  by oss.sgi.com id <S305158AbQCPFYQ>;
	Wed, 15 Mar 2000 21:24:16 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:50534 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCPFX7>;
	Wed, 15 Mar 2000 21:23:59 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id VAA07911; Wed, 15 Mar 2000 21:19:22 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id VAA42846; Wed, 15 Mar 2000 21:22:25 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA17972
	for linux-list;
	Wed, 15 Mar 2000 21:11:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA67656
	for <linux@engr.sgi.com>;
	Wed, 15 Mar 2000 21:11:37 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po4.glue.umd.edu (po4.glue.umd.edu [128.8.10.124]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA05404
	for <linux@engr.sgi.com>; Wed, 15 Mar 2000 21:11:36 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po4.glue.umd.edu (8.9.3/8.9.3) with ESMTP id AAA19839
	for <linux@engr.sgi.com>; Thu, 16 Mar 2000 00:11:36 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id AAA28924
	for <linux@engr.sgi.com>; Thu, 16 Mar 2000 00:11:35 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id AAA28920
	for <linux@engr.sgi.com>; Thu, 16 Mar 2000 00:11:35 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Thu, 16 Mar 2000 00:11:35 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: /proc/cpuinfo cleanups 
Message-ID: <Pine.GSO.4.21.0003160008490.28783-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello,

I noticed that my patch to add Indigo2 support to /proc/cpuinfo never made
it into the kernel
[http://www.glue.umd.edu/~weave/patches/patch_indigo2_support]

I know Ralf said he'd like for the cpuinfo stuff to be completely
re-written and the afforementioned support be added along with a slew of
other features.

I have an interest in /proc/cpuinfo, with linux_logo being one of the few
programs that actively parses it.  Linus has always ignored any of my
attempted cleanups, apparently on the premise that "if it's not
super-broken don't fix it".  So I was a bit hesitant to start such an
ambitious re-writing of the involved code, especially since I no longer
have access to the Indigo2 machine I was working with.

Well, this is a round-about way of asking, should I try to get my
originaly patch included again, or should I try to scrape together some
time to work on the more complicated problem?  Hopefully I'll get a
summer-job that lets me work on such things full time, instead of working
on the sgi-linux stuff during my breaks...

Vince

____________
\  /\  /\  /  Vince Weaver          
 \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave
