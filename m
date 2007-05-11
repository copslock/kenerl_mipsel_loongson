Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 14:56:46 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:7865 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022616AbXEKN4o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 14:56:44 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 8D6158648B;
	Fri, 11 May 2007 15:50:15 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1HmVWc-0004U6-8S; Fri, 11 May 2007 14:51:14 +0100
Date:	Fri, 11 May 2007 14:51:14 +0100
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Message-ID: <20070511135114.GA16014@networkno.de>
References: <20070511.010234.74566169.anemo@mba.ocn.ne.jp> <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Hi Atsushi,
> 
> On 5/10/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >On 64-bit MIPS, only N64 ABI is checked by default.  This patch adds
> >some rules for other ABIs.  This results in these warnings at the
> >moment:
> >
> 
> nice to see this second version which is nicer IMHO.
> 
> >  CALL-N32 /home/git/linux-mips/scripts/checksyscalls.sh
> ><stdin>:148:2: warning: #warning syscall time not implemented
> ><stdin>:424:2: warning: #warning syscall select not implemented
> ><stdin>:440:2: warning: #warning syscall uselib not implemented
> ><stdin>:856:2: warning: #warning syscall vfork not implemented
> ><stdin>:868:2: warning: #warning syscall truncate64 not implemented
> ><stdin>:872:2: warning: #warning syscall ftruncate64 not implemented
> ><stdin>:876:2: warning: #warning syscall stat64 not implemented
> ><stdin>:880:2: warning: #warning syscall lstat64 not implemented
> ><stdin>:884:2: warning: #warning syscall fstat64 not implemented
> ><stdin>:980:2: warning: #warning syscall getdents64 not implemented
> ><stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
> ><stdin>:1284:2: warning: #warning syscall fstatat64 not implemented
> ><stdin>:1364:2: warning: #warning syscall utimensat not implemented
> >  CALL-O32 /home/git/linux-mips/scripts/checksyscalls.sh
> ><stdin>:424:2: warning: #warning syscall select not implemented
> ><stdin>:856:2: warning: #warning syscall vfork not implemented
> ><stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
> ><stdin>:1364:2: warning: #warning syscall utimensat not implemented
> >  CALL    /home/git/linux-mips/scripts/checksyscalls.sh
> ><stdin>:148:2: warning: #warning syscall time not implemented
> ><stdin>:424:2: warning: #warning syscall select not implemented
> ><stdin>:440:2: warning: #warning syscall uselib not implemented
> ><stdin>:856:2: warning: #warning syscall vfork not implemented
> ><stdin>:980:2: warning: #warning syscall getdents64 not implemented
> ><stdin>:1364:2: warning: #warning syscall utimensat not implemented
> >
> 
> woah, quite a lot of works are waiting for you ;)

AFAICS everything except utimensat is a false positive.


Thiemo
