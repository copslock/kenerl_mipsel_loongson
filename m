Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 09:38:47 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.225]:40578 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20044203AbYFPIio (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 09:38:44 +0100
Received: by wr-out-0506.google.com with SMTP id 58so2909144wri.8
        for <linux-mips@linux-mips.org>; Mon, 16 Jun 2008 01:38:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=PgomTtOJOgtQkdsquS656yk5+fY1LoKtr/GjFgkO5Wk=;
        b=Pq4K4eT+N8qaapr2jAyetsbfR1nTVWHN5kbdsMA9S9eJjBjLn6awz3nvJCT5sEl4cF
         uZzI2VqvlFgF8dg6qdTSsPRjsqLOcXvz6ZgUK7wJLib/SAjxeehbZPNLc1EFNSkuz4Dv
         gyM9Ztyt5qWsHQt1rZ+jXUAwepntFYxXcnd70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=o3drwGEFdG0B0bjDahWCQ0/8Be2BTWLfiBj+BW+OqrUwhZyhDy3M28uTeJwjL1iuOW
         0ylLbxR0l0/nsPF//o/dL6ZaUmj561ZvDVk5elihJZDDCHccpsf2bD+J3U6VUOIcMPuw
         /ffnVyJVPswte90PertLoWchf7QRdMGLdvyAQ=
Received: by 10.90.94.2 with SMTP id r2mr6623976agb.46.1213605522555;
        Mon, 16 Jun 2008 01:38:42 -0700 (PDT)
Received: by 10.90.70.11 with HTTP; Mon, 16 Jun 2008 01:38:42 -0700 (PDT)
Message-ID: <64660ef00806160138i7a5ba93cu926d112625ee401d@mail.gmail.com>
Date:	Mon, 16 Jun 2008 09:38:42 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Florian Fainelli" <florian.fainelli@telecomint.eu>
Subject: =?WINDOWS-1256?Q?Re:_[PATCH]_:_Add_support_for_NXP_PNX833?= =?WINDOWS-1256?Q?x_(STB222/5)_into_linux_kernel=FE_(UPDATE)?=
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: b87bdad3278a7fee
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

Once again comments appreciated, however there does not seem to be a
conclusion to changes I should make to my (Updated) patch.

Does this means the patch is acceptable as it stands? Or is further
rework required?

Many thanks
Daniel Laird
