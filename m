Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 19:15:05 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:21150 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8226651AbVGLSOr>; Tue, 12 Jul 2005 19:14:47 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc13) with SMTP
          id <2005071218154201300k2uihe>; Tue, 12 Jul 2005 18:15:42 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: mips64  crosstool
Date:	Tue, 12 Jul 2005 14:15:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWEo3u2Inwh4UBxQ0mDfgvpEG82RwCP0cLwAAqXrIA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050712181447Z8226651-3678+2808@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips


Is anyone using crosstool to produce a 64 bit mips compiler?  

I need to produce a gcc that will accept the -mabi=64 option. I have been
able to generate a 32bit gcc with crosstool, using
TARGET=mips-unknown-linux-gnu.  Must I change this to
TARGET=mips64-unkown-linux-gnu to create a 64bit compiler?  I have tried
this, but crosstool will fail.  It appears as if -mabi=n32 is passed to the
native gcc during the build-glibc-headers step.  This of course causes the
native gcc to give up.

Are there any patches for mips64 tool chain build?  

Thanks to all.
Bryan
