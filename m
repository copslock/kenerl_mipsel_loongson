Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DJRq825396
	for linux-mips-outgoing; Fri, 13 Jul 2001 12:27:52 -0700
Received: from hefeweizen.linnaean.org (hefeweizen.cv.linnaean.org [209.58.179.123])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DJRmV25391;
	Fri, 13 Jul 2001 12:27:48 -0700
Received: from perdition.linnaean.org (hagx.ne.mediaone.net [24.147.20.16])
	by hefeweizen.linnaean.org (8.9.3/8.9.3/AI2.13/linnaean.master:2.6) with ESMTP id PAA19543;
	Fri, 13 Jul 2001 15:25:36 -0400 (EDT)
Received: by perdition.linnaean.org (Postfix, from userid 5281)
	id 36A9199766; Fri, 13 Jul 2001 15:25:00 -0400 (EDT)
From: Roland McGrath <roland@frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
In-Reply-To: Ralf Baechle's message of  Fri, 13 July 2001 11:26:36 +0200 <20010713112635.A32010@bacchus.dhis.org>
Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Message-Id: <20010713192500.36A9199766@perdition.linnaean.org>
Date: Fri, 13 Jul 2001 15:25:00 -0400 (EDT)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Afair there is no requirement for loadable segments to be sorted

PT_LOAD entries appear in ascending order, sorted on the p_vaddr member.
