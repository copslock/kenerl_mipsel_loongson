Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 10:17:57 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:8258 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225195AbTCMKR4> convert rfc822-to-8bit;
	Thu, 13 Mar 2003 10:17:56 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id F22646EC; Thu, 13 Mar 2003 11:17:54 +0100 (CET)
To: Vincent =?iso-8859-1?q?Stehl=E9?= <vincent.stehle@stepmind.com>
Cc: linux-mips@linux-mips.org
Subject: Re: PROM variables
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3E7057A6.60007@stepmind.com> (Vincent
 =?iso-8859-1?q?Stehl=E9's?= message of "Thu, 13 Mar 2003 11:04:22 +0100")
References: <3E7057A6.60007@stepmind.com>
Date: Thu, 13 Mar 2003 11:17:54 +0100
Message-ID: <86hea7k1t9.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "vincent" == Vincent Stehlé <vincent.stehle@stepmind.com> writes:

vincent> Hi all,

vincent> Is there a way to get/set PROM variables under Linux ?

vincent> I have an indigo2 with no display, and setting the variables without
vincent> reverting to the monitor through the serial line would be very handy.

vincent> As I doubt there is currently a solution, I was thinking about
vincent> implementing this as a /proc subdir. What do you think ?

You can set them through the serial console in the same way that you
can set it in the monitor?

Are you sure that you have set the prom variables to use the serial
console?

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
