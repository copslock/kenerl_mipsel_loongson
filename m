Received:  by oss.sgi.com id <S553690AbQJPAfn>;
	Sun, 15 Oct 2000 17:35:43 -0700
Received: from u-227.karlsruhe.ipdial.viaginterkom.de ([62.180.21.227]:59146
        "EHLO u-227.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553663AbQJPAff>; Sun, 15 Oct 2000 17:35:35 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868867AbQJPAfX>;
        Mon, 16 Oct 2000 02:35:23 +0200
Date:   Mon, 16 Oct 2000 02:35:23 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Bradley D. LaRonde" <brad@ltc.com>
Cc:     Jay Carlson <nop@nop.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com, Mike Klar <mfklar@ponymail.com>
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001016023523.D15377@bacchus.dhis.org>
References: <KEEOIBGCMINLAHMMNDJNEECBCAAA.nop@nop.com> <005e01c035fb$ef883b40$0701010a@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <005e01c035fb$ef883b40$0701010a@ltc.com>; from brad@ltc.com on Sat, Oct 14, 2000 at 12:29:33PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 12:29:33PM -0400, Bradley D. LaRonde wrote:

> I think that optimal for me would be if the tools from SGI worked for both
> hard-float and soft-float, and we didn't have any linux-vr-specific tools.

This is indeed the problem which I see with the softfp patch for libc.
Andreas Jaeger did work on the softfp stuff in glibc 2.2.  I don't know it's
exact status but if for size reasons you want to stick with glibc 2.0 a
backport might be of interest?

Have the other tools - in particular binutils and gcc actually been modified
except maybe changing defaults?

  Ralf
