Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2GM8aG16145
	for linux-mips-outgoing; Fri, 16 Mar 2001 14:08:36 -0800
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2GM8aM16142
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 14:08:36 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP id DE571205FC
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 14:08:30 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 16 Mar 2001 14:01:36 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP id 9E69C1595F
	for <linux-mips@oss.sgi.com>; Fri, 16 Mar 2001 14:08:30 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 34823686D; Fri, 16 Mar 2001 14:11:03 -0800 (PST)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: linux-mips@oss.sgi.com
Subject: Re: mips64 pgd_current
Date: Fri, 16 Mar 2001 14:09:42 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <01031613005000.00780@plugh.sibyte.com>
In-Reply-To: <01031613005000.00780@plugh.sibyte.com>
MIME-Version: 1.0
Message-Id: <01031614110304.00780@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


As is often the case, I answered my own question my being figuring out how to
state it; everything happens as I described, but on context switch, the
pgd_current stuff is reset appropriately.

Sorry for the noise.

-Justin
