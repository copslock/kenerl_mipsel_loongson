Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IISgC11898
	for linux-mips-outgoing; Wed, 18 Apr 2001 11:28:42 -0700
Received: from trasno.mitica (177-CORU-X6.libre.retevision.es [62.83.55.177])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IISeM11895
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 11:28:40 -0700
Received: by trasno.mitica (Postfix, from userid 501)
	id 4388D59F7C; Wed, 18 Apr 2001 20:28:42 +0200 (CEST)
To: Jun Sun <jsun@mvista.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   Scott A McConnell <samcconn@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: kernel/printk.c problem
References: <Pine.GSO.4.10.10104180852450.17832-100000@escobaria.sonytel.be>
	<3ADDCFAB.549DA4FA@mvista.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3ADDCFAB.549DA4FA@mvista.com>
Date: 18 Apr 2001 20:28:42 +0200
Message-ID: <m2vgo2ysdh.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "jun" == Jun Sun <jsun@mvista.com> writes:

jun> Geert Uytterhoeven wrote:
>> 
>> On Tue, 17 Apr 2001, Scott A McConnell wrote:
>> > struct console *console_drivers = NULL;                          <----
>> > Need the NULL.
>> >
>> > Otherwise, bad things can happen on the following statement in printk
>> >
>> > ~line 311
>> >
>> >        if ((c->flags & CON_ENABLED) && c->write){
>> 
>> Current policy is not explicitly initializing variables to zero. If this causes
>> problems, there's a bug in the routine that clears the BSS on kernel entry.
>> 

jun> Interesting.  What is the reason behind the policy?  Is that because
jun> initialized variable are put in a different section that takes more size in
jun> the image?

Yes.  In linux the BSS section (aka non explicitely initialized vars)
is initializated with 0.  The initialzed variables need to be in the
data section of the kernel image (what only adds size, nothing else).

Later, Juan.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
