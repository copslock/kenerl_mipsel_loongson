Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDDqar04342
	for linux-mips-outgoing; Thu, 13 Dec 2001 05:52:36 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDDqXo03844
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 05:52:33 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16EVLh-0003qO-00; Thu, 13 Dec 2001 13:52:29 +0100
Date: Thu, 13 Dec 2001 13:52:29 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: flo@rfc822.org
Cc: linux-mips@oss.sgi.com
Subject: Re: Current CVS on Indigo2 fail
Message-ID: <20011213135229.C14699@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: flo@rfc822.org, linux-mips@oss.sgi.com
References: <20011213123522.GA32232@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213123522.GA32232@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Dec 13, 2001 at 01:35:22PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 13, 2001 at 01:35:22PM +0100, Florian Lohoff wrote:
> 
> HI,
> i just tried to boot the current cvs as of a couple minutes old
> on an Indigo2 - It seemt the stuff crashes before its even able to
> print something on the screen.
> 
> Anyone else ?
Can this be the newport vs. I2 issue? I have (again) sent patches to Ralf
to solve this problem...
 -- Guido
