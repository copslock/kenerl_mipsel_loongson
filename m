Received:  by oss.sgi.com id <S553888AbQKCVUb>;
	Fri, 3 Nov 2000 13:20:31 -0800
Received: from u-120.karlsruhe.ipdial.viaginterkom.de ([62.180.10.120]:54546
        "EHLO u-120.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553883AbQKCVUF>; Fri, 3 Nov 2000 13:20:05 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869091AbQKCVT0>;
        Fri, 3 Nov 2000 22:19:26 +0100
Date:   Fri, 3 Nov 2000 22:19:26 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Kernel compiler
Message-ID: <20001103221926.A26082@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Due to compiler bugs with named initializers the use of egcs 1.1.2 has
ben deprecated for Linux; Linux 2.4.0-test10 will refuse to compile with
older compilers.

mips64 users can ignore this message;  they're currently all using egcs 1.1.2
and therefore not affected.

  Ralf
