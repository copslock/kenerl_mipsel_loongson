Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 21:41:57 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:11908 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8225745AbUEJUl4>;
	Mon, 10 May 2004 21:41:56 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i4AKfs0m022436;
	Mon, 10 May 2004 16:41:54 -0400
Received: from localhost (mail@vpnuser4.surrey.redhat.com [172.16.9.4])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i4AKfrv23584;
	Mon, 10 May 2004 16:41:53 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BNHaz-0003Ep-00; Mon, 10 May 2004 21:41:53 +0100
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol
 table entry st_value
References: <045b01c43155$1e06cd80$8d01010a@prefect>
	<874qqpg2ti.fsf@redhat.com> <012701c43607$83aa65f0$8d01010a@prefect>
	<87pt9cwwzu.fsf@redhat.com> <00e201c436b9$5fa0f450$8d01010a@prefect>
	<878yg0m9db.fsf@redhat.com> <01a901c436ce$7029d890$8d01010a@prefect>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Mon, 10 May 2004 21:41:53 +0100
In-Reply-To: <01a901c436ce$7029d890$8d01010a@prefect> (Bradley D. LaRonde's
 message of "Mon, 10 May 2004 16:36:14 -0400")
Message-ID: <87oeowkoa6.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

"Bradley D. LaRonde" <brad@laronde.org> writes:
> I read this in the spec:
>
>     All externally visible symbols, both defined and undefined,
>     must be hashed into the hash table.
>
> Should libpthread's malloc stub be added to the hash table?

Yes.

> I guess not, but I think that might be happening (haven't verified),
> and libdl finding it in there and thinking it is the real deal, not
> realizing it is just a stub.

If you have an undefined function symbol with st_value != 0, then
that st_value must be for a stub.  That's how the loader can (and is
supposed to) tell the difference.

It's probably a good idea to look at how glibc handles this.

Richard
