Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 16:06:51 +0100 (BST)
Received: from p508B7184.dip.t-dialin.net ([IPv6:::ffff:80.139.113.132]:62134
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225266AbTEIPGs>; Fri, 9 May 2003 16:06:48 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h49F6Jts007895;
	Fri, 9 May 2003 17:06:19 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h49F6Csk007894;
	Fri, 9 May 2003 17:06:12 +0200
Date: Fri, 9 May 2003 17:06:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: JinuM <jinum@esntechnologies.co.in>
Cc: linux-mips@linux-mips.org
Subject: Re: open file in kernel mode
Message-ID: <20030509150612.GA7837@linux-mips.org>
References: <AF572D578398634881E52418B28925670EFF20@mail.esn.activedirectory>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF572D578398634881E52418B28925670EFF20@mail.esn.activedirectory>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 09, 2003 at 11:24:25AM +0530, JinuM wrote:

> I am trying to write a firmware loader driver. Instead of reading the
> firmware as a buffer(predefined array)  we would like to read the firmware
> from a file (say /root/firmware). Do we have some function which reads the
> file contents in kernel mode.

This one seems a candidate for an faq ...

Provide some special file in /dev/ and use a small user application to
install the firmware by writing it into that file.

  Ralf
