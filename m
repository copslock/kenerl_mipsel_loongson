Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Sep 2004 09:59:37 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:18385 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224920AbUITI7d>;
	Mon, 20 Sep 2004 09:59:33 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.10) with ESMTP id i8K8xVgm006123;
	Mon, 20 Sep 2004 04:59:31 -0400
Received: from localhost (mail@vpn50-7.rdu.redhat.com [172.16.50.7])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i8K8xTr30012;
	Mon, 20 Sep 2004 04:59:30 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1C9K1A-0000El-00; Mon, 20 Sep 2004 09:59:28 +0100
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: gcc 3.3.4/3.4.1 and get_user
References: <20040901.012223.59462025.anemo@mba.ocn.ne.jp>
	<87656yqsmz.fsf@redhat.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Mon, 20 Sep 2004 09:59:28 +0100
In-Reply-To: <87656yqsmz.fsf@redhat.com> (Richard Sandiford's message of
 "Wed, 01 Sep 2004 09:51:16 +0100")
Message-ID: <87y8j5fh8v.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Richard Sandiford <rsandifo@redhat.com> writes:
> Atsushi Nemoto <anemo@mba.ocn.ne.jp> writes:
>> Is this a get_user's problem or gcc's?
>
> The latter.  gcc is putting the empty asm:
>
> 	__asm__ ("":"=r" (__gu_val));
>
> into the delay slot of the call.

FYI, this is now being tracked as gcc bugzilla PR 17565:

    http://gcc.gnu.org/PR17565

The fix has so far been applied to 4.0.

Richard
