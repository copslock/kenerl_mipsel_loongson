Received:  by oss.sgi.com id <S305162AbQBUVvJ>;
	Mon, 21 Feb 2000 13:51:09 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:43032 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQBUVut>;
	Mon, 21 Feb 2000 13:50:49 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA03042; Mon, 21 Feb 2000 13:46:17 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA97608
	for linux-list;
	Mon, 21 Feb 2000 13:38:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA77173
	for <linux@engr.sgi.com>;
	Mon, 21 Feb 2000 13:38:14 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08773
	for <linux@engr.sgi.com>; Mon, 21 Feb 2000 13:38:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-13.uni-koblenz.de (cacc-13.uni-koblenz.de [141.26.131.13])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id WAA11990;
	Mon, 21 Feb 2000 22:37:49 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407897AbQBUSDw>;
	Mon, 21 Feb 2000 19:03:52 +0100
Date:   Mon, 21 Feb 2000 19:03:52 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000221190352.B15668@uni-koblenz.de>
References: <20000221125820.A11469@uni-koblenz.de> <Pine.GSO.4.10.10002211634260.4234-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.10.10002211634260.4234-100000@dandelion.sonytel.be>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Feb 21, 2000 at 04:46:52PM +0100, Geert Uytterhoeven wrote:

> I guess the problem is the nested .set noat/at construct, where __MODULE_JAL
> does .set at while copy_from_user() assumes we're still in noat mode?

Yep, looking at the assembler code your report immediately made sense.
Fix going to CVS as I write this.

  Ralf
