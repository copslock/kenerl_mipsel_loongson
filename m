Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 01:21:24 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:8489 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225203AbTBGBVX>;
	Fri, 7 Feb 2003 01:21:23 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id C31C4C4B1; Fri,  7 Feb 2003 02:20:58 +0100 (CET)
To: Jun Sun <jsun@mvista.com>
Cc: Vivien Chappelier <vivienc@nerim.net>,
	Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] clear USEDFPU in copy_thread
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030206164342.G13258@mvista.com> (Jun Sun's message of "Thu,
 6 Feb 2003 16:43:42 -0800")
User-Agent: Gnus/5.090012 (Oort Gnus v0.12) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
References: <Pine.LNX.4.21.0302042349200.31806-100000@melkor>
	<20030206164342.G13258@mvista.com>
Date: Fri, 07 Feb 2003 02:20:58 +0100
Message-ID: <86hebgj37p.fsf@trasno.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "jun" == Jun Sun <jsun@mvista.com> writes:

Hi

jun> Even if you don't have it cleared in start_thread(), things
jun> should be generally OK.  You will have some dirty FPU content
jun> instead of a all-zero one when you start a new program.  But then
jun> since all sane program should assign register values before they
jun> first time use them, so this bug should be well hidden.

I don't remind the exact details, but the problem appears to be the
security implications, you can see last values of previous process.

Yes, I still have to find a way where that is useful, but ...

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
