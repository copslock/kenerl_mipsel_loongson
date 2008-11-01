Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 17:23:44 +0000 (GMT)
Received: from skell.loowit.net ([206.123.106.155]:31108 "EHLO
	skell.loowit.net") by ftp.linux-mips.org with ESMTP
	id S22923451AbYKARXg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Nov 2008 17:23:36 +0000
Received: from rbk.st3.colton.com ([216.155.210.131] helo=localhost.localdomain)
	by skell.loowit.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <james@loowit.net>)
	id 1KwKBy-0003ih-Qo; Sat, 01 Nov 2008 10:23:19 -0700
Message-ID: <490C907A.40005@loowit.net>
Date:	Sat, 01 Nov 2008 10:23:06 -0700
From:	James Perkins <james@loowit.net>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	libc-ports@sources.redhat.com, Daniel Jacobowitz <drow@false.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
References: <490A912A.8030901@gentoo.org>
In-Reply-To: <490A912A.8030901@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <james@loowit.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james@loowit.net
Precedence: bulk
X-list: linux-mips


      "move	%1,%3\n\t"		      \
      "sc	%1,%4\n\t"		      \
-     "beqz	%1,1b\n"		      \
+     R10K_BEQZ_INSN			      \
      acq	"\n\t"			      \
      ".set	pop\n"			      \

Is it possible to leave the parameters in the inline code and
remove them from the macro definition? I feel the code is more
readable without having to refer to the macro definition if
the parameters are left in place.

Cheers,
James
