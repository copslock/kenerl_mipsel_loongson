Received:  by oss.sgi.com id <S553818AbQJ0Cf1>;
	Thu, 26 Oct 2000 19:35:27 -0700
Received: from u-208.karlsruhe.ipdial.viaginterkom.de ([62.180.19.208]:41222
        "EHLO u-208.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553816AbQJ0CfC>; Thu, 26 Oct 2000 19:35:02 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870424AbQJ0Ced>;
        Fri, 27 Oct 2000 04:34:33 +0200
Date:   Fri, 27 Oct 2000 04:34:33 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@mvista.com>
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: userland packages
Message-ID: <20001027043432.F6628@bacchus.dhis.org>
References: <39F8CE01.3782BBF5@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F8CE01.3782BBF5@mvista.com>; from ppopov@mvista.com on Thu, Oct 26, 2000 at 05:36:17PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 26, 2000 at 05:36:17PM -0700, Pete Popov wrote:

> Is there a guide on how to rebuild userland packages from source code? 
> I've installed the cross compiler and can compile a kernel, but when I
> try to build a simple userland app, the compiler can't find libraries,
> include files, etc.

You have to copy all the includes and libraries to
/usr/mips-linux/{include,lib}/, then fixup linker scripts that disguise
themselfes as .so files like libc.so and you can start.

Getting everything to crosscompile is a hard job, I really recomend
native builds.

  Ralf
