Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 16:01:18 +0000 (GMT)
Received: from bsdimp.com ([199.45.160.85]:23281 "EHLO harmony.bsdimp.com")
	by ftp.linux-mips.org with ESMTP id S28591454AbYB1QBQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Feb 2008 16:01:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by harmony.bsdimp.com (8.14.2/8.14.1) with ESMTP id m1SG0PD4061282;
	Thu, 28 Feb 2008 09:00:26 -0700 (MST)
	(envelope-from imp@bsdimp.com)
Date:	Thu, 28 Feb 2008 09:00:58 -0700 (MST)
Message-Id: <20080228.090058.-126817608.imp@bsdimp.com>
To:	ralf@linux-mips.org
Cc:	daniel.j.laird@nxp.com, linux-mips@linux-mips.org
Subject: Re: Move arch/mips/philips to arch/mips/nxp
From:	"M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20080228094240.GD2750@linux-mips.org>
References: <64660ef00802270250sae0cd4of9512f13f400dfc6@mail.gmail.com>
	<20080228094240.GD2750@linux-mips.org>
X-Mailer: Mew version 5.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imp@bsdimp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imp@bsdimp.com
Precedence: bulk
X-list: linux-mips

In message: <20080228094240.GD2750@linux-mips.org>
            Ralf Baechle <ralf@linux-mips.org> writes:
: The usual pointer here: http://www.linux-mips.org/wiki/The_perfect_patch

Are the references to BitKeeper still relevant here?

>> Bear in mind that the Subject: of your email becomes a
>> globally-unique identifier for that patch. It propagates all the
>> way into BitKeeper. The Subject: may later be used in developer
------------^^^^^^^^^
>> discussions which refer to the patch. People will want to google
>> for the patch's Subject: to read discussion regarding that patch.

and

>> Do not refer to earlier patches when changelogging a new version of
>> a patch. It's not very useful to have a bitkeeper changelog which
-------------------------------------------^^^^^^^^^
>> says "OK, this fixes the things you mentioned yesterday". Each
>> iteration of the patch should contain a standalone changelog. This
>> implies that you need a patch management system which maintains
>> changelogs. See below.

and

>> Don't bother mentioning what version of the kernel the patch
>> applies to ("applies to 2.6.8-rc1"). This is not interesting
>> information - once the patch is in bitkeeper, of _course_ it
--------------------------------------^^^^^^^^^
>> applied, and it'll probably be merged into a later kernel than the
>> one which you wrote it for.

Warner
