Received:  by oss.sgi.com id <S42211AbQJIPvl>;
	Mon, 9 Oct 2000 08:51:41 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:18707 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42196AbQJIPvi>;
	Mon, 9 Oct 2000 08:51:38 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id ED3247F7; Mon,  9 Oct 2000 17:51:35 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7EB5F9014; Mon,  9 Oct 2000 17:50:32 +0200 (CEST)
Date:   Mon, 9 Oct 2000 17:50:32 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: BFD: bfd assertion fail elfcode.h:1205
Message-ID: <20001009175032.B7288@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
while building glibc 2.2 for mips with cvs gcc/binutils as
of 20001007 i get the following - multiple times ( >1000 ) when
building the package (probably while stripping the binarys)

BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205
BFD: bfd assertion fail elfcode.h:1205

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
