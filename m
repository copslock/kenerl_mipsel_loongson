Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2002 23:29:13 +0200 (CEST)
Received: from mx2.redhat.com ([12.150.115.133]:47632 "EHLO mx2.redhat.com")
	by linux-mips.org with ESMTP id <S1123903AbSJNV3N>;
	Mon, 14 Oct 2002 23:29:13 +0200
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id g9ELSOs08647;
	Mon, 14 Oct 2002 17:28:24 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id g9ELT0l05213;
	Mon, 14 Oct 2002 17:29:00 -0400
Received: from dhcp-172-16-25-153.sfbay.redhat.com (dhcp-172-16-25-153.sfbay.redhat.com [172.16.25.153])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g9ELSxD08821;
	Mon, 14 Oct 2002 14:28:59 -0700
Subject: Re: MIPS gas relaxation still doesn't work
From: Eric Christopher <echristo@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Alexandre Oliva <aoliva@redhat.com>,
	"David S. Miller" <davem@redhat.com>, rsandifo@redhat.com,
	linux-mips@linux-mips.org, gcc@gcc.gnu.org,
	binutils@sources.redhat.com
In-Reply-To: <20021014132352.A489@lucon.org>
References: <20021014123940.A32333@lucon.org>
	<20021014.123510.00003943.davem@redhat.com>
	<20021014125549.A32575@lucon.org>
	<20021014.125134.98070597.davem@redhat.com>
	<20021014130932.A32693@lucon.org>
	<orwuokzs9k.fsf@free.redhat.lsd.ic.unicamp.br> 
	<20021014132352.A489@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Oct 2002 14:25:00 -0700
Message-Id: <1034630700.18841.0.camel@ghostwheel>
Mime-Version: 1.0
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Mon, 2002-10-14 at 13:23, H. J. Lu wrote:
> On Mon, Oct 14, 2002 at 05:20:55PM -0300, Alexandre Oliva wrote:
> > On Oct 14, 2002, "H. J. Lu" <hjl@lucon.org> wrote:
> > 
> > > If gcc just emits
> > 
> > > 	bne     $2,$0,$L7493
> > > 	j       $L2
> > 
> > IIRC, that's exactly what GCC will emit if you don't tell it to try to
> > fill delay slots.  If it tries to fill delay slots and fails, I doubt
> > the assembler is going to succeed at that.
> 
> Is that a way to tell gcc not to fill the delay slots with nop? If gcc
> has nothing else to fill, do nothing and let gas do its thing.
> 

Read mips_output_conditional_branch ()

-eric

-- 
Yeah, I used to play basketball...
