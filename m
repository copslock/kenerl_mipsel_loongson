Received:  by oss.sgi.com id <S42189AbQFOWvf>;
	Thu, 15 Jun 2000 15:51:35 -0700
Received: from ha1.rdc1.az.home.com ([24.1.240.66]:52198 "EHLO
        mail.rdc1.az.home.com") by oss.sgi.com with ESMTP id <S42181AbQFOWvP>;
	Thu, 15 Jun 2000 15:51:15 -0700
Received: from CX579290-B ([24.9.123.15]) by mail.rdc1.az.home.com
          (InterMail vM.4.01.02.00 201-229-116) with SMTP
          id <20000615225115.GMWW11091.mail.rdc1.az.home.com@CX579290-B>
          for <linux-mips@oss.sgi.com>; Thu, 15 Jun 2000 15:51:15 -0700
From:   Pete Buechler <peterb@suse.com>
Reply-To: Pete Buechler <peterb@suse.com>
Organization: home
To:     linux-mips@oss.sgi.com
Subject: Maintainer for MIPS version of gcc?
Date:   Thu, 15 Jun 2000 15:49:15 -0700
X-Mailer: KMail [version 1.0.29.1]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00061515510204.02475@CX579290-B>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Dear folks -

While using a version of gcc which I downloaded from CVS  on 09 June 2000, to
compile Linux-VR which I downloaded on 07 June 2000, the compiler complains
that it has hit an internal error and to please file a bug report. I used the
web interface to GNATS to file one early in the day on Tuesday. It told
me that I would get e-mail telling me which developer it went to. I have not
heard back, so I am starting to wonder if I did something wrong or if the
interface is broken.

So, could you tell me who would be interested in looking at an internal gcc
compiler error which is encountered when compiling Linux-VR? If I can find out
who that person is, I will mail them my command, its output, and the
pre-processed source file.

I looked at the pre-processed code, it has some really funky C and in-line
assembly.

 -- 
Pete Buechler	: SuSE Linux Developer
Work e-mail	: peterb@suse.com
Work web page	: http://www.suse.com/~peterb
Personal e-mail	: peter.buechler@home.com
