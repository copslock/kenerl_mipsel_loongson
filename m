Received:  by oss.sgi.com id <S553728AbQJSVT1>;
	Thu, 19 Oct 2000 14:19:27 -0700
Received: from u-176.karlsruhe.ipdial.viaginterkom.de ([62.180.19.176]:24079
        "EHLO u-176.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553686AbQJSVTM>; Thu, 19 Oct 2000 14:19:12 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870169AbQJSUZB>;
        Thu, 19 Oct 2000 22:25:01 +0200
Date:   Thu, 19 Oct 2000 22:25:01 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20001019222501.A20568@bacchus.dhis.org>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001015021522.B3106@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Sun, Oct 15, 2000 at 02:15:23AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Oct 15, 2000 at 02:15:23AM +0200, Guido Guenther wrote:

I've applied your patches with exception of the debug junk and the
partition ID stuff - the values for the prtition ids exceed the maximum
value and we don't have assigned partition ids anyway.

  Ralf
