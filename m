Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f369o0H21746
	for linux-mips-outgoing; Fri, 6 Apr 2001 02:50:00 -0700
Received: from zeus.wi.leidenuniv.nl (zeus.wi.leidenuniv.nl [132.229.128.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f369nxM21741
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 02:49:59 -0700
Received: from fog.mors.wiggy.net (IDENT:wTSARgWIR2oc2TvjQzZb7wI+c67YRMrH@home143.liacs.nl [132.229.210.143])
	by zeus.wi.leidenuniv.nl (8.9.3/8.9.3/LIACS 1.1) with ESMTP id LAA04383
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 11:49:54 +0200 (MET DST)
Received: (from wichert@localhost)
        by fog.mors.wiggy.net (8.12.0.Beta5/8.12.0.Beta5/Debian 8.12.0-1) id f369bnxk002028
        for linux-mips@oss.sgi.com; Fri, 6 Apr 2001 11:37:49 +0200
Date: Fri, 6 Apr 2001 11:37:49 +0200
From: Wichert Akkerman <wichert@valinux.com>
To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010406113748.F1630@cistron.nl>
Mail-Followup-To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses> <20010402234850.B25228@paradigm.rfc822.org> <017801c0bbc3$78c706a0$0deca8c0@Ulysses> <20010403003059.E25228@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010403003059.E25228@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Apr 03, 2001 at 12:30:59AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Previously Florian Lohoff wrote:
> If you are going to use anything like a package format
> might it be "rpm" or "deb" the dependencies tend to be
> utterly broken as the dependcies are guessed by stuff like
> "ldd" output and friends.

I have code for dpkg that makes it only use objdump which
should work fine.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
