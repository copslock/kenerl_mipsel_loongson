Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 22:41:03 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:9411 "EHLO demo.mitica")
	by linux-mips.org with ESMTP id <S8225241AbSLKWlC>;
	Wed, 11 Dec 2002 22:41:02 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 80E9CD657; Wed, 11 Dec 2002 23:46:20 +0100 (CET)
To: ilya@theIlya.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: O2 VICE support
References: <20021210191120.GE609@gateway.total-knowledge.com>
	<20021211133831.A19300@infradead.org>
	<20021211221629.GP609@gateway.total-knowledge.com>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20021211221629.GP609@gateway.total-knowledge.com>
Date: 11 Dec 2002 23:46:20 +0100
Message-ID: <m2d6o8mawz.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ilya" == ilya  <ilya@theIlya.com> writes:


>> 
>> > +void vice_cleanup_module(void)
>> > +{
>> > +#ifndef CONFIG_DEVFS_FS
>> > +    /* cleanup_module is never called if registering failed */
>> > +    unregister_chrdev(vice_major, "vice");
>> > +#endif
>> 
>> Umm, just because someone makes the mistake of enabling devfs he
>> doesn't have to use it.. :)
ilya> I'm not buying that one :)

Read behind the joke:
- you have devfs compiled in
- you don't have devfs mounted

Conclusion:
        there is a bug in your code :)

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
