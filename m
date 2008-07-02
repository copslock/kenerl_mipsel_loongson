Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2008 08:01:41 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11102 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S36907672AbYGBHBf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jul 2008 08:01:35 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B486b27950000>; Wed, 02 Jul 2008 03:00:37 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 00:00:36 -0700
Received: from localhost.localdomain ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 00:00:36 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.2/8.13.7/Debian-2) with ESMTP id m6270YFb016824;
	Wed, 2 Jul 2008 00:00:34 -0700
Received: (from anemet@localhost)
	by localhost.localdomain (8.14.2/8.13.7/Submit) id m6270Xlb016823;
	Wed, 2 Jul 2008 00:00:33 -0700
To:	binutils@sourceware.org
Cc:	gcc@gcc.gnu.org, linux-mips@linux-mips.org,
	rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
References: <87y74pxwyl.fsf@firetop.home>
	<20080701202236.GA1534@caradoc.them.org> <87zlp149ot.fsf@firetop.home>
From:	Adam Nemet <anemet@caviumnetworks.com>
Date:	Wed, 02 Jul 2008 00:00:33 -0700
In-Reply-To: <87zlp149ot.fsf@firetop.home> (Richard Sandiford's message of "Tue, 01 Jul 2008 21:43:30 +0100")
Message-ID: <87myl093e6.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.20 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Jul 2008 07:00:36.0414 (UTC) FILETIME=[54222DE0:01C8DC11]
Return-Path: <Adam.Nemet@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemet@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford writes:
> However, IMO, your argument about MTI being the central authority
> is a killer one.  The purpose of the GNU tools should be to follow
> appropriate standards where applicable (and extend them where it
> seems wise).  So from that point of view, I agree that the GNU tools
> should follow the ABI that Nigel and MTI set down.  Consider my
> patch withdrawn.

While I'm not entirely clear how this decision came about I'd like to point
out that it is unfortunate that MTI had not sought wider consensus for this
ABI extension among MIPS implementors and the community.

We would not be in this situation with duplicated efforts and much frustration
if this proposal had been circulated properly ahead of time.

> I've been thinking about that a lot recently, since I heard about
> your implementation.  I kind-of guessed it had been agreed with MTI
> beforehand (although I hadn't realised MTI themselves had written
> the specification).  Having thought it over, I think it would be best
> if I stand down as a MIPS maintainer and if someone with the appropriate
> commercial connections is appointed instead.  I'd recommend any
> combination of yourself, Adam Nemet and David Daney (subject to
> said people being willing, of course).

Richard, while I understand your frustration I really hope that you will
reconsider your decision and remain the MIPS maintainer.  I think there is a
chance that if the community expresses that MTI should seek broader consensus
for such proposals they will do so in the future.

Your expertise as the GCC maintainer has improved the backend tremendously and
and you should be given all the information necessary to continue your great
work.

Adam
