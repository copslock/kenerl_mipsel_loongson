Received:  by oss.sgi.com id <S554010AbQLERq4>;
	Tue, 5 Dec 2000 09:46:56 -0800
Received: from u-153-21.karlsruhe.ipdial.viaginterkom.de ([62.180.21.153]:34832
        "EHLO u-153-21.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S554004AbQLERqk>; Tue, 5 Dec 2000 09:46:40 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869880AbQLERqW>;
	Tue, 5 Dec 2000 18:46:22 +0100
Date:	Tue, 5 Dec 2000 18:46:22 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Nicu Popovici <octavp@isratech.ro>
Cc:	linux-mips@oss.sgi.com
Subject: Re: MIPS ext2fs problem.
Message-ID: <20001205184622.A16354@bacchus.dhis.org>
References: <3A2D60BB.311D4ECA@isratech.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A2D60BB.311D4ECA@isratech.ro>; from octavp@isratech.ro on Tue, Dec 05, 2000 at 04:40:11PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Dec 05, 2000 at 04:40:11PM -0500, Nicu Popovici wrote:

> I did port the ATLAS support from linux-2.2.12 kernel into linux-2.2.14
> . I saw that there is a problem, if I reset the computer in an unusual
> way  then at restart it tries to do e2fsck on the hdd. My problem is
> that when I run linux 2.2.14 ( for ATLAS , that we ported ) it get
> stucked in running e2fsck. Do you have any ideea of what is happening ?

Most probably this is a driver or other kernel issues.

  Ralf
