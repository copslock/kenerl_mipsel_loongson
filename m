Received:  by oss.sgi.com id <S553808AbQLHNqf>;
	Fri, 8 Dec 2000 05:46:35 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:38898 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553803AbQLHNqL>;
	Fri, 8 Dec 2000 05:46:11 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA12067;
	Fri, 8 Dec 2000 14:32:57 +0100 (MET)
Date:   Fri, 8 Dec 2000 14:32:56 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Nicu Popovici <octavp@isratech.ro>
cc:     linux-mips@oss.sgi.com
Subject: Re: ODD question.
In-Reply-To: <3A314835.CE0FE333@isratech.ro>
Message-ID: <Pine.GSO.3.96.1001208140947.6796F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 8 Dec 2000, Nicu Popovici wrote:

> Can you tell me the parameters for a building a cross-toolchain  for
> SCO_UNIX operating sistem. I looked for something like that in info gcc,
> man gcc and I did not find anything!

 Run config.guess (available in the top-level directory of the tools) on
your SCO host system and use the output for target specification when
configuring tools.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
