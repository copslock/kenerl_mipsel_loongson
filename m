Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 15:02:05 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:36439 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225213AbTBJPCE>;
	Mon, 10 Feb 2003 15:02:04 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id B88ADC906; Mon, 10 Feb 2003 16:01:40 +0100 (CET)
To: Vivien Chappelier <vivienc@nerim.net>
Cc: linux-mips@linux-mips.org,
	Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
Subject: Re: porting arcboot
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.21.0302101533410.1709-100000@melkor> (Vivien
 Chappelier's message of "Mon, 10 Feb 2003 15:37:16 +0100 (CET)")
References: <Pine.LNX.4.21.0302101533410.1709-100000@melkor>
Date: Mon, 10 Feb 2003 16:01:40 +0100
Message-ID: <861y2g2n8r.fsf@trasno.mitica>
User-Agent: Gnus/5.090012 (Oort Gnus v0.12) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "vivien" == Vivien Chappelier <vivienc@nerim.net> writes:

vivien> Thiemo told me that his R10k I2s PROM only loads 64bit executables.
vivien> Don't know if the rest of IP22 can laod 64bit executables at all.

I don't think so, mine (I2) only allows ECOFF, ELF is too young for it
:p

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
