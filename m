Received:  by oss.sgi.com id <S553939AbQLACHN>;
	Thu, 30 Nov 2000 18:07:13 -0800
Received: from u-3-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.3]:25097
        "EHLO u-3-18.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553936AbQLACHE>; Thu, 30 Nov 2000 18:07:04 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869735AbQLACGT>;
	Fri, 1 Dec 2000 03:06:19 +0100
Date:	Fri, 1 Dec 2000 03:06:19 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: binutils upgrade
Message-ID: <20001201030619.A7444@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Binutils were buggy handling a cases involving empty object files.  I've
uploaded fixed binutils 2.8.1 cross-linker packages to oss.sgi.com;  I'll
upload fixed binutils 2.9.5 binaries (mips64 only) later.  The worarounds
for this bug have been removed from the CVS archive that is updating is
required for building a current 2.4 kernel.

  Ralf
