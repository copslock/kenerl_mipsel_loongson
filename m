Received:  by oss.sgi.com id <S554102AbRAZUYr>;
	Fri, 26 Jan 2001 12:24:47 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:27910 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553783AbRAZUY2>;
	Fri, 26 Jan 2001 12:24:28 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2B44F7FF; Fri, 26 Jan 2001 21:24:24 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5F9A5EE9C; Fri, 26 Jan 2001 21:23:41 +0100 (CET)
Date:   Fri, 26 Jan 2001 21:23:41 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Pete Popov <ppopov@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
Message-ID: <20010126212341.A26384@paradigm.rfc822.org>
References: <200101261815.KAA08917@saturn.mikemac.com> <3A71C3CF.A179113@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A71C3CF.A179113@mvista.com>; from ppopov@mvista.com on Fri, Jan 26, 2001 at 10:37:03AM -0800
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 10:37:03AM -0800, Pete Popov wrote:
> glibc.  Others might have similar toolchains they can point you at. 
> Another option is native builds, which I personally don't like.

Cross compiling is definitly no option for debian as the dependencies
etc are all made from "ldd binary" which has to fail for cross-compiling.
I guess this also happens to rpm packages so cross-compiling to really
get a correct distribution is definitly no option.

The larger the packages are the harder it is to get them cross-compiled
correctly as they run nifty little check programs from configure which
cant work. I guess you had similar problems as all rpms are
"noarch" which is definitly - ummm - interesting.

I definitly go for native builds - Once you have a working stable 
base you can set up debian autobuilders which will do nearly 
everything for you except signing and uploading the package into
the main repository.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
