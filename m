Received:  by oss.sgi.com id <S554036AbQLBEDo>;
	Fri, 1 Dec 2000 20:03:44 -0800
Received: from u-183-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.183]:64009
        "EHLO u-183-19.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553763AbQLBEDW>; Fri, 1 Dec 2000 20:03:22 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869519AbQLBEDG>;
	Sat, 2 Dec 2000 05:03:06 +0100
Date:	Sat, 2 Dec 2000 05:03:06 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Support for smaller glibc
Message-ID: <20001202050306.A12319@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

For the information of the embedded community.

  Ralf

----- Forwarded message from "H . J . Lu" <hjl@valinux.com> -----

Date: Fri, 1 Dec 2000 09:12:35 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: sglibc@external-lists.valinux.com
Subject: Re: Support for smaller glibc

On Fri, Dec 01, 2000 at 02:14:14PM +0100, Ralf Baechle wrote:
> On Tue, Nov 28, 2000 at 04:24:29PM -0800, H . J . Lu wrote:
> 
> > The current glibc 2.2 has many features. But some of them are not
> > needed in some cases. I am wondering if there is an interest to
> > make those features configurabled at the build time. The ones I am
> > thinging now are intl, iconv, iconvdata, locale, localedata, wcsmbs,
> > wctype and wide char IO. They will be enabled by default. But you
> > can disable them at the build time. It will make glibc much smaller.
> > Any comments?
> 
> The MIPS community is shifting more and more into the embedded area; one
> of the increasing pains is glibc's increasing size which makes various
> people continue to maintain glibc 2.0, the oldest and smallest libc for
> MIPS.  So your suggestion is very interesting indeed.
> 
> I just have acknowledge Uli's concerns in this thread; they need to be
> solved.  But forking a smaller libc of standard glibc is nothing but the
> St. Florian's principle ...
> 

Ulrich is refusing to do anything with it. Do you have any suggestions?
I will do my best to do it right. But I am afraid I cannot do it alone.

BTW, please discuss it on sglibc@external-lists.valinux.com.


-- 
H.J. Lu (hjl@valinux.com)

----- End forwarded message -----

  Ralf
