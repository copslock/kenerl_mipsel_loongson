Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 18:09:50 +0200 (CEST)
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:45554 "EHLO
	executor.cambridge.redhat.com") by linux-mips.org with ESMTP
	id <S1122169AbSJNQJt>; Mon, 14 Oct 2002 18:09:49 +0200
Received: from talisman.cambridge.redhat.com (talisman.cambridge.redhat.com [172.16.18.81])
	by executor.cambridge.redhat.com (Postfix) with ESMTP
	id 7D07EABAF8; Mon, 14 Oct 2002 17:09:40 +0100 (BST)
Received: (from rsandifo@localhost)
	by talisman.cambridge.redhat.com (8.11.6/8.11.0) id g9EG9cA12332;
	Mon, 14 Oct 2002 17:09:38 +0100
X-Authentication-Warning: talisman.cambridge.redhat.com: rsandifo set sender to rsandifo@redhat.com using -f
To: "H. J. Lu" <hjl@lucon.org>
Cc: aoliva@redhat.com, linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <20021012113423.A27894@lucon.org>
	<20021013145423.A10174@lucon.org> <20021014082810.A28682@lucon.org>
From: Richard Sandiford <rsandifo@redhat.com>
Date: 14 Oct 2002 17:09:38 +0100
In-Reply-To: <20021014082810.A28682@lucon.org>
Message-ID: <wvnit05ovct.fsf@talisman.cambridge.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"H. J. Lu" <hjl@lucon.org> writes:
> Can gcc be be modified not to generate noreorder/nomacro for branchs if
> gas is used?

Sounds like you're suggesting gcc should leave gas to fill delay slots?

gcc is usually much better at filling delay slots than gas is.  gas just
looks at the previous instruction to see if it's suitable.  gcc can pull
pull instructions from the branch target instead.

Richard
