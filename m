Received:  by oss.sgi.com id <S553838AbRALV4L>;
	Fri, 12 Jan 2001 13:56:11 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:53266 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553830AbRALVzz>;
	Fri, 12 Jan 2001 13:55:55 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id DA851205FE
	for <linux-mips@oss.sgi.com>; Fri, 12 Jan 2001 13:55:49 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 12 Jan 2001 13:50:24 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id DEB061595F
	for <linux-mips@oss.sgi.com>; Fri, 12 Jan 2001 13:55:49 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id EFDEC686D; Fri, 12 Jan 2001 13:55:47 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS
Date:   Fri, 12 Jan 2001 13:54:49 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01011213554701.08038@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 12 Jan 2001, you wrote:> Justin Carlson wrote:
> > Not if you want to have constant-defined offsets into the table.  Which is just
> > about the only reason to use a table for this...Either:
> > 
> 
> No, I am thinking to have constant-defined offset into the table.  Instead, I
> am thinking to do a linear search of the table and find a matching entry based
> on the PRID.
> 
> Without table, I can see two alternatives, 1) switch/case statement to fill in
> the data by statements (which is the current case) or 2) for each CPU
> (protected by #ifdef CONFIG_) we define a mips_cpu struct.
> 
> I guess I just like table better than switch/case statements.  Table seems
> cleaner to me.

You're not going to get rid of the big switch statement for older (non mips32)
processors because of the specialized checks to refine steppings, etc. 
as it is. 

I still would rather stick to the switch style of doing things in the future,
though, because it's a bit more flexible; if you've got companies that fix
errata without stepping PrID revisions or some such, then the table's going to
have some strange special cases that don't quite fit.

But this is much more workable than what I *thought* you were proposing.  And
not worth nearly as much trouble as I've been giving you over it.    

Luckily, in the end, you have to convince saner people than me.  :)

-Justin
