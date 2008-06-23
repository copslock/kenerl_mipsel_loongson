Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 21:50:38 +0100 (BST)
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:53412 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20033139AbYF0Uub (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2008 21:50:31 +0100
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id j0bJ1Z0010FhH24A90Na00; Fri, 27 Jun 2008 20:50:25 +0000
Received: from gateway.sf.frob.com ([76.102.158.52])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id j8q31Z00J18718U8U8q5HD; Fri, 27 Jun 2008 20:50:11 +0000
X-Authority-Analysis: v=1.0 c=1 a=f_TSGl8dQXkA:10 a=gn5pNIY5nxUA:10
 a=RYFLW6ebtpNBegQnzZ7X4w==:17 a=iJ7ttKOoKSHTIREEO6wA:9
 a=cdqi69MvmKOUtvyyEcDVvSjcS3QA:4 a=XF7b4UCPwd8A:10
Received: from magilla.localdomain (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id 85F6F3705; Fri, 27 Jun 2008 13:49:56 -0700 (PDT)
Received: by magilla.localdomain (Postfix, from userid 5281)
	id DA76515427E; Mon, 23 Jun 2008 13:08:51 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Roland McGrath <roland@redhat.com>
To:	Adrian Bunk <bunk@kernel.org>
X-Fcc:	~/Mail/linus
Cc:	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
	cooloney@kernel.org, dev-etrax@axis.com, dhowells@redhat.com,
	gerg@uclinux.org, yasutake.koichi@jp.panasonic.com,
	linux-parisc@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org,
	chris@zankel.net, linux-mips@linux-mips.org,
	ysato@users.sourceforge.jp,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
In-Reply-To: Adrian Bunk's message of  Monday, 23 June 2008 20:48:09 +0300 <20080623174809.GE4756@cs181140183.pp.htv.fi>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
X-Shopping-List: (1) Ingenious competition rice
   (2) Famous persecuters
   (3) Disorienting rectractors
   (4) Ostentatious rectractors
   (5) Prosthetic tape
Message-Id: <20080627204953.DA76515427E@magilla.localdomain>
Date:	Mon, 23 Jun 2008 13:08:51 -0700 (PDT)
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

That all looks fine to me, though I won't claim to have paid close
attention to the nits in the various odd archs' files.

Thanks,
Roland
