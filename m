Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 19:21:10 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:24742 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225718AbUEJSVJ>;
	Mon, 10 May 2004 19:21:09 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i4AIL70m019758;
	Mon, 10 May 2004 14:21:07 -0400
Received: from localhost (mail@vpnuser4.surrey.redhat.com [172.16.9.4])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i4AIL6v08276;
	Mon, 10 May 2004 14:21:06 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BNFOj-0006Fy-00; Mon, 10 May 2004 19:21:05 +0100
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol
 table entry st_value
References: <045b01c43155$1e06cd80$8d01010a@prefect>
	<874qqpg2ti.fsf@redhat.com> <012701c43607$83aa65f0$8d01010a@prefect>
	<87pt9cwwzu.fsf@redhat.com> <00e201c436b9$5fa0f450$8d01010a@prefect>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Mon, 10 May 2004 19:21:04 +0100
In-Reply-To: <00e201c436b9$5fa0f450$8d01010a@prefect> (Bradley D. LaRonde's
 message of "Mon, 10 May 2004 14:05:27 -0400")
Message-ID: <878yg0m9db.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Bradley D. LaRonde" <brad@laronde.org> writes:
> Even though it is pointing libdl to the libpthread stub for malloc, should
> it crash?

Yeah.  When you call a stub, $gp must already be set to the owning
object's _gp.  That's how the dynamic loader knows which GOT to change.

In your case, libdl will be calling libpthread's stub with $gp set to
libdl's _gp.  The dynamic loader will therefore end up trying to change
libdl's GOT, not libpthread's.

Richard
