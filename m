Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3N4NHw04217
	for linux-mips-outgoing; Sun, 22 Apr 2001 21:23:17 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3N4NGM04214
	for <linux-mips@oss.sgi.com>; Sun, 22 Apr 2001 21:23:16 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 74673F1A9; Sun, 22 Apr 2001 21:22:33 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 02AFD1F42A; Sun, 22 Apr 2001 21:23:01 -0700 (PDT)
Date: Sun, 22 Apr 2001 21:23:01 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: Question on the binutils tradlittlemips patch
Message-ID: <20010422212301.B6180@foobazco.org>
References: <20010418141959.A24473@nevyn.them.org> <3ADDFD6A.AD0DDE4A@cotw.com> <20010418163727.A29531@nevyn.them.org> <20010422180718.A6180@foobazco.org> <20010422221953.A9097@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010422221953.A9097@nevyn.them.org>; from dan@debian.org on Sun, Apr 22, 2001 at 10:19:53PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 22, 2001 at 10:19:53PM -0400, Daniel Jacobowitz wrote:

> I have them working in the case I care about - no backwards
> compatibility at all.  We (Monta Vista) can get away with this :)
> I've attached the patches.

This looks like what I have come up with as well.  I don't care about
backward compatibility either.  If someone else wants to support
broken crap that's their problem; in an age where we have scripts and
makefiles to rebuild entire systems from source I can't see the point
of binary compatibility.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
