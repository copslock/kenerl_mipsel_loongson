Received:  by oss.sgi.com id <S553870AbRBITyS>;
	Fri, 9 Feb 2001 11:54:18 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:1291 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553864AbRBITyG>;
	Fri, 9 Feb 2001 11:54:06 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 789D87D9; Fri,  9 Feb 2001 20:53:54 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3ED60EEAC; Fri,  9 Feb 2001 20:54:06 +0100 (CET)
Date:   Fri, 9 Feb 2001 20:54:06 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Re: current cvs broken on sgi
Message-ID: <20010209205406.A26386@paradigm.rfc822.org>
References: <20010209161521.D13248@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010209161521.D13248@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Feb 09, 2001 at 04:15:21PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 09, 2001 at 04:15:21PM +0100, Florian Lohoff wrote:
> Hi,
> can someone confirm that the current cvs ONCE AGAIN is broken
> on SGIs (Indy/I2) ?
> 
> Even with the "early console init" it simply dies ..
> 
I am completely wrong and i fooled myself again - Its the 
"I2 crashes if kernel compiled with newport console" 

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
