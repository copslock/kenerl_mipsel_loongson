Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2005 11:05:29 +0000 (GMT)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:27109 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225325AbVANLFY>;
	Fri, 14 Jan 2005 11:05:24 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j0EB5M4V005012;
	Fri, 14 Jan 2005 06:05:22 -0500
Received: from talisman.cambridge.redhat.com (talisman.cambridge.redhat.com [172.16.18.81])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j0EB5Lr16054;
	Fri, 14 Jan 2005 06:05:21 -0500
Received: from talisman.cambridge.redhat.com (localhost.localdomain [127.0.0.1])
	by talisman.cambridge.redhat.com (8.13.1/8.12.10) with ESMTP id j0EB5Ks4006385;
	Fri, 14 Jan 2005 11:05:20 GMT
Received: (from rsandifo@localhost)
	by talisman.cambridge.redhat.com (8.13.1/8.12.10/Submit) id j0EB5IJR006382;
	Fri, 14 Jan 2005 11:05:18 GMT
X-Authentication-Warning: talisman.cambridge.redhat.com: rsandifo set sender to rsandifo@redhat.com using -f
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: macro@mips.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
References: <874qhltcyv.fsf@redhat.com>
	<Pine.LNX.4.61.0501131824350.21179@perivale.mips.com>
	<87k6qh2e6j.fsf@redhat.com>
	<20050114.105227.25909305.nemoto@toshiba-tops.co.jp>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Fri, 14 Jan 2005 11:05:18 +0000
In-Reply-To: <20050114.105227.25909305.nemoto@toshiba-tops.co.jp> (Atsushi
 Nemoto's message of "Fri, 14 Jan 2005 10:52:27 +0900 (JST)")
Message-ID: <wvnr7komftd.fsf@talisman.cambridge.redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto <anemo@mba.ocn.ne.jp> writes:
> rsandifo> You can't dereference it, obviously, just like you can't
> rsandifo> deference a normal "void *".  But you can assign it to any
> rsandifo> "volatile T *" without an explicit cast.  I assumed that's
> rsandifo> what was happening in this case?
>
> Assigning "void *" to "volatile T *" is not a problem.  Compiler warns
> if you assigned "volatile T *" to "void *".

Ooops!  Quite right, and thanks for the correction.  (That's what
I meant to write really, honest ;)

Richard
