Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 11:37:43 +0000 (GMT)
Received: from ftp.ckdenergo.cz ([IPv6:::ffff:80.95.97.155]:42200 "EHLO simek")
	by linux-mips.org with ESMTP id <S8225223AbTCMLhm>;
	Thu, 13 Mar 2003 11:37:42 +0000
Received: from ladis by simek with local (Exim 3.36 #1 (Debian))
	id 18tQxc-0001g4-00; Thu, 13 Mar 2003 12:33:20 +0100
Date: Thu, 13 Mar 2003 12:33:10 +0100
To: Guido Guenther <agx@sigxcpu.org>,
	Vincent =?iso-8859-2?Q?Stehl=E9?= <vincent.stehle@stepmind.com>,
	linux-mips@linux-mips.org
Subject: Re: PROM variables
Message-ID: <20030313113310.GA6151@simek>
References: <3E7057A6.60007@stepmind.com> <20030313102601.GD24866@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313102601.GD24866@bogon.ms20.nix>
User-Agent: Mutt/1.5.3i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 13, 2003 at 11:26:01AM +0100, Guido Guenther wrote:
[snip]
> > As I doubt there is currently a solution, I was thinking about 
> > implementing this as a /proc subdir. What do you think ?
> What about multiple files in /proc/arcs which have the PROM variables as
> name and its value as contents? 

hmm, how would you add/remove variable?

> When doing this I'd write into the NVRAM directly instead of using the
> Arcs functions, I think the necessary info is in the IRIX headers.
> Regards,
>  -- Guido
