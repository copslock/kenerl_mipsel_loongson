Received:  by oss.sgi.com id <S305171AbQALWoE>;
	Wed, 12 Jan 2000 14:44:04 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:25890 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQALWnv>; Wed, 12 Jan 2000 14:43:51 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA08679; Wed, 12 Jan 2000 14:47:29 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA73411
	for linux-list;
	Wed, 12 Jan 2000 14:31:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA54144
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 12 Jan 2000 14:31:36 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po4.glue.umd.edu (po4.glue.umd.edu [128.8.10.124]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05262
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 14:31:22 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po4.glue.umd.edu (8.9.3/8.9.3) with ESMTP id RAA29497
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 17:31:13 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id RAA15292
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 17:31:12 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id RAA15287
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 17:31:11 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Wed, 12 Jan 2000 17:31:11 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: Re: cross-compile fails
In-Reply-To: <Pine.GSO.4.21.0001121447120.3077-100000@z.glue.umd.edu>
Message-ID: <Pine.GSO.4.21.0001121729110.15153-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Ugh.. turns out I missed a faq.

Just went into arch/mips and removed -N from the Makefile, and it worked
like a charm... I've been trying to get Linux on this box off and on for 2
years... ;)  Now time to get the Personal Iris working ;)

thanks for the help everyone,
Vince

____________
\  /\  /\  /  Vince Weaver          
 \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave
