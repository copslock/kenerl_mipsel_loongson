Received:  by oss.sgi.com id <S305162AbQAaEiu>;
	Sun, 30 Jan 2000 20:38:50 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:11097 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQAaEim>; Sun, 30 Jan 2000 20:38:42 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA09602; Sun, 30 Jan 2000 20:44:09 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA11784
	for linux-list;
	Sun, 30 Jan 2000 20:28:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA06940
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Jan 2000 20:28:02 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA04627
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Jan 2000 20:28:01 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-17.uni-koblenz.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id FAA17436;
	Mon, 31 Jan 2000 05:27:56 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407893AbQAaE10>;
	Mon, 31 Jan 2000 05:27:26 +0100
Date:   Mon, 31 Jan 2000 05:27:26 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Florian Lohoff <flo@rfc822.org>, Ralf Baechle <ralf@oss.sgi.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu
Subject: Re: WCHAN on R3000
Message-ID: <20000131052726.A12033@uni-koblenz.de>
References: <000801bf6b14$51b2e620$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <000801bf6b14$51b2e620$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Jan 30, 2000 at 12:22:27PM +0100, Kevin D. Kissell wrote:

> Why on earth would ps be doing a floating point
> conversion in the course of displaying wchan,
> anyway???

Nothing.  Last I checked ps the fp calculation was for displaying the time
column.

  Ralf
