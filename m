Received:  by oss.sgi.com id <S553686AbQJSVTg>;
	Thu, 19 Oct 2000 14:19:36 -0700
Received: from u-176.karlsruhe.ipdial.viaginterkom.de ([62.180.19.176]:24079
        "EHLO u-176.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553724AbQJSVTO>; Thu, 19 Oct 2000 14:19:14 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870174AbQJSUan>;
        Thu, 19 Oct 2000 22:30:43 +0200
Date:   Thu, 19 Oct 2000 22:30:43 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Scott Venier <scott@scooter.cx>
Cc:     linux-mips@oss.sgi.com
Subject: Re: 16K page size?
Message-ID: <20001019223043.B20651@bacchus.dhis.org>
References: <20001018033804.E7865@bacchus.dhis.org> <Pine.LNX.4.21.0010182223050.9148-100000@wopr.scooter.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010182223050.9148-100000@wopr.scooter.cx>; from scott@scooter.cx on Wed, Oct 18, 2000 at 10:24:43PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 18, 2000 at 10:24:43PM -0400, Scott Venier wrote:

> shouldn't most things be safe since alpha uses 8k pages?

I've seen places which had #ifdef __alpha__ instead of conditionals on
the pagesize ...

  Ralf
