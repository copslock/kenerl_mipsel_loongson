Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 18:12:50 +0000 (GMT)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:53731 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225256AbVAMSMp>;
	Thu, 13 Jan 2005 18:12:45 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j0DIChuo023838;
	Thu, 13 Jan 2005 13:12:43 -0500
Received: from localhost (mail@vpn50-89.rdu.redhat.com [172.16.50.89])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j0DICgr23969;
	Thu, 13 Jan 2005 13:12:42 -0500
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1Cp9Sa-0000CK-00; Thu, 13 Jan 2005 18:12:40 +0000
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
	<20050107.004521.74752947.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.61.0501101503020.18023@perivale.mips.com>
	<20050111.022138.25909508.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.61.0501101750420.18023@perivale.mips.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Thu, 13 Jan 2005 18:12:40 +0000
In-Reply-To: <Pine.LNX.4.61.0501101750420.18023@perivale.mips.com> (Maciej
 W. Rozycki's message of "Mon, 10 Jan 2005 18:11:14 +0000 (GMT)")
Message-ID: <874qhltcyv.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@mips.com> writes:
> On Tue, 11 Jan 2005, Atsushi Nemoto wrote:
>
>> Well, maybe the 'volatile' have no sense, but some archs (including
>> i386, of course :-)) and some drivers use it.  Adding the 'volatile'
>> will remove some compiler warnings.
>
>  As will removing "volatile" from broken ports.

There's nothing wrong with "volatile void *".

Richard
