Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2009 02:49:05 +0000 (GMT)
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:28116
	"EHLO QMTA09.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20808607AbZBZCtD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2009 02:49:03 +0000
Received: from OMTA07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by QMTA09.westchester.pa.mail.comcast.net with comcast
	id LRMT1b0031GhbT859Soxsh; Thu, 26 Feb 2009 02:48:57 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA07.westchester.pa.mail.comcast.net with comcast
	id LSow1b00R58Be2l3TSoxCu; Thu, 26 Feb 2009 02:48:57 +0000
Message-ID: <49A60310.9030900@gentoo.org>
Date:	Wed, 25 Feb 2009 21:48:48 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips@linux-mips.org
Subject: Re: [SOLVED] Re: GCC-4.3.3 sillyness
References: <20090130074407.GA12368@roarinelk.homelinux.net> <20090131085957.399614d1@scarran.roarinelk.net> <49A4D370.3080300@gentoo.org>
In-Reply-To: <49A4D370.3080300@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> 
> Yeah, I did some digging and it looks like we added a patch called 
> "10_all_gcc-default-format-security.patch" into our gcc-4.3.3 ebuild.  
> The patch claims it was ripped from Debian; can any Debian devs comment 
> on whether you guys still use this patch and what the idea behind it 
> is?  I'm not sure if I'll find any discussion on our end as to why it's 
> included without finding Mike (vapier) around.

Looks like Gentoo and Debian aren't alone.  This was discussed on lkml because 
other mainstream distros are enabling it as a default as well, so the proposed 
solution is to just disable the format check in the kernel:

http://lkml.org/lkml/2009/2/4/259

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
