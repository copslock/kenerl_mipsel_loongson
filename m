Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA58131 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 09:40:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA29209
	for linux-list;
	Sun, 19 Jul 1998 09:40:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA10699
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 09:40:07 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: from helix.life.nthu.edu.tw (helix.life.nthu.edu.tw [140.114.98.34]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA26083
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 09:40:05 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by helix.life.nthu.edu.tw (8.8.7/8.8.7) id AAA07974;
	Mon, 20 Jul 1998 00:38:32 +0800
Message-ID: <19980720003832.A7963@helix.life.nthu.edu.tw>
Date: Mon, 20 Jul 1998 00:38:32 +0800
From: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>
To: ralf@uni-koblenz.de
Cc: Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: benchmark........
References: <19980719233527.A7930@helix.life.nthu.edu.tw> <19980719183508.16421@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980719183508.16421@uni-koblenz.de>; from ralf@uni-koblenz.de on Sun, Jul 19, 1998 at 06:35:08PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 19, 1998 at 06:35:08PM +0200, ralf@uni-koblenz.de wrote:
> On Sun, Jul 19, 1998 at 11:35:27PM +0800, Francis M. J. Hsieh wrote:
> 
> > Well, here is a benchmark using MDBNCH, a benchmark program doing floating
> > point calculation on molecular dynamics (one of the research fields of out lab)
> 
> This benchmark probably only really tests the compiler's optimization
> and the machine performance?  Anyway, the results would be somewhat
> more interesting if you'd have IRIX results at hand?

The line contain g77 is the result on linux, others are on irix.
I am sorry that I didn't point that out. :-)

-- 
Francis M. J. Hsieh      | Email:   mjhsieh@life.nthu.edu.tw
Life Science Department, | Webpage: http://www.life.nthu.edu.tw/~mjhsieh/
National Tsing Hua Univ, | Voice:   +886 3 5715131 ext 3482
HsinChu, Taiwan Republic | 	    +886 3 5715649
