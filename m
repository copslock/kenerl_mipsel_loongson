Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2O0C1g13770
	for linux-mips-outgoing; Fri, 23 Mar 2001 16:12:01 -0800
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2O0C1M13767
	for <linux-mips@oss.sgi.com>; Fri, 23 Mar 2001 16:12:01 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id 6AC51205FA; Fri, 23 Mar 2001 16:11:55 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 23 Mar 2001 16:04:51 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id CD31315961; Fri, 23 Mar 2001 16:11:55 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 7D288686D; Fri, 23 Mar 2001 16:14:36 -0800 (PST)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: "Matthew Dharm" <mdharm@momenco.com>
Subject: RE: Multiple processor support?
Date: Fri, 23 Mar 2001 16:08:13 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
Cc: <linux-mips@oss.sgi.com>
References: <NEBBLJGMNKKEEMNLHGAIKELLCAAA.mdharm@momenco.com>
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIKELLCAAA.mdharm@momenco.com>
MIME-Version: 1.0
Message-Id: <01032316143609.00779@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 23 Mar 2001, Matthew Dharm wrote:
> Well, I'd like to know about both, frankly.  Tho I'm more interested
> in whichever is designed to run on RM7000 series processors.

To the best of my knowledge, the mips64 tree only works in SMP on the ip-27
which is r10K based.  There would be a bit of work to get an RM7K  based
multiprocessor system to run. A fair amount of the "generic" code in
that tree is also pretty ip-27 specific, and so would need to be cleaned up.

I'm working on mips32 SMP support at the moment; there are no existing ports of
this tree to an SMP platform.  The mips64 stuff is certainly much, much more 
mature.  I don't know of any reasons not to use the mips64 side for an RM7K.

-Justin
