Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JGrvo00705
	for linux-mips-outgoing; Fri, 19 Oct 2001 09:53:57 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JGrtD00702
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 09:53:55 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9JGu5B09897;
	Fri, 19 Oct 2001 09:56:05 -0700
Message-ID: <3BD05A9A.BD06491C@mvista.com>
Date: Fri, 19 Oct 2001 09:53:46 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Strange behavior of serial console under 2.4.9
References: <20011018185717.A8135@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> The serial console under 2.4.9 is very strange. It is very slow. I have
> no such problem with 2.4.3/2.4.5. Telnet is fine.
> 

That is usually a symptom when the serial interrupts are not correctly
delivered.

Jun
