Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 18:43:45 +0200 (CEST)
Received: from mx2.redhat.com ([12.150.115.133]:27155 "EHLO mx2.redhat.com")
	by linux-mips.org with ESMTP id <S1123253AbSJPQnp>;
	Wed, 16 Oct 2002 18:43:45 +0200
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id g9GGgrs20888;
	Wed, 16 Oct 2002 12:42:53 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g9GGhYl15006;
	Wed, 16 Oct 2002 12:43:34 -0400
Received: from tonopah.toronto.redhat.com (tonopah.toronto.redhat.com [172.16.14.91])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g9GGhVD06062;
	Wed, 16 Oct 2002 09:43:31 -0700
Received: (from wilson@localhost)
	by tonopah.toronto.redhat.com (8.11.6/8.11.6) id g9GGhUf08543;
	Wed, 16 Oct 2002 12:43:30 -0400
X-Authentication-Warning: tonopah.toronto.redhat.com: wilson set sender to wilson@redhat.com using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alexandre Oliva <aoliva@redhat.com>, "H. J. Lu" <hjl@lucon.org>,
	"David S. Miller" <davem@redhat.com>, rsandifo@redhat.com,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
Subject: Re: MIPS gas relaxation still doesn't work
References: <Pine.GSO.3.96.1021016124113.14774D-100000@delta.ds2.pg.gda.pl>
From: Jim Wilson <wilson@redhat.com>
Date: 16 Oct 2002 12:43:30 -0400
In-Reply-To: <Pine.GSO.3.96.1021016124113.14774D-100000@delta.ds2.pg.gda.pl>
Message-ID: <xwu1y6qqqq5.fsf@tonopah.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wilson@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@redhat.com
Precedence: bulk
X-list: linux-mips

>  Still for "-mips2" the code is not exactly perfect:

I'm guessing that gas is only doing one pass.  When it first looks at the
first load, the nop is necessary.  When it later moves the second load into
the branch delay slot, it doesn't go back and check to see if the nop after
the first load is still necessary.  To get this perfect, we would have to
add global optimization support to gas, so that it considered all nop
insertions and branch delay slot filling all at the same time, and iterated
until it got the best code.  I think it is pointless to do this kind of
stuff in an assembler when we already have an optimizing compiler that already
has infrastructure to do this kind of stuff.

Jim
